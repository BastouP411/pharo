Extension { #name : #BlockClosure }

{ #category : #'*Instrumentation' }
BlockClosure >> insEnsure: aBlock [
	"I am a re-implementation of the method BlockClosure>>#ensure: and I have the same code
	except for the <noInstrumentation> pragma. I re-implement this method because when
	instrumenting I need to use the BlockClosure>>#ensure: method but if one instruments the
	method BlockClosure>>#ensure: I will enter to an endless loop."

	<noInstrumentation>
	<primitive: 198>
	| complete returnValue |
	returnValue := self valueNoContextSwitch.
	complete ifNil: [
		complete := true.
		aBlock value ].
	^ returnValue
]
