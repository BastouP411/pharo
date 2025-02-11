"
A package with classes for the announcement framwork - an event notification framework.
"
Class {
	#name : #ManifestAnnouncementsCore,
	#superclass : #PackageManifest,
	#category : #'Announcements-Core-Manifest'
}

{ #category : #'meta-data - dependency analyser' }
ManifestAnnouncementsCore class >> manuallyResolvedDependencies [
	^ #(#'Collections-Abstract')
]

{ #category : #'code-critics' }
ManifestAnnouncementsCore class >> ruleBadMessageRule2V1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#WeakAnnouncementSubscription #makeStrong #false)) #'2023-07-15T11:58:39.026873+02:00') )
]
