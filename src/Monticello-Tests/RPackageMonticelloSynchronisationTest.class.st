"
SUnit tests for RPackage Monticello synchronization
"
Class {
	#name : #RPackageMonticelloSynchronisationTest,
	#superclass : #RPackageMCSynchronisationTest,
	#category : #'Monticello-Tests-RPackage'
}

{ #category : #'tests - operations on MCPackages' }
RPackageMonticelloSynchronisationTest >> testAddMCPackageCreatesAPackage [
	"test that when we create a MCPackage, a corresponding package is created"

	MCWorkingCopy ensureForPackageNamed: #Zork packageOrganizer: self organizer.
	self assert: (self organizer hasPackage: #Zork)
]

{ #category : #'tests - operations on MCPackages' }
RPackageMonticelloSynchronisationTest >> testAddMCPackageForCategoryAlreadyExistingDoesNotCreateAPackage [
	"test that when we create a MCPackage and that a category of this name already exists, no package is created"

	| tmpPackage |
	testingEnvironment organization addCategory: 'Zork'.
	tmpPackage := self organizer packageNamed: #Zork.
	MCWorkingCopy ensureForPackageNamed: #Zork packageOrganizer: self organizer.
	self assert: tmpPackage identicalTo: (self organizer packageNamed: #Zork)
]

{ #category : #'tests - operations on MCPackages' }
RPackageMonticelloSynchronisationTest >> testUnloadMCPackageRemovesRPackage [
	"test that when we remove a MC Package, the corresponding RPackage is removed from the organizer"

	MCWorkingCopy ensureForPackageNamed: 'XXXXX' packageOrganizer: self organizer.
	(self allWorkingCopies detect: [ :each | each packageName = 'XXXXX' ]) unload.

	self deny: (self organizer hasPackage: #XXXXX)
]

{ #category : #'tests - operations on MCPackages' }
RPackageMonticelloSynchronisationTest >> testUnregisterMCPackageKeepsRPackage [
	"test that when we remove a MC Package, the corresponding RPackage is removed from the organizer"

	MCWorkingCopy ensureForPackageNamed: 'XXXXX' packageOrganizer: self organizer.
	(self allWorkingCopies detect: [ :each | each packageName = 'XXXXX' ]) unregister.

	self assert: (self organizer hasPackage: #XXXXX)
]
