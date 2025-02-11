"
I am a command to push up given methods
"
Class {
	#name : #SycPushUpMethodCommand,
	#superclass : #SysRefactoringMethodCommand,
	#instVars : [
		'refactoringScopes'
	],
	#category : #'SystemCommands-MethodCommands'
}

{ #category : #execution }
SycPushUpMethodCommand >> asRefactorings [

	self shouldNotImplement
]

{ #category : #accessing }
SycPushUpMethodCommand >> defaultMenuIconName [
	^ #up
]

{ #category : #accessing }
SycPushUpMethodCommand >> defaultMenuItemName [
	^'Push up'
]

{ #category : #execution }
SycPushUpMethodCommand >> executeRefactorings [

	(RBPushUpMethodDriver
		 model: model
		 scopes: refactoringScopes
		 pushUp: methods) execute
]

{ #category : #testing }
SycPushUpMethodCommand >> isComplexRefactoring [

	^ false
]

{ #category : #execution }
SycPushUpMethodCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	refactoringScopes := aToolContext refactoringScopes
]
