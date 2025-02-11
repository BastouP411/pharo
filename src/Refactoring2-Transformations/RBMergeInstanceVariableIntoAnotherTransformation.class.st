Class {
	#name : #RBMergeInstanceVariableIntoAnotherTransformation,
	#superclass : #RBRenameVariableTransformation,
	#category : #'Refactoring2-Transformations-Model-Migrated-Unused'
}

{ #category : #preconditions }
RBMergeInstanceVariableIntoAnotherTransformation >> applicabilityConditions [

	class := self model classObjectFor: className.

	^ (RBCondition withBlock: [
		   variableName = newVariableName ifTrue: [
			   self refactoringError: 'The variable merged must be different' ].
		   true ]) & (isClassVariable
		   ifTrue: [
			   (RBCondition isMetaclass: class) not
			   &
			   (RBCondition
				    definesClassVariable: newVariableName asString
				    in: class)
			   &
			   (RBCondition
				    definesClassVariable: variableName asString
				    in: class) ]
		   ifFalse: [
			   (RBCondition definesInstanceVariable: newVariableName in: class)
			   & (RBCondition definesInstanceVariable: variableName in: class) ])
	  & self isNotGlobal
]

{ #category : #preconditions }
RBMergeInstanceVariableIntoAnotherTransformation >> preconditions [

	^ self applicabilityConditions 
]

{ #category : #executing }
RBMergeInstanceVariableIntoAnotherTransformation >> privateTransform [

	self renameReferences.
	isClassVariable
	ifTrue: [ self definingClass removeClassVariable: variableName ifAbsent: [ ^ self ] ]
	ifFalse: [ self definingClass removeInstanceVariable: variableName ifAbsent: [ ^ self ] ]
]
