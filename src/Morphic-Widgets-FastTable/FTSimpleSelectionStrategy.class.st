"
I define the simple selection strategy. 
I allow tables using me to manage single selection rows.
"
Class {
	#name : #FTSimpleSelectionStrategy,
	#superclass : #FTSelectionStrategy,
	#category : #'Morphic-Widgets-FastTable-Selection'
}

{ #category : #'class initialization' }
FTSimpleSelectionStrategy class >> initialize [

	self deprecatedAliases: { #FTSimpleSelection }
]

{ #category : #testing }
FTSimpleSelectionStrategy >> isMultiple [
	^ false
]

{ #category : #accessing }
FTSimpleSelectionStrategy >> selectIndex: rowIndex event: event [
	self toggleIndex: rowIndex
]
