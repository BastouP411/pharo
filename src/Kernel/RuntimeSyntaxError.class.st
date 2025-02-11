"
When compiling syntactically incorrect code, we compile raising this exception.

This way the debugger opens and the programmer can easily fix the faulty method
"
Class {
	#name : #RuntimeSyntaxError,
	#superclass : #Error,
	#category : #'Kernel-Exceptions'
}

{ #category : #signalling }
RuntimeSyntaxError class >> signalSyntaxError: aString [
	"we use signalSyntaxError: instead of signal: so we can quickly check
	compiledMethods for syntax errors by checking the literals"
	^ self signal: aString
]
