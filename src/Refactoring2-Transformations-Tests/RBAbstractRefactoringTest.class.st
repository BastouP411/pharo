Class {
	#name : #RBAbstractRefactoringTest,
	#superclass : #RBAbstractEnvTestCase,
	#instVars : [
		'rbClass'
	],
	#category : #'Refactoring2-Transformations-Tests-Parametrized'
}

{ #category : #accessing }
RBAbstractRefactoringTest >> constructor [
]

{ #category : #helpers }
RBAbstractRefactoringTest >> createRefactoringWithArguments: aParameterCollection [
	^ (rbClass perform: self constructor
			withArguments: aParameterCollection) asRefactoring
]

{ #category : #helpers }
RBAbstractRefactoringTest >> createRefactoringWithModel: aRBNamespace andArguments: aParameterCollection [
	^ (rbClass perform: #model: , self constructor
			withArguments: {aRBNamespace} , aParameterCollection) asRefactoring
]

{ #category : #parsing }
RBAbstractRefactoringTest >> executeRefactoring: aRefactoring [
	aRefactoring primitiveExecute
]

{ #category : #parsing }
RBAbstractRefactoringTest >> executeRefactorings: aRefactoringColl [
	aRefactoringColl do: [ :ref | ref primitiveExecute]
]

{ #category : #tests }
RBAbstractRefactoringTest >> methodSignatureStringForSymbol: aSymbol withArgumentString: aString [
	"The method is written this way to make sure that we can rename test input (methods) and do not break the tests."
	
	^ aSymbol asString, aString, Character cr asString
]

{ #category : #tests }
RBAbstractRefactoringTest >> methodSignatureStringForUnarySymbol: aSymbol [
	"The method is written this way to make sure that we can rename test input (methods) and do not break the tests."
	
	^ aSymbol asString, Character cr asString
]

{ #category : #helpers }
RBAbstractRefactoringTest >> objectClassVariable [
	^Object classPool keys detect: [:each | true]
]

{ #category : #parsing }
RBAbstractRefactoringTest >> parseExpression: aString [
	^ self parserClass parseExpression: aString
]

{ #category : #parsing }
RBAbstractRefactoringTest >> parseMethod: aString [
	^ self parserClass parseMethod: aString
]

{ #category : #parsing }
RBAbstractRefactoringTest >> parserClass [
	^ RBParser
]

{ #category : #actions }
RBAbstractRefactoringTest >> proceedThroughWarning: aBlock [
	aBlock on: RBRefactoringWarning do: [ :ex | ex resume ]
]

{ #category : #accessing }
RBAbstractRefactoringTest >> rbClass: anObject [

	rbClass := anObject
]

{ #category : #running }
RBAbstractRefactoringTest >> setUp [
	super setUp.
	model := self defaultNamespaceClass new
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupExtractionClassFor: aRefactoring toReturn: aClass [
	| options |
	options := aRefactoring options copy.
	options at: #extractionClass
		put: [:ref | aClass].
	aRefactoring options: options
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupImplementorToInlineFor: aRefactoring toReturn: anObject [
	| options |
	options := aRefactoring options copy.
	options at: #implementorToInline put: [:ref :imps | anObject].
	aRefactoring options: options
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupInlineExpressionFor: aRefactoring toReturn: aBoolean [
	| options |
	options := aRefactoring options copy.
	options at: #inlineExpression put: [:ref :string | aBoolean].
	aRefactoring options: options
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupMethodNameFor: aRefactoring toReturn: aSelector [

	| options |
	options := aRefactoring options copy.
	options at: #methodName
		put:
			[:aMethodName :ref |
			aMethodName
				selector: aSelector;
				yourself].
	aRefactoring options: options
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupMethodNameFor: aRefactoring toReturn: aSelector withArguments: stringCollection [

	| options |
	options := aRefactoring options copy.
	options at: #methodName
		put:
			[ :aMethodName :ref |
			aMethodName
				selector: aSelector;
				arguments: stringCollection;
				yourself].
	aRefactoring options: options
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupSearchInAllHierarchyFor: aRefactoring toReturn: aBoolean [

	| options |
	options := aRefactoring options copy.
	options at: #searchInWholeHierarchy put: [ :ref :cls | aBoolean ].
	aRefactoring options: options
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupSelfArgumentNameFor: aRefactoring toReturn: aString [

	| options |
	options := aRefactoring options copy.
	options at: #selfArgumentName put: [:ref | aString].
	aRefactoring options: options
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupShouldUseExistingMethodFor: aRefactoring toReturn: aBoolean [

	| options |
	options := aRefactoring options copy.
	options at: #useExistingMethod put: [ :ref :cls | aBoolean ].
	aRefactoring options: options
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupVariableToMoveToFor: aRefactoring toReturn: aString [

	| options |
	options := aRefactoring options copy.
	options at: #selectVariableToMoveTo put: [:ref :class :selector | aString].
	aRefactoring options: options
]

{ #category : #'set up' }
RBAbstractRefactoringTest >> setupVariableTypesFor: aRefactoring toReturn: anObject [

	| options |
	options := aRefactoring options copy.
	options at: #variableTypes put: [:ref :ignore1 :ignore2 | anObject].
	aRefactoring options: options
]

{ #category : #actions }
RBAbstractRefactoringTest >> shouldFail: aRefactoring [

	self proceedThroughWarning: [
		self
			should: [ aRefactoring primitiveExecute ]
			raise: RBRefactoringError
	]
]

{ #category : #actions }
RBAbstractRefactoringTest >> shouldWarn: aRefactoringColl [
	self
		should: [ self executeRefactoring: aRefactoringColl ]
		raise: RBRefactoringWarning
]

{ #category : #actions }
RBAbstractRefactoringTest >> shouldntWarn: aRefactoring [
	self
		shouldnt: [ self executeRefactoring: aRefactoring ]
		raise: RBRefactoringWarning
]

{ #category : #tests }
RBAbstractRefactoringTest >> testConditions [
	| condition newCondition |
	condition := RBCondition new
				block: [false]
				errorString: 'false'.
	condition errorMacro: '<1?true:false>'.
	self deny: condition check.
	self assert: condition errorString equals: 'false'.
	self assert: condition not check.
	self deny: (condition not & condition) check.
	self assert: (condition & condition) not check.
	self assert: (condition | condition not) check.
	self deny: (newCondition := condition | condition) check.
	self assert: newCondition errorString equals: 'false AND false'.
	self assert: (condition not | condition not) check.
	self deny: (newCondition := condition & condition) check.
	self assert: newCondition errorString equals: 'false'.
	self assert: (condition not & condition not) check.
	self assert: (condition & condition) errorString equals: 'false OR false'
]
