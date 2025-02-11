"
I represent a single key press, the simplest key combination.

I match with a keyboard event when that event key is the same as me and the key event is not modified.

To create a single key combination use the #asShortcut message. Like for example:

$a asShortcut
"
Class {
	#name : #KMSingleKeyCombination,
	#superclass : #KMKeyCombination,
	#instVars : [
		'key'
	],
	#classInstVars : [
		'specialKeys'
	],
	#category : #'Keymapping-KeyCombinations'
}

{ #category : #'instance creation' }
KMSingleKeyCombination class >> from: aCharacterOrInteger [
	| aCharacter |
	aCharacter := aCharacterOrInteger asCharacter.

	^ (KeyboardKey fromCharacter: aCharacter) asKeyCombination
]

{ #category : #accessing }
KMSingleKeyCombination class >> specialKeys [
	^specialKeys
		ifNil: [ specialKeys :=
				{1->'home'.
				3->'enter'.
				4->'end'.
				8->'backspace'.
				9-> 'tab'.
				11->'page up'.
				12->'page down'.
				27->'escape'.
				28->'left arrow'.
				29->'right arrow'.
				30->'up arrow'.
				31->'down arrow'.
				127->'delete'
				} asDictionary.]
]

{ #category : #comparing }
KMSingleKeyCombination >> = aShortcut [
	^ super = aShortcut and: [ aShortcut key = key ]
]

{ #category : #comparing }
KMSingleKeyCombination >> hash [
	^ key hash
]

{ #category : #accessing }
KMSingleKeyCombination >> key [
	^ key
]

{ #category : #accessing }
KMSingleKeyCombination >> key: aKeyString [
	key := aKeyString
]

{ #category : #matching }
KMSingleKeyCombination >> matchesEvent: aKeyboardEvent [
	^ self key asLowercase = aKeyboardEvent modifiedCharacter asLowercase
]

{ #category : #combining }
KMSingleKeyCombination >> modifiedBy: aModifier [
	^ KMModifiedKeyCombination modifier: aModifier character: self
]

{ #category : #accessing }
KMSingleKeyCombination >> modifier [

	^ KMNoModifier new
]

{ #category : #accessing }
KMSingleKeyCombination >> name [
	^ self key name
]

{ #category : #'accessing - platform' }
KMSingleKeyCombination >> platformCharacter [

	^ key
]

{ #category : #'accessing - platform' }
KMSingleKeyCombination >> platformModifier [

	^ self modifier
]

{ #category : #printing }
KMSingleKeyCombination >> prettyPrintOn: aStream [

	self printOn: aStream
]

{ #category : #printing }
KMSingleKeyCombination >> printOn: aStream [
	aStream nextPutAll: self name
]
