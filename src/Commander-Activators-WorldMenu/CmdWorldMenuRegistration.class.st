"
I implement registration of world menu and global shortucts using standard system pragmas: 

- <worldMenu>
- <keymap>

In addition to support shortucts I register special #CmdWorldShortcutsCategory in current World instance. During shortcuts collection I use this category to add keymaps into the given builder.  

Registration is done during class initialization. Or you can reevaluate it with:

	CmdWorldMenuRegistration attachShorctutsToWorld 
"
Class {
	#name : #CmdWorldMenuRegistration,
	#superclass : #Object,
	#category : #'Commander-Activators-WorldMenu'
}

{ #category : #'world menu' }
CmdWorldMenuRegistration class >> createCommandContext [

	^CmdWorldMenuContext for: self currentWorld
]

{ #category : #'world menu' }
CmdWorldMenuRegistration class >> enableWorldShortcuts [
	<script>
	CmdKMDispatcher attachedTo: self currentWorld withCommandsFrom: self
]

{ #category : #'class initialization' }
CmdWorldMenuRegistration class >> initialize [

	self enableWorldShortcuts
]

{ #category : #'world menu' }
CmdWorldMenuRegistration class >> registerMenuOn: aBuilder [
	<worldMenu>

	CmdContextMenuActivation
		registerContextMenuOn: aBuilder inContext: self createCommandContext
]
