"
I am announced when existing package tag is removed from package
"
Class {
	#name : #PackageTagRemoved,
	#superclass : #PackageTagAnnouncement,
	#category : #'System-Announcements-System-Packages'
}

{ #category : #'class initialization' }
PackageTagRemoved class >> initialize [

	self deprecatedAliases: { 'ClassTagRemoved' }
]
