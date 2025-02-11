"
I model self, super, thisContext, and thisProcess
"
Class {
	#name : #PseudoVariable,
	#superclass : #Variable,
	#instVars : [
		'environment'
	],
	#category : #'Kernel-Variables'
}

{ #category : #'class initialization' }
PseudoVariable class >> initialize [

	self deprecatedAliases: { #ReservedVariable }
]

{ #category : #accessing }
PseudoVariable class >> instance [
	self deprecated: 'use new to get a new instance or #lookupVar: for the shared instance'.
	^self new.
]

{ #category : #testing }
PseudoVariable class >> isAbstract [
	^self = PseudoVariable
]

{ #category : #compiler }
PseudoVariable class >> lookupDictionary [
	"create a loopup table name -> instance for Semantic Analysis"

	^ (self subclasses collect: [ :class |
		   | instance |
		   instance := class new.
		   instance name -> instance ]) asDictionary
]

{ #category : #accessing }
PseudoVariable class >> variableName [
	^self subclassResponsibility
]

{ #category : #converting }
PseudoVariable >> asDoItVariableFrom: aContext [
	^ DoItVariable fromContext: aContext variable: self
]

{ #category : #converting }
PseudoVariable >> asString [

	^ self name
]

{ #category : #'code generation' }
PseudoVariable >> emitStore: methodBuilder [

	self shouldNotImplement
]

{ #category : #initialization }
PseudoVariable >> initialize [
	environment := Smalltalk globals.
	name := self class variableName
]

{ #category : #testing }
PseudoVariable >> isPseudoVariable [
	^true
]

{ #category : #testing }
PseudoVariable >> isWritable [
	^ false
]

{ #category : #accessing }
PseudoVariable >> name: aSymbol [
	"names of ReservedVariables are fixed and can not be changed"
	self shouldNotImplement
]

{ #category : #printing }
PseudoVariable >> printOn: stream [

	stream nextPutAll: self name
]

{ #category : #accessing }
PseudoVariable >> scope [
	^ environment
]

{ #category : #queries }
PseudoVariable >> usingMethods [
	"first call is very slow as it creates all ASTs"
	^environment allMethods select: [ : method |
		method ast variableNodes anySatisfy: [ :varNode | varNode variable == self]]
]

{ #category : #debugging }
PseudoVariable >> write: aValue inContext: aContext [

	self error: name, ' is a read-only variable and cant be modified'
]
