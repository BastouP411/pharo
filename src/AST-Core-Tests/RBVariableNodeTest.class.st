"
SUnit tests for RBVariableNode
"
Class {
	#name : #RBVariableNodeTest,
	#superclass : #RBParseTreeTest,
	#category : #'AST-Core-Tests-Nodes'
}

{ #category : #tests }
RBVariableNodeTest >> testIsDefinedByBlock [

	| ast temps args |
	ast := self class compiler parse: 'myMethod: arg
  | test |
  test := 2.
  test.
	[ :test2 | | test3| test2. test3].
  ^test'.
	temps := ast allChildren select: [ :each | each isTempVariable ].
	"test is defined by the method"
	self deny: temps first isDefinedByBlock.
	self deny: temps second isDefinedByBlock.
	self deny: temps third isDefinedByBlock.

	"test3 definition"
	self assert: ast blockNodes first arguments first isDefinedByBlock.
	"test3 definition"
	self assert: temps fourth isDefinedByBlock.
	"test 3 use"
	self assert: temps fifth isDefinedByBlock.
	"and we are out if the block"
	self deny: temps sixth isDefinedByBlock.

	args := ast allChildren select: [ :each | each isArgumentVariable ].
	"method arg"
	self deny: args first isDefinedByBlock.
	self assert: args second isDefinedByBlock.
	"use of test3"
	self assert: args third isDefinedByBlock
]

{ #category : #tests }
RBVariableNodeTest >> testIsDefinition [

	| ast temps |
	ast := self class compiler parse: 'myMethod: arg
  | test testCopied testTempVector|
  test := 2.
  test.
  [ testCopied. testTempVector := 1 ].
  ^test'.
	temps := ast allChildren select: [ :each | each isTempVariable ].

	"arguments define variables"
	self assert: ast arguments first isDefinition.
	"this is the || definition"
	self assert: temps first variable class identicalTo: TemporaryVariable.
	self assert: temps first isDefinition.
	self assert: temps second variable class identicalTo: CopiedLocalVariable.
	self assert: temps second isDefinition.
	self assert: temps third variable class identicalTo: OCVectorTempVariable .
	self assert: temps third isDefinition.
	"all the rest are just uses"
	self deny: temps fourth isDefinition.
	self deny: (temps at: 5) isDefinition.
	self deny: (temps at: 6) isDefinition
]

{ #category : #tests }
RBVariableNodeTest >> testStartForReplacement [

	| source tree dTemporary |
	source := 'foo
	|a b c de d|
	de := 4'.
	tree := self parseMethod: source.
	dTemporary := tree body temporaries last.
	self assert: dTemporary name equals: #d.
	self assert: (source copyFrom: dTemporary start to: dTemporary stop) equals: 'd'.
	self assert: (source copyFrom: dTemporary startForReplacement to: dTemporary stop) equals: ' d'.
	self assert: (dTemporary start - dTemporary startForReplacement) equals: 1
]

{ #category : #tests }
RBVariableNodeTest >> testStartForReplacement02 [

	| source tree dTemporary |
	source := 'foo
	|a b c de

d|
	de := 4'.
	tree := self parseMethod: source.
	dTemporary := tree body temporaries last.
	self assert: dTemporary name equals: #d.
	self assert: (source copyFrom: dTemporary start to: dTemporary stop) equals: 'd'.
	self assert: (source copyFrom: dTemporary startForReplacement to: dTemporary stop) equals: '

d'.
	self assert: (dTemporary start - dTemporary startForReplacement) equals: 2
]
