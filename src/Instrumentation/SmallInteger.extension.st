Extension { #name : #SmallInteger }

{ #category : #'*Instrumentation' }
SmallInteger >> insIsNumberEqual: aNumber [
	"Primitive. Compare the receiver with the argument and answer true if
	the receiver is equal to the argument. Otherwise answer false. Fail if the
	argument is not a SmallInteger. Essential. No Lookup. See Object
	documentation whatIsAPrimitive. "
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	<primitive: 7>
	^super = aNumber
]

{ #category : #'*Instrumentation' }
SmallInteger >> insIsNumberNotEqual: aNumber [
	"Primitive. Compare the receiver with the argument and answer true if
	the receiver is not equal to the argument. Otherwise answer false. Fail if
	the argument is not a SmallInteger. Essential. No Lookup. See Object
	documentation whatIsAPrimitive."
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	<primitive: 8>
	^super ~= aNumber
]

{ #category : #'*Instrumentation' }
SmallInteger >> insMinus: aNumber [
	"Primitive. Subtract the argument from the receiver and answer with the
	result if it is a SmallInteger. Fail if the argument or the result is not a
	SmallInteger. Essential. No Lookup. See Object documentation
	whatIsAPrimitive."
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	<primitive: 2>
	^super - aNumber
]

{ #category : #'*Instrumentation' }
SmallInteger >> insPlus: aNumber [
	"Primitive. Add the receiver to the argument and answer with the result
	if it is a SmallInteger. Fail if the argument or the result is not a
	SmallInteger  Essential  No Lookup. See Object documentation whatIsAPrimitive."
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	<primitive: 1>
	^ super + aNumber
]
