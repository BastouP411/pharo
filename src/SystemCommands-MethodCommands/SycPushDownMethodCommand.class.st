"
I am a command to push down given methods
"
Class {
	#name : #SycPushDownMethodCommand,
	#superclass : #SysRefactoringMethodCommand,
	#instVars : [
		'refactoringScopes'
	],
	#category : #'SystemCommands-MethodCommands'
}

{ #category : #execution }
SycPushDownMethodCommand >> asRefactorings [

	^ self shouldNotImplement
]

{ #category : #accessing }
SycPushDownMethodCommand >> defaultMenuIconName [
	^ #down
]

{ #category : #accessing }
SycPushDownMethodCommand >> defaultMenuItemName [
	^'Push down'
]

{ #category : #execution }
SycPushDownMethodCommand >> executeRefactorings [

	(RBPushDownMethodDriver
		model: model
		scopes: refactoringScopes
		pushDown: methods) execute
]

{ #category : #testing }
SycPushDownMethodCommand >> isComplexRefactoring [

	^ false
]

{ #category : #execution }
SycPushDownMethodCommand >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext.
	refactoringScopes := aToolContext refactoringScopes
]
