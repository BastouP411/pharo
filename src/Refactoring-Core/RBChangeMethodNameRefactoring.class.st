"
I am an abstract base class for refactorings changing a method name.

Doing a method rename involves:
- rename implementors
- rename message sends and
- remove renamed implementors.

I implement the above precedures and provide helper functions for finding and renaming references.
Every concrete subclass has to add its own precondition (see `myPrecondition`).

"
Class {
	#name : #RBChangeMethodNameRefactoring,
	#superclass : #RBMethodRefactoring,
	#instVars : [
		'newSelector',
		'oldSelector',
		'permutation',
		'implementors',
		'renameMap'
	],
	#category : #'Refactoring-Core-Refactorings'
}

{ #category : #testing }
RBChangeMethodNameRefactoring class >> isAbstract [

	^ self == RBChangeMethodNameRefactoring
]

{ #category : #support }
RBChangeMethodNameRefactoring >> convertAllReferencesTo: aSymbol of: classes using: searchReplacer [
	(self model allReferencesTo: aSymbol in: classes)
		do:
			[:method |
			self
				convertMethod: method selector
				for: method modelClass
				using: searchReplacer]
]

{ #category : #support }
RBChangeMethodNameRefactoring >> convertAllReferencesTo: aSymbol using: searchReplacer [

	(self model allReferencesTo: aSymbol)
		reject: [ :rbMethod | "We reject methods from trait to not recompile them in the class and duplicate the code."
			rbMethod method
				ifNil: [ false ]
				ifNotNil: #isFromTrait ]
		thenDo: [ :method | self convertMethod: method selector for: method modelClass using: searchReplacer ]
]

{ #category : #preconditions }
RBChangeMethodNameRefactoring >> doesNotOverrideExistingMethodPrecondition [
	"Check that the new selector is not already defined in superclasses"
	
	^ self implementors
		inject: RBCondition true 
		into: [ :condition :each |
			condition & (RBCondition hierarchyOf: each canUnderstand: newSelector) not ]
]

{ #category : #testing }
RBChangeMethodNameRefactoring >> hasPermutedArguments [
	oldSelector numArgs = newSelector numArgs ifFalse: [^true].
	1 to: oldSelector numArgs
		do: [:i | (permutation at: i) = i ifFalse: [^true]].
	^false
]

{ #category : #private }
RBChangeMethodNameRefactoring >> implementors [

	implementors ifNil: [ implementors := self model allImplementorsOf: oldSelector ].
	^ implementors
]

{ #category : #testing }
RBChangeMethodNameRefactoring >> implementorsCanBePrimitives [
	^false
]

{ #category : #preconditions }
RBChangeMethodNameRefactoring >> isValidMethodNamePrecondition [
	^ (RBCondition isValidMethodName: newSelector for: class)

	
]

{ #category : #private }
RBChangeMethodNameRefactoring >> modifyImplementorParseTree: parseTree in: aClass [
	| oldArgs |
	oldArgs := parseTree arguments.
	parseTree renameSelector: newSelector andArguments: (permutation collect: [:each | oldArgs at: each])
]

{ #category : #preconditions }
RBChangeMethodNameRefactoring >> myConditions [
	"^self subclassResponsibility"
]

{ #category : #accessing }
RBChangeMethodNameRefactoring >> newSelector [
	^ newSelector
]

{ #category : #accessing }
RBChangeMethodNameRefactoring >> newSelector: aSymbol [
	newSelector := aSymbol
]

{ #category : #accessing }
RBChangeMethodNameRefactoring >> newSelectorString [ 
	^ self buildSelectorString: newSelector
				withPermuteMap: permutation
]

{ #category : #private }
RBChangeMethodNameRefactoring >> parseTreeRewriter [
	| rewriteRule oldString newString |
	
	oldString := self buildSelectorString: oldSelector.
	newString := self newSelectorString.
	
	rewriteRule := self parseTreeRewriterInstance.
	rewriteRule replace: '``@object ' , oldString
		with: '``@object ' , newString.
	^rewriteRule
]

{ #category : #parsing }
RBChangeMethodNameRefactoring >> parseTreeRewriterInstance [

	^ self parseTreeRewriterClass new
]

{ #category : #accessing }
RBChangeMethodNameRefactoring >> permutation: anObject [

	permutation := anObject
]

{ #category : #preconditions }
RBChangeMethodNameRefactoring >> preconditions [
	"This refactoring only preserves behavior if all implementors are renamed."

	| conditions |
	conditions := self myConditions
	              & (RBCondition definesSelector: oldSelector in: class)
	              & self isValidMethodNamePrecondition.

	^ conditions & self doesNotOverrideExistingMethodPrecondition
]

{ #category : #transforming }
RBChangeMethodNameRefactoring >> removeRenamedImplementors [
	oldSelector = newSelector
		ifTrue: [ ^ self ].
	self implementors
		do: [ :each | each removeMethod: oldSelector ]
]

{ #category : #action }
RBChangeMethodNameRefactoring >> renameArgumentsIn: parseTree [
	self renameMap do: [ :arg |
		(self parseTreeRewriterClass rename: arg name to: arg newName) executeTree: parseTree
	]
]

{ #category : #transforming }
RBChangeMethodNameRefactoring >> renameImplementors [

	self implementors
		do: [ :each |
			| parseTree |

			parseTree := each parseTreeForSelector: oldSelector.
			parseTree ifNil: [ self refactoringError: 'Could not parse source code.' ].
			self implementorsCanBePrimitives
				ifFalse: [ parseTree isPrimitive
						ifTrue: [ self
								refactoringError:
									( '<1p>''s implementation of #<2s> is a primitive' expandMacrosWith: each with: oldSelector )
							]
					].
			self modifyImplementorParseTree: parseTree in: each.
			( each methodFor: oldSelector ) compileTree: parseTree
			]
]

{ #category : #accessing }
RBChangeMethodNameRefactoring >> renameMap [
	^renameMap ifNil: [ renameMap := { } ]
]

{ #category : #accessing }
RBChangeMethodNameRefactoring >> renameMap: aColl [
	renameMap := aColl
]

{ #category : #transforming }
RBChangeMethodNameRefactoring >> renameMessageSends [
	self convertAllReferencesTo: oldSelector using: self parseTreeRewriter
]

{ #category : #transforming }
RBChangeMethodNameRefactoring >> renameMessageSendsIn: classes [
	self convertAllReferencesTo: oldSelector of: classes using: self parseTreeRewriter
]

{ #category : #initialization }
RBChangeMethodNameRefactoring >> renameMethod: aSelector in: aClass [
	"Watch out this is for partial configuration of the refactoring"

	oldSelector := aSelector asSymbol.
	class := self classObjectFor: aClass.
	
]

{ #category : #initialization }
RBChangeMethodNameRefactoring >> renameMethod: aSelector in: aClass to: newSel permutation: aMap [
	
	self renameMethod: aSelector asSymbol in: aClass.
	newSelector := newSel asSymbol.
	permutation := aMap
]

{ #category : #transforming }
RBChangeMethodNameRefactoring >> transform [
	self renameImplementors.
	self renameMessageSends.
	self removeRenamedImplementors
]
