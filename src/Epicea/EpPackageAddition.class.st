"
I represent a package creation in the system.
"
Class {
	#name : #EpPackageAddition,
	#superclass : #EpPackageChange,
	#category : #'Epicea-Model'
}

{ #category : #visitor }
EpPackageAddition >> accept: aVisitor [

	^ aVisitor visitPackageAddition: self
]
