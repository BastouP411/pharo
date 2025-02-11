Extension { #name : #Class }

{ #category : #'*TraitsV2' }
Class >> immediateSubclass: aClassName uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aClassName;
			  superclass: self;
			  slotsFromString: instVarNameList;
			  layoutClass: ImmediateLayout;
			  sharedVariablesFromString: classVarNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> immediateSubclass: aName uses: aTraitComposition instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  slotsFromString: someInstanceVariableNames;
			  layoutClass: ImmediateLayout;
			  sharedVariablesFromString: someClassVariableNames;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> setTraitComposition: aTraitComposition [

	^ self classInstaller
		  update: self
		  to: [ :builder | builder traitComposition: aTraitComposition ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aName uses: aTraitComposition [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  traitComposition: aTraitComposition ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aName uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  slotsFromString: instVarNameList;
			  sharedVariablesFromString: classVarNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aName uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  slotsFromString: instVarNameList;
			  sharedVariablesFromString: classVarNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aName uses: aTraitCompositionOrArray instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  slotsFromString: someInstanceVariableNames;
			  sharedVariablesFromString: someClassVariableNames;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aName uses: aTraitCompositionOrArray instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  slotsFromString: someInstanceVariableNames;
			  sharedVariablesFromString: someClassVariableNames;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aSubclassSymbol uses: aTraitCompositionOrArray layout: layoutClass slots: slotDefinition classVariables: classVarDefinition category: aCategorySymbol [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aSubclassSymbol;
			  superclass: self;
			  slots: slotDefinition;
			  layoutClass: layoutClass;
			  sharedVariables: classVarDefinition;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategorySymbol ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aSubclassSymbol uses: aTraitCompositionOrArray layout: layoutClass slots: slotDefinition classVariables: classVarDefinition package: aCategorySymbol [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aSubclassSymbol;
			  superclass: self;
			  slots: slotDefinition;
			  layoutClass: layoutClass;
			  sharedVariables: classVarDefinition;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategorySymbol ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: subclassName uses: aTraitComposition layout: aLayout slots: someSlots classVariables: someClassVariables poolDictionaries: somePoolDictionaries category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: subclassName;
			  superclass: self;
			  slots: someSlots;
			  layoutClass: aLayout;
			  sharedVariables: someClassVariables;
			  sharedPools: somePoolDictionaries;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: subclassName uses: aTraitComposition layout: aLayout slots: someSlots classVariables: someClassVariables poolDictionaries: somePoolDictionaries package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: subclassName;
			  superclass: self;
			  slots: someSlots;
			  layoutClass: aLayout;
			  sharedVariables: someClassVariables;
			  sharedPools: somePoolDictionaries;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: subclassName uses: aTraitComposition layout: aLayout slots: someSlots classVariablesNames: someClassVariablesNames poolDictionaries: somePoolDictionaries category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: subclassName;
			  superclass: self;
			  slots: someSlots;
			  layoutClass: aLayout;
			  sharedVariablesFromString: someClassVariablesNames;
			  sharedPools: somePoolDictionaries;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: subclassName uses: aTraitComposition layout: aLayout slots: someSlots classVariablesNames: someClassVariablesNames poolDictionaries: somePoolDictionaries package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: subclassName;
			  superclass: self;
			  slots: someSlots;
			  layoutClass: aLayout;
			  sharedVariablesFromString: someClassVariablesNames;
			  sharedPools: somePoolDictionaries;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aSubclassSymbol uses: aTraitCompositionOrArray slots: slotDefinition classVariables: classVarDefinition category: aCategorySymbol [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aSubclassSymbol;
			  superclass: self;
			  slots: slotDefinition;
			  sharedVariables: classVarDefinition;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategorySymbol ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aSubclassSymbol uses: aTraitCompositionOrArray slots: slotDefinition classVariables: classVarDefinition package: aCategorySymbol [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aSubclassSymbol;
			  superclass: self;
			  slots: slotDefinition;
			  sharedVariables: classVarDefinition;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategorySymbol ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aSubclassSymbol uses: aTraitCompositionOrArray slots: slotDefinition classVariables: classVarDefinition poolDictionaries: someSharedPoolNames category: aCategorySymbol [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aSubclassSymbol;
			  superclass: self;
			  slots: slotDefinition;
			  sharedVariables: classVarDefinition;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategorySymbol ]
]

{ #category : #'*TraitsV2' }
Class >> subclass: aSubclassSymbol uses: aTraitCompositionOrArray slots: slotDefinition classVariables: classVarDefinition poolDictionaries: someSharedPoolNames package: aCategorySymbol [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aSubclassSymbol;
			  superclass: self;
			  slots: slotDefinition;
			  sharedVariables: classVarDefinition;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategorySymbol ]
]

{ #category : #'*TraitsV2' }
Class >> usesTrait: aTrait [
	"Returns whether self or one of its superclasses are among the users of aTrait"
	^ aTrait users includesAny: self withAllSuperclasses
]

{ #category : #'*TraitsV2' }
Class >> usesTraitLocally: aTrait [
	"Returns whether self is among the users of aTrait. Note that this will return false if aTrait is used by a superclass of self and not self itself. If you want to get true in this case, use #usesTrait:"
	^ aTrait users includes: self
]

{ #category : #'*TraitsV2' }
Class >> variableByteSubclass: className uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames category: aCategory [

	^ self classInstaller
		make: [ :builder |
			builder
				name: className;
				superclass: self;
				slotsFromString: instVarNameList;
				layoutClass: (self checkForCompiledMethodLayout: className);
				sharedVariablesFromString: classVarNames;
				traitComposition: aTraitCompositionOrArray;
				category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> variableByteSubclass: aName uses: aTraitComposition instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames category: aCategory [

	^ self classInstaller
		make: [ :builder |
			builder
				name: aName;
				superclass: self;
				slotsFromString: someInstanceVariableNames;
				layoutClass: (self checkForCompiledMethodLayout: aName);
				sharedVariablesFromString: someClassVariableNames;
				sharedPools: someSharedPoolNames;
				traitComposition: aTraitComposition;
				category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> variableSubclass: aClassName uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aClassName;
			  superclass: self;
			  layoutClass: VariableLayout;
			  slotsFromString: instVarNameList;
			  sharedVariablesFromString: classVarNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> variableSubclass: aClassName uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aClassName;
			  superclass: self;
			  layoutClass: VariableLayout;
			  slotsFromString: instVarNameList;
			  sharedVariablesFromString: classVarNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> variableSubclass: aName uses: aTraitComposition instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  layoutClass: VariableLayout;
			  slotsFromString: someInstanceVariableNames;
			  sharedVariablesFromString: someClassVariableNames;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> variableSubclass: aName uses: aTraitComposition instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  layoutClass: VariableLayout;
			  slotsFromString: someInstanceVariableNames;
			  sharedVariablesFromString: someClassVariableNames;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> variableWordSubclass: className uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: className;
			  superclass: self;
			  slotsFromString: instVarNameList;
			  layoutClass: WordLayout;
			  sharedVariablesFromString: classVarNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> variableWordSubclass: className uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: className;
			  superclass: self;
			  slotsFromString: instVarNameList;
			  layoutClass: WordLayout;
			  sharedVariablesFromString: classVarNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> variableWordSubclass: aName uses: aTraitComposition instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  slotsFromString: someInstanceVariableNames;
			  layoutClass: WordLayout;
			  sharedVariablesFromString: someClassVariableNames;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> variableWordSubclass: aName uses: aTraitComposition instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  slotsFromString: someInstanceVariableNames;
			  layoutClass: WordLayout;
			  sharedVariablesFromString: someClassVariableNames;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> weakSubclass: className uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: className;
			  superclass: self;
			  slotsFromString: instVarNameList;
			  layoutClass: WeakLayout;
			  sharedVariablesFromString: classVarNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> weakSubclass: className uses: aTraitCompositionOrArray instanceVariableNames: instVarNameList classVariableNames: classVarNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: className;
			  superclass: self;
			  slotsFromString: instVarNameList;
			  layoutClass: WeakLayout;
			  sharedVariablesFromString: classVarNames;
			  traitComposition: aTraitCompositionOrArray;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> weakSubclass: aName uses: aTraitComposition instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames category: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  slotsFromString: someInstanceVariableNames;
			  layoutClass: WeakLayout;
			  sharedVariablesFromString: someClassVariableNames;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]

{ #category : #'*TraitsV2' }
Class >> weakSubclass: aName uses: aTraitComposition instanceVariableNames: someInstanceVariableNames classVariableNames: someClassVariableNames poolDictionaries: someSharedPoolNames package: aCategory [

	^ self classInstaller make: [ :builder |
		  builder
			  name: aName;
			  superclass: self;
			  slotsFromString: someInstanceVariableNames;
			  layoutClass: WeakLayout;
			  sharedVariablesFromString: someClassVariableNames;
			  sharedPools: someSharedPoolNames;
			  traitComposition: aTraitComposition;
			  category: aCategory ]
]
