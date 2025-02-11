Class {
	#name : #RBRemoveSenderMethodParametrizedTest,
	#superclass : #RBWithDifferentsArgumentsParametrizedTest,
	#category : #'Refactoring2-Transformations-Tests-Parametrized'
}

{ #category : #tests }
RBRemoveSenderMethodParametrizedTest class >> testParameters [

	^ ParametrizedTestMatrix new
		addCase: { #rbClass -> RBRemoveSenderRefactoring .
					  #constructor -> #remove:inMethod:forClass: .
					  #index -> 1};
		yourself
]

{ #category : #'failure tests' }
RBRemoveSenderMethodParametrizedTest >> testFailureClassDoesNotExist [

	self shouldFail: (self createRefactoringWithArguments: {
				 {
					 (14 to: 17).
					 #byteAt: }.
				 #methodBefore.
				 #RBMessageSendTransformationTest })
]

{ #category : #'failure tests' }
RBRemoveSenderMethodParametrizedTest >> testFailureIsDirectlyUsed [

	| refactoring |
	refactoring := self createRefactoringWithArguments: {
			               {
				               (58 to: 73).
				               #foo: }.
			               #caller2.
			               #RBClassDataForRefactoringTest }.
	self setupInlineExpressionFor: refactoring toReturn: false.
	self shouldFail: refactoring
]

{ #category : #'failure tests' }
RBRemoveSenderMethodParametrizedTest >> testFailureIsDirectlyUsed2 [

	| refactoring |
	refactoring := self createRefactoringWithArguments: {
			               {
				               (25 to: 39).
				               #isVariable }.
			               #returnsBooleanAndOther.
			               #RBClassDataForRefactoringTest }.
	self setupInlineExpressionFor: refactoring toReturn: false.
	self shouldFail: refactoring
]

{ #category : #'failure tests' }
RBRemoveSenderMethodParametrizedTest >> testFailureMethodDoesNotExist [

	self shouldFail: (self createRefactoringWithArguments: {
				 {
					 (14 to: 17).
					 #foo: }.
				 #badMessage1.
				 #RBClassDataForRefactoringTest })
]

{ #category : #'failure tests' }
RBRemoveSenderMethodParametrizedTest >> testFailureNonExistantSelector [

	self shouldFail: (self createRefactoringWithArguments:
		{{(14 to: 17) . #foo: }.
		#checkClass1: .
		#RBClassDataForRefactoringTest})
]

{ #category : #tests }
RBRemoveSenderMethodParametrizedTest >> testRemoveMessageInsideBlock [

	| refactoring |
	refactoring := self createRefactoringWithArguments:
		{ { (	88 to: 104) .#printString } .
			#caller1 .
			#RBClassDataForRefactoringTest }.

	self setupInlineExpressionFor: refactoring toReturn: false.
	self executeRefactoring: refactoring .

	self assert: ((refactoring model classNamed: #RBClassDataForRefactoringTest) parseTreeForSelector: #caller1) equals: (self parseMethod: 'caller1
	| anObject |
	anObject := 5.
	self called: anObject + 1
		on1:
			[:each |
			^anObject]')
]

{ #category : #tests }
RBRemoveSenderMethodParametrizedTest >> testRemoveSenderIntoCascaded2Message [

	| refactoring transformedMethod afterRefactoring1 afterRefactoring2 |
	afterRefactoring1 := self parseMethod: 'inlineMethod
	| temp |
	self foo.
	temp := self bar.
	^ temp'.
	afterRefactoring2 := self parseMethod: 'inlineMethod
	| temp |
	temp := self
		        foo;
		        bar.
	^ temp'.
	self proceedThroughWarning:
		[ refactoring := self createRefactoringWithArguments:
			{ { (33 to: 62) . #inlineMethod } .
			#inlineMethod .
			#RBClassDataForRefactoringTest}.
		self setupInlineExpressionFor: refactoring toReturn: false.
		self executeRefactoring: refactoring ].
	transformedMethod := ((refactoring model classNamed: #RBClassDataForRefactoringTest)
	parseTreeForSelector: #inlineMethod).
	self assert: (transformedMethod = afterRefactoring1 or: [ transformedMethod = afterRefactoring2])
]

{ #category : #tests }
RBRemoveSenderMethodParametrizedTest >> testRemoveSenderIntoCascaded3Message [

	| refactoring transformedMethod afterRefactoring1 afterRefactoring2 |
	afterRefactoring1 := self parseMethod: 'referencesConditionFor: aClass

	| environment association anObject |
	anObject := RBCondition withBlock: [
		            association := Smalltalk globals
			                           associationAt: aClass name
			                           ifAbsent: [
			                           self refactoringError:
				                           ''Could not find class'' ].
		            environment := (self environment referencesTo:
			                            association)
		                           |
		                           (self environment referencesTo:
			                            aClass name).
		            environment isEmpty ].
	anObject errorMacro: aClass , '' is referenced.<n>Browse references?''.
	^ anObject yourself' .
	afterRefactoring2 := self parseMethod: 'referencesConditionFor: aClass
	| environment association |
	^ (RBCondition withBlock: [
			   association := Smalltalk globals
				                  associationAt: aClass name
				                  ifAbsent: [
					                  self refactoringError: ''Could not find class'' ].
			   environment := (self environment referencesTo: association)
			                  | (self environment referencesTo: aClass name).
			   environment isEmpty ])
		  errorMacro: aClass , '' is referenced.<n>Browse references?'';
		  yourself'.
	self proceedThroughWarning:
		[ refactoring := self createRefactoringWithArguments:
			{{(	63 to: 460) . #errorBlock:}.
				#referencesConditionFor: .
				#RBClassDataForRefactoringTest}.
	self setupInlineExpressionFor: refactoring toReturn: false.
	self executeRefactoring: refactoring ].
	transformedMethod := ((refactoring model classNamed: #RBClassDataForRefactoringTest)
	parseTreeForSelector: #referencesConditionFor:).
	self assert: (transformedMethod = afterRefactoring1 or: [transformedMethod = afterRefactoring2])
]

{ #category : #tests }
RBRemoveSenderMethodParametrizedTest >> testRemoveSenderIntoCascadedMessage [

	| refactoring |
	self proceedThroughWarning:
		[ refactoring := self createRefactoringWithArguments:
			{{(	30 to: 74) . #cr}.
			(#called:, #on:) asSymbol .
			#RBClassDataForRefactoringTest}.
	self setupInlineExpressionFor: refactoring toReturn: false.

	self executeRefactoring: refactoring ].
	self assert: ((refactoring model classNamed: #RBClassDataForRefactoringTest) parseTreeForSelector: (#called:, #on:) asSymbol )
		equals: (self parseMethod: 'called: anObject on: aBlock
			Transcript show: anObject printString.
			aBlock value')
]

{ #category : #tests }
RBRemoveSenderMethodParametrizedTest >> testRemoveSimpleSenderOfMessage [

	| refactoring transformedMethod afterRefactoring1 afterRefactoring2 |
	afterRefactoring1 := self parseMethod: 'caller1
	| anObject arg1 |
	anObject := 5.
	arg1 := anObject + 1'.
	afterRefactoring2 :=  self parseMethod: 'caller1
	| anObject |
	anObject := 5'.
	refactoring := self createRefactoringWithArguments:
			{{(	40 to: 120) . #called:on1:} .
			#caller1 .
			#RBClassDataForRefactoringTest}.
	self setupInlineExpressionFor: refactoring toReturn: false.
	self executeRefactoring: refactoring .
	transformedMethod := ((refactoring model classNamed: #RBClassDataForRefactoringTest) parseTreeForSelector: #caller1) .
	self assert: (transformedMethod = afterRefactoring1 or: [transformedMethod = afterRefactoring2 ])
]
