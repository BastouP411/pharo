"
A test mock where a new instance is enforced
"
Class {
	#name : #FLSingletonMockEnforced,
	#superclass : #FLSingletonMock,
	#category : #'Fuel-Core-Tests-Support-Mocks'
}

{ #category : #fuel }
FLSingletonMockEnforced class >> fuelNew [
	^ self instance
]
