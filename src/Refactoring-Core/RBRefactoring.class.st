"
I am the abstract base class for refactoring operations. 

I define the common workflow for a refactoring:
check precondition, 
primitive execute - a dry run collecting the changes without applying them,
and execute - run and apply changes.

I provide many utility methods used by my subclasses. 
Every  concrete subclass implements a single refactoring. They have to implement the methods
preconditions and transform.


Instance Variables

options:
Some refactorings may need user interactions or some extra data for performing
the operation, the code for requesting this data is stored in a block associated with a ""refacotring option""
(see RBRefactoring>>#setOption:toUse:  and RBRefactoring class>>#initializeRefactoringOptions).

model:
My model - a RBNamespace - defines the environment in which my refactoring is applied and collects all changes (RBRefactoryChange).

A RBRefactoringManager  is used to collect the executed refactorings and provides an undo and redo facility.

"
Class {
	#name : #RBRefactoring,
	#superclass : #RBAbstractTransformation,
	#category : #'Refactoring-Core-Refactorings'
}

{ #category : #testing }
RBRefactoring class >> isAbstract [

	^ self == RBRefactoring
]

{ #category : #'accessing signal' }
RBRefactoring class >> preconditionSignal [
	^ RBRefactoringError , RBRefactoringWarning
]

{ #category : #converting }
RBRefactoring >> asRefactoring [
	^ self
]

{ #category : #utilities }
RBRefactoring >> associationForClassVariable: aName in: aClass ifAbsent: aBlock [
	"Return the class variable association of class aClass"

	^aClass realClass classPool associationAt: aName asSymbol
		ifAbsent: [aClass realClass classPool associationAt: aName asString ifAbsent: aBlock]
]

{ #category : #testing }
RBRefactoring >> canReferenceVariable: aString in: aClass [
	(aClass definesVariable: aString) ifTrue: [^true].
	(self model includesGlobal: aString asSymbol) ifTrue: [^true].
	^(self poolVariableNamesFor: aClass) includes: aString
]

{ #category : #support }
RBRefactoring >> checkClass: aRBClass selector: aSelector using: aMatcher [
	| parseTree |
	parseTree := aRBClass parseTreeForSelector: aSelector.
	parseTree ifNotNil: [aMatcher executeTree: parseTree].
	^aMatcher answer
]

{ #category : #preconditions }
RBRefactoring >> checkPreconditions [

	| conditions block |
	conditions := self preconditions.
	conditions check ifTrue: [ ^ self ].
	block := conditions errorBlock.
	block
		ifNotNil: [
		self refactoringWarning: conditions errorString with: block ]
		ifNil: [ self refactoringError: conditions errorString ]
]

{ #category : #private }
RBRefactoring >> classObjectFor: anObject [

	(anObject isBehavior or: [ anObject isTrait ]) ifTrue: [
		^ self model classFor: anObject ].
	anObject isString ifTrue: [
		^ self model classNamed: anObject asSymbol ].
	^ anObject
]

{ #category : #support }
RBRefactoring >> convertAllReferencesToClass: aRBClass using: searchReplacer [
	self model allReferencesToClass: aRBClass
		do:
			[:method |
			self
				convertMethod: method selector
				for: method modelClass
				using: searchReplacer]
]

{ #category : #support }
RBRefactoring >> convertClasses: classSet select: aBlock using: searchReplacer [
	classSet do:
			[:aClass |
			(aBlock value: aClass) do:
					[:selector |
					self
						convertMethod: selector
						for: aClass
						using: searchReplacer]]
]

{ #category : #accessing }
RBRefactoring >> copyOptionsFrom: aDictionary [
	| dict |
	dict := self options.
	dict == self class refactoringOptions
		ifTrue: [^self options: aDictionary copy].
	dict keysAndValuesDo:
			[:key :value |
			value == (self class refactoringOptions at: key ifAbsent: [nil])
				ifTrue: [ dict at: key put: (aDictionary at: key) ]].
	(aDictionary keys difference: dict keys) do:
		[ :e | dict at: e put: (aDictionary at: e) ].
	self options: dict
]

{ #category : #transforming }
RBRefactoring >> generateChangesFor: aRefactoring [
	"I will generate changes and save them in the model, BUT I will not apply them!
	Use me when a refactorings is composed of multiple other refactorings"

	"Execute the argument but passing the receiver options to that refactoring"
	aRefactoring copyOptionsFrom: self options.
	aRefactoring primitiveExecute
]

{ #category : #transforming }
RBRefactoring >> model [

	^ model
		ifNil: [ model := ( RBClassModelFactory rbNamespace onEnvironment: self defaultEnvironment )
				name: self printString;
				yourself
			]
		ifNotNil: [ model ]
]

{ #category : #private }
RBRefactoring >> onError: aBlock do: errorBlock [
	^aBlock on: self class preconditionSignal
		do:
			[:ex |
			errorBlock cull: ex.
			ex return: nil]
]

{ #category : #private }
RBRefactoring >> primitiveExecute [
	
	self checkPreconditions.
	self transform
]

{ #category : #removing }
RBRefactoring >> removeReturnsOf: parseTree [
	| rewriter |
	rewriter := self parseTreeRewriter.
	rewriter replace: '^``@object' with: '``@object'.
	(rewriter executeTree: parseTree)
		ifTrue: [ ^ rewriter tree].
	^ parseTree
]

{ #category : #utilities }
RBRefactoring >> safeMethodNameFor: aClass basedOn: aString [
	"Creates an unused method name containing aString"

	| baseString newString hasParam i |
	baseString := aString copy.
	baseString at: 1 put: baseString first asLowercase.
	newString := baseString.
	hasParam := newString last = $:.
	hasParam ifTrue: [
		baseString := newString copyFrom: 1 to: newString size - 1 ].
	i := 0.
	[ aClass hierarchyDefinesMethod: newString asSymbol ] whileTrue: [
		i := i + 1.
		newString := baseString , i printString , (hasParam
			              ifTrue: [ ':' ]
			              ifFalse: [ '' ]) ].
	^ newString asSymbol
]

{ #category : #private }
RBRefactoring >> safeVariableNameFor: aClass temporaries: allTempVars basedOn: aString [
	| baseString i newString |
	newString := baseString := aString.
	i := 0.
	[ (allTempVars includes: newString) or: [ aClass definesInstanceVariable: newString ] ]
		whileTrue: [
			i := i + 1.
			newString := baseString , i printString ].
	^ newString
]

{ #category : #accessing }
RBRefactoring >> setOption: aSymbol toUse: aBlock [
	| dict |
	dict := self options.
	dict == self class refactoringOptions ifTrue: [dict := dict copy].
	dict at: aSymbol put: aBlock.
	self options: dict
]

{ #category : #private }
RBRefactoring >> uniqueMethodNameFor: anInteger [
	| before after index name |
	before := 'a'.
	after := ''.
	anInteger timesRepeat: [after := after , 'z:'].
	index := 0.

	[name := before , index printString , after.
	(Symbol findInterned: name) notNil]
			whileTrue: [index := index + 1].
	^name asSymbol
]

{ #category : #utilities }
RBRefactoring >> whichVariableNode: aParseTree inInterval: anInterval name: aName [
	| matcher block |
	matcher := self parseTreeSearcher.
	block := [ :aNode :answer |
	(aNode intersectsInterval: anInterval)
		ifTrue: [ aNode ]
		ifFalse: [ answer ] ].
	matcher
		matches: aName do: block;
		matchesArgument: aName do: block.
	^ matcher executeTree: aParseTree initialAnswer: nil
]
