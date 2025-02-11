"
Recompile
"
Class {
	#name : #GoferRecompile,
	#superclass : #GoferWorking,
	#category : #'Gofer-Core-Operations'
}

{ #category : #running }
GoferRecompile >> execute [

	self workingCopies
		do: [ :each | self execute: each ]
]

{ #category : #running }
GoferRecompile >> execute: aWorkingCopy [

	aWorkingCopy packageSet methods
		do: [ :each | each methodClass recompile: each selector ]
]
