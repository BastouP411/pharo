"
I have the common behavior for testing class serialization.
"
Class {
	#name : #FLClassSerializationTest,
	#superclass : #FLSerializationTest,
	#category : #'Fuel-Core-Tests-Base'
}

{ #category : #helpers }
FLClassSerializationTest >> newInstanceFrom: aClass [

	^ aClass new
]
