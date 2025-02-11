Class {
	#name : #FLFilePoolTestResource,
	#superclass : #TestResource,
	#instVars : [
		'directoryPath'
	],
	#category : #'Fuel-Core-Tests-Support-Resources'
}

{ #category : #testing }
FLFilePoolTestResource >> fileExists: aString [
	^ (self filePathString: aString) asFileReference exists
]

{ #category : #'accessing-files' }
FLFilePoolTestResource >> filePathString: aString [
	^ (directoryPath asFileReference / aString) pathString
]

{ #category : #'accessing-files' }
FLFilePoolTestResource >> readStreamForFilePath: aString [
	^ (File named: (self filePathString: aString)) readStream
		  binary;
		  yourself
]

{ #category : #running }
FLFilePoolTestResource >> setUp [
	super setUp.
	
	directoryPath := (FileLocator temp / UUID new asString) ensureCreateDirectory pathString
]

{ #category : #running }
FLFilePoolTestResource >> tearDown [
	directoryPath asFileReference deleteAll.

	super tearDown
]

{ #category : #'accessing-files' }
FLFilePoolTestResource >> writeStreamForFilePath: aString [
	^ (File named: (self filePathString: aString)) writeStream
		  binary;
		  yourself
]
