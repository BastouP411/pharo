"
I am the state corresponding to a tab being disabled.
"
Class {
	#name : #TabDisabledState,
	#superclass : #TabState,
	#category : #'Morphic-Widgets-Tabs-States'
}

{ #category : #'class initialization' }
TabDisabledState class >> initialize [

	self deprecatedAliases: { #TabDisabled }
]

{ #category : #protocol }
TabDisabledState >> backgroundColor [
	^ Smalltalk ui theme disabledColor
]

{ #category : #protocol }
TabDisabledState >> isEnabledMatchingTheState: aBoolean [

	^ aBoolean not
]

{ #category : #protocol }
TabDisabledState >> isSelectedMatchingTheState: aBoolean [

	^ aBoolean not
]

{ #category : #protocol }
TabDisabledState >> newStateForEnabled: aBoolean [

	^ TabEnabledState tab: self tab
]

{ #category : #protocol }
TabDisabledState >> newStateForSelected: aBoolean [
	"An disabled tab can not be selected"

	^ self
]
