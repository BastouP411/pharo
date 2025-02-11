Class {
	#name : #MCWorkingCopyForExtensionsTest,
	#superclass : #MCTestCase,
	#category : #'Monticello-Tests-Base'
}

{ #category : #running }
MCWorkingCopyForExtensionsTest >> tearDown [
	'ATestPackage' asPackage removeFromSystem.
	'AnotherTestPackage' asPackage removeFromSystem.
	Object
		compiledMethodAt: #testingMethod
		ifPresent: [ Object removeSelector: #testingMethod ].
	('Atestpackage-something-else' asPackageIfAbsent: [ nil ])
		ifNotNil: [ :package | package removeFromSystem ].
	MCWorkingCopy registry
		at: (MCPackage named: 'atestpackage-something-else')
		ifPresent: [ :aWC | aWC unload ].
	super tearDown
]

{ #category : #tests }
MCWorkingCopyForExtensionsTest >> testAddingExtensionMethodNotMatchingPackage [

	| aClass |
	self packageOrganizer ensurePackage: 'ATestPackage'.
	self packageOrganizer ensurePackage: 'AnotherTestPackage'.

	aClass := self class classInstaller make: [ :aBuilder |
		          aBuilder
			          name: #ATestClass;
			          package: 'AnotherTestPackage' ].

	aClass compile: 'testingMethod ^ 42 ' classified: '*atestpackage-something-else'.

	self deny: (self packageOrganizer hasPackage: 'Atestpackage-something-else').
	self assert: ('ATestPackage' asPackage extendedClasses includes: aClass).

	MCWorkingCopy registry at: (MCPackage named: 'atestpackage-something-else') ifPresent: [ self fail ]
]
