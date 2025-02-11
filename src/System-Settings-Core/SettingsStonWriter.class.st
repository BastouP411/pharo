"
I am a writer of system settings to a file (stream). I know how to write the settings into a stream.

Collaborators: SystemSettingsPersistence

Public API and Key Messages

- stream:
- store 

Internal Representation and Key Implementation Points.

    Instance Variables
	storedSettings:		<Array>
	stream:				<WriteStream>

"
Class {
	#name : #SettingsStonWriter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'storedSettings'
	],
	#category : #'System-Settings-Core-Persistence-Ston-StoredSettings-Builder'
}

{ #category : #adding }
SettingsStonWriter >> addSetting: aStoredSetting [
	storedSettings add: aStoredSetting
]

{ #category : #adding }
SettingsStonWriter >> addSettings: aCollectionOfStoredSettings [
	storedSettings addAll: aCollectionOfStoredSettings
]

{ #category : #initialization }
SettingsStonWriter >> initialize [
	super initialize.
	storedSettings := OrderedCollection new
]

{ #category : #actions }
SettingsStonWriter >> store [
	"Write the stored setting in the stream"

	| filteredStoredSettings |
	stream ifNil: [ ^ self ].

	"The settings with default values are not stored"
	filteredStoredSettings := storedSettings reject: [ :aStoredSetting | aStoredSetting hasDefaultValue ].

	STON writer
		on: stream;
		prettyPrint: true;
		asciiOnly: true;
		nextPut: filteredStoredSettings asArray
]

{ #category : #accessing }
SettingsStonWriter >> stream [
	"Return the stream on which storedSettings are written in.
	This method is useful for testing"
	^ stream
]

{ #category : #accessing }
SettingsStonWriter >> stream: aWriteStream [
	stream := aWriteStream
]
