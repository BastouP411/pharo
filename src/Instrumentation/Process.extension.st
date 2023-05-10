Extension { #name : #Process }

{ #category : #'*Instrumentation' }
Process >> executeInLevel: aBlock [
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	self shiftLevelUp.
	^ aBlock insEnsure: InstrumentationDeactivator new
]

{ #category : #'*Instrumentation' }
Process >> isActive: n [
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	^(level insIsNumberEqual: n) or: [ level insIsEqual: nil ]
]

{ #category : #'*Instrumentation' }
Process >> isMeta [
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	level ifNil: [ level := 0 ].
	^level insIsNumberNotEqual: 0
]

{ #category : #'*Instrumentation' }
Process >> level [
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	^level ifNil: [ level := 0 ]
]

{ #category : #'*Instrumentation' }
Process >> shiftLevelDown [
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	level ifNil: [ level := 0 ].
	(level insIsNumberEqual: 0) ifTrue: [ ^level ].
	(level insIsNumberEqual: 1) ifTrue: [ ^level := 0 ].
	level := level insMinus: 1
]

{ #category : #'*Instrumentation' }
Process >> shiftLevelUp [
	<metaLinkOptions: #( + optionDisabledLink)>
	<notInstrumentable>
	level ifNil: [ level := 0 ].
	level := level insPlus: 1
]
