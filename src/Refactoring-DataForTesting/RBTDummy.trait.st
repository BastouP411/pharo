Trait {
	#name : #RBTDummy,
	#instVars : [
		'var1'
	],
	#category : #'Refactoring-DataForTesting-Utils'
}

{ #category : #'tests - some' }
RBTDummy >> methodFromTrait [
	RBClassToRename justForTest
]

{ #category : #accessing }
RBTDummy >> var1 [
	^ var1
]
