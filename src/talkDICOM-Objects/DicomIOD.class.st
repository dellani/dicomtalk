Class {
	#name : #DicomIOD,
	#superclass : #DicomObject,
	#classInstVars : [
		'InformationObjectModules'
	],
	#category : #'talkDICOM-Objects'
}

{ #category : #accessing }
DicomIOD class >> DicomIODName [

	^self subclassResponsibility
]

{ #category : #accessing }
DicomIOD class >> InformationObjectModules [

	^OrderedCollection new.
]

{ #category : #accessing }
DicomIOD class >> SOPClassUID [

	^nil
]

{ #category : #'computer reflection' }
DicomIOD class >> _addDicomParserVAccessorsToSubclasses_Pharo [
	"Cool!!!
	
	PRD August 09th, 2002"

	| instanceVariableNames method valueToken parameter |

	self subclasses do: [:aSubclass |
		aSubclass addDicomParserVAccessorsToSubclasses_Pharo].

	(InformationObjectModules isKindOf: OrderedCollection) ifTrue: [
		instanceVariableNames := OrderedCollection new.
		InformationObjectModules do: [:iom | (RBAddInstanceVariableChange add: iom moduleName to: self) execute].
		"instanceVariables := instanceVariableNames asArray."
	].

	(InformationObjectModules isKindOf: OrderedCollection) ifTrue: [
		InformationObjectModules do: [:iomClass | 
			(iomClass DataElements isKindOf: Dictionary) ifTrue: [
				iomClass DataElements do: [:dataElement |
					method := WriteStream on: String new.
					method 
						nextPutAll: dataElement name asString; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues.'; cr;
						tab; nextPutAll: '].'; cr; cr;
						tab; nextPutAll: '^', iomClass moduleName, ' ', dataElement name asString.
						
				MethodAddition new
					compile: method contents
						classified: 'accessing IOM data elements'
						withStamp: DateAndTime now printString
						notifying: nil 
						logSource: true
						inClass: self;
					compile.
					
					"self compile: method contents classified: 'accessing IOM data elements' attributes: #()."

					method := WriteStream on: String new.
					valueToken := 'a', dataElement vr, 'Value'.
					method 
						nextPutAll: dataElement name asString, ': ', valueToken; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues.'; cr;
						tab; nextPutAll: '].'; cr; cr;
						tab; nextPutAll: iomClass moduleName, ' ', dataElement name asString, ': ', valueToken; cr.

				MethodAddition new
					compile: method contents
						classified: 'accessing IOM data elements'
						withStamp: DateAndTime now printString
						notifying: nil 
						logSource: true
						inClass: self;
					compile.

					"self compile: method contents classified: 'accessing IOM data elements' attributes: #()."
				]
			].
			method := WriteStream on: String new.
			method 
				nextPutAll: iomClass moduleName; cr; cr;
				tab; nextPutAll: '^', iomClass moduleName.

			MethodAddition new
					compile: method contents
						classified: 'accessing IOM'
						withStamp: DateAndTime now printString
						notifying: nil 
						logSource: true
						inClass: self;
					compile.

			"self compile: method contents classified: 'accessing IOM' attributes: #()."

			method := WriteStream on: String new.
			parameter := 'a', iomClass name asString.
			method 
				nextPutAll: iomClass moduleName, ': ', parameter; cr; cr; 
				tab; nextPutAll: iomClass moduleName, ' := ', parameter, '.'; cr;
				tab; nextPutAll: iomClass moduleName, ' encoder: self encoder.'; cr; cr;

				tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary == self dataElementsDictionary ifFalse: ['; cr;
				tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary keysAndValuesDo: [:key :value |'; cr;
				tab; tab; tab; nextPutAll: 'self dataElementsDictionary at: key put: value].'; cr;
				tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
				tab; nextPutAll: '].'; cr; cr;

				tab; nextPutAll: iomClass moduleName, ' dataElementsValues == self dataElementsValues ifFalse: ['; cr;
				tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues keysAndValuesDo: [:key :value |'; cr;
				tab; tab; tab; nextPutAll: 'self dataElementsValues at: key put: value].'; cr;
				tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues'; cr;
				tab; nextPutAll: '].'; cr; cr.

			MethodAddition new
					compile: method contents
						classified: 'accessing IOM'
						withStamp: DateAndTime now printString
						notifying: nil 
						logSource: true
						inClass: self;
					compile.

			"self compile: method contents classified: 'accessing IOM' attributes: #()."
		]
	]
]

{ #category : #'computer reflection' }
DicomIOD class >> addDicomParserIIAccessorsToSubclasses [
	"Cool!!!

	PRD August 09th, 2002"

	| method valueToken parameter |

	self subclasses do: [:aSubclass |
		aSubclass addDicomParserIIAccessorsToSubclasses].

	(InformationObjectModules isKindOf: OrderedCollection) ifTrue: [
		InformationObjectModules do: [:iomClass | 
			(iomClass DataElements isKindOf: Dictionary) ifTrue: [
				iomClass DataElements do: [:dataElement |
					method := WriteStream on: String new.
					method 
						nextPutAll: dataElement name asString; cr; cr; 
						tab; nextPutAll: '^', iomClass moduleName, ' isNil'; cr;
						tab; tab; nextPutAll: 'ifFalse: [', iomClass moduleName, ' ', dataElement name asString, ']'; cr;
						tab; tab; nextPutAll: 'ifTrue: [nil]'; cr.
					self compile: method contents classified: 'accessing IOM data elements' attributes: #().
					method := WriteStream on: String new.
					valueToken := 'a', dataElement vr, 'Value'.
					method 
						nextPutAll: dataElement name asString, ': ', valueToken; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' isNil'; cr;
						tab; tab; nextPutAll: 'ifFalse: [', iomClass moduleName, ' ', dataElement name asString, ': ', valueToken, ']'; cr.
					self compile: method contents classified: 'accessing IOM data elements' attributes: #().
				]
			].
			method := WriteStream on: String new.
			method 
				nextPutAll: iomClass moduleName; cr; cr;
				tab; nextPutAll: '^', iomClass moduleName.
			self compile: method contents classified: 'accessing IOM' attributes: #().

			method := WriteStream on: String new.
			parameter := 'a', iomClass name asString.
			method 
				nextPutAll: iomClass moduleName, ': ', parameter; cr; cr; 
				tab; nextPutAll: iomClass moduleName, ' := ', parameter, '.'; cr;
				tab; nextPutAll: iomClass moduleName, ' encoder: encoder.'; cr;
				tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary isNil ifFalse: ['; cr;
				tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary keysAndValuesDo: [:key :value |'; cr;
				tab; tab; tab; nextPutAll: 'self dataElementsDictionary at: key put: value]'; cr;
				tab; nextPutAll: '].'; cr;
				tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary'; cr.
			self compile: method contents classified: 'accessing IOM' attributes: #().
		]
	]
]

{ #category : #'computer reflection' }
DicomIOD class >> addDicomParserIIIAccessorsToSubclasses [
	"Cool!!!

	PRD August 09th, 2002"

	| method valueToken parameter |

	self subclasses do: [:aSubclass |
		aSubclass addDicomParserIIIAccessorsToSubclasses].

	(InformationObjectModules isKindOf: OrderedCollection) ifTrue: [
		InformationObjectModules do: [:iomClass | 
			(iomClass DataElements isKindOf: Dictionary) ifTrue: [
				iomClass DataElements do: [:dataElement |
					method := WriteStream on: String new.
					method 
						nextPutAll: dataElement name asString; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: dataElementsDictionary.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: dataElementsValues.'; cr;
						tab; nextPutAll: '].'; cr; cr;
						tab; nextPutAll: '^', iomClass moduleName, ' ', dataElement name asString.
					self compile: method contents classified: 'accessing IOM data elements' attributes: #().

					method := WriteStream on: String new.
					valueToken := 'a', dataElement vr, 'Value'.
					method 
						nextPutAll: dataElement name asString, ': ', valueToken; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: dataElementsDictionary.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: dataElementsValues.'; cr;
						tab; nextPutAll: '].'; cr; cr;
						tab; nextPutAll: iomClass moduleName, ' ', dataElement name asString, ': ', valueToken; cr.
					self compile: method contents classified: 'accessing IOM data elements' attributes: #().
				]
			].
			method := WriteStream on: String new.
			method 
				nextPutAll: iomClass moduleName; cr; cr;
				tab; nextPutAll: '^', iomClass moduleName.
			self compile: method contents classified: 'accessing IOM' attributes: #().

			method := WriteStream on: String new.
			parameter := 'a', iomClass name asString.
			method 
				nextPutAll: iomClass moduleName, ': ', parameter; cr; cr; 
				tab; nextPutAll: iomClass moduleName, ' := ', parameter, '.'; cr;
				tab; nextPutAll: iomClass moduleName, ' encoder: encoder.'; cr;
				tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary keysAndValuesDo: [:key :value |'; cr;
				tab; tab; nextPutAll: 'self dataElementsDictionary at: key put: value].'; cr;
				tab; nextPutAll: iomClass moduleName, ' dataElementsValues keysAndValuesDo: [:key :value |'; cr;
				tab; tab; nextPutAll: 'self dataElementsValues at: key put: value].'; cr;
				tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
				tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues'; cr.
			self compile: method contents classified: 'accessing IOM' attributes: #().
		]
	]
]

{ #category : #'computer reflection' }
DicomIOD class >> addDicomParserIVAccessorsToSubclasses [
	"Cool!!!
	
	PRD August 09th, 2002"

	| instanceVariableNames method valueToken parameter |

	self subclasses do: [:aSubclass |
		aSubclass addDicomParserIVAccessorsToSubclasses].

	(InformationObjectModules isKindOf: OrderedCollection) ifTrue: [
		instanceVariableNames := OrderedCollection new.
		InformationObjectModules do: [:iom | instanceVariableNames add: iom moduleName].
		instanceVariables := instanceVariableNames asArray.
	].

	(InformationObjectModules isKindOf: OrderedCollection) ifTrue: [
		InformationObjectModules do: [:iomClass | 
			(iomClass DataElements isKindOf: Dictionary) ifTrue: [
				iomClass DataElements do: [:dataElement |
					method := WriteStream on: String new.
					method 
						nextPutAll: dataElement name asString; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues.'; cr;
						tab; nextPutAll: '].'; cr; cr;
						tab; nextPutAll: '^', iomClass moduleName, ' ', dataElement name asString.
					self compile: method contents classified: 'accessing IOM data elements' attributes: #().

					method := WriteStream on: String new.
					valueToken := 'a', dataElement vr, 'Value'.
					method 
						nextPutAll: dataElement name asString, ': ', valueToken; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues.'; cr;
						tab; nextPutAll: '].'; cr; cr;
						tab; nextPutAll: iomClass moduleName, ' ', dataElement name asString, ': ', valueToken; cr.
					self compile: method contents classified: 'accessing IOM data elements' attributes: #().
				]
			].
			method := WriteStream on: String new.
			method 
				nextPutAll: iomClass moduleName; cr; cr;
				tab; nextPutAll: '^', iomClass moduleName.
			self compile: method contents classified: 'accessing IOM' attributes: #().

			method := WriteStream on: String new.
			parameter := 'a', iomClass name asString.
			method 
				nextPutAll: iomClass moduleName, ': ', parameter; cr; cr; 
				tab; nextPutAll: iomClass moduleName, ' := ', parameter, '.'; cr;
				tab; nextPutAll: iomClass moduleName, ' encoder: self encoder.'; cr; cr;

				tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary == self dataElementsDictionary ifFalse: ['; cr;
				tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary keysAndValuesDo: [:key :value |'; cr;
				tab; tab; tab; nextPutAll: 'self dataElementsDictionary at: key put: value].'; cr;
				tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
				tab; nextPutAll: '].'; cr; cr;

				tab; nextPutAll: iomClass moduleName, ' dataElementsValues == self dataElementsValues ifFalse: ['; cr;
				tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues keysAndValuesDo: [:key :value |'; cr;
				tab; tab; tab; nextPutAll: 'self dataElementsValues at: key put: value].'; cr;
				tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues'; cr;
				tab; nextPutAll: '].'; cr; cr.
			self compile: method contents classified: 'accessing IOM' attributes: #().
		]
	]
]

{ #category : #'computer reflection' }
DicomIOD class >> addDicomParserVAccessorsToSubclasses_Pharo [
	"Cool!!!
	
	PRD Oktober 06, 2017"

	| instanceVariableNames method |

	self subclasses do: [:aSubclass |
		aSubclass addDicomParserVAccessorsToSubclasses_Pharo].

	(InformationObjectModules isKindOf: OrderedCollection) ifTrue: [
		instanceVariableNames := self instanceVariableNames.
		InformationObjectModules do: [:iom | (instanceVariableNames includes: iom moduleName asSymbol) ifFalse: [(RBAddInstanceVariableChange add: iom moduleName to: self) execute]].
		"instanceVariables := instanceVariableNames asArray."
	].

	(InformationObjectModules isKindOf: OrderedCollection) ifTrue: [
		InformationObjectModules do: [:iomClass | 
			(iomClass DataElements isKindOf: Dictionary) ifTrue: [
				iomClass DataElements do: [:dataElement |
					method := self computerReflection_accessor_01_for: dataElement iomClass: iomClass.
						
					MethodAddition new
						compile: method
							classified: 'accessing IOM data elements'
							withStamp: DateAndTime now printString
							notifying: nil 
							logSource: true
							inClass: self; compile.
					

					method := self computerReflection_accessor_02_for: dataElement iomClass: iomClass.

					MethodAddition new
						compile: method
							classified: 'accessing IOM data elements'
							withStamp: DateAndTime now printString
							notifying: nil 
							logSource: true
							inClass: self; 	compile.

				]
			].
			method := self computerReflection_accessor_03_for: iomClass.

			MethodAddition new
					compile: method
						classified: 'accessing IOM'
						withStamp: DateAndTime now printString
						notifying: nil 
						logSource: true
						inClass: self;
					compile.

			method := self computerReflection_accessor_04_for: iomClass.

			MethodAddition new
					compile: method contents
						classified: 'accessing IOM'
						withStamp: DateAndTime now printString
						notifying: nil 
						logSource: true
						inClass: self;
					compile.
		]
	]
]

{ #category : #'computer reflection' }
DicomIOD class >> computerReflection_accessor_01_for: dataElement iomClass: iomClass [
	| method |

	method := String
		new: 10
		streamContents: [ :writeStream | 
					writeStream 
						nextPutAll: dataElement name asString; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues.'; cr;
						tab; nextPutAll: '].'; cr; cr;
						tab; nextPutAll: '^', iomClass moduleName, ' ', dataElement name asString].
					
	^ method
						

]

{ #category : #'computer reflection' }
DicomIOD class >> computerReflection_accessor_01_for: dataElement iomClass: iomClass newName: newName [
	| method |

	method := String
		new: 10
		streamContents: [ :writeStream | 
					writeStream 
						nextPutAll: dataElement name asString; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues.'; cr;
						tab; nextPutAll: '].'; cr; cr;
						tab; nextPutAll: '^', iomClass moduleName, ' ', newName asString].
					
	^ method
						

]

{ #category : #'computer reflection' }
DicomIOD class >> computerReflection_accessor_02_for: dataElement iomClass: iomClass [
	| method valueToken |

	valueToken := 'a', dataElement vr, 'Value'.

	method := String
		new: 10
		streamContents: [ :writeStream | 
									writeStream
										nextPutAll: dataElement name asString, ': ', valueToken; cr; cr; 
										tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
										tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
										tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
										tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues.'; cr;
										tab; nextPutAll: '].'; cr; cr;
										tab; nextPutAll: iomClass moduleName, ' ', dataElement name asString, ': ', valueToken; cr].
	^ method
]

{ #category : #'computer reflection' }
DicomIOD class >> computerReflection_accessor_02_for: dataElement iomClass: iomClass newName: newName [
	| method valueToken |

	valueToken := 'a', dataElement vr, 'Value'.

	method := String
		new: 10
		streamContents: [ :writeStream | 
									writeStream
										nextPutAll: dataElement name asString, ': ', valueToken; cr; cr; 
										tab; nextPutAll: iomClass moduleName, ' isNil ifTrue: ['; cr;
										tab; tab; nextPutAll: iomClass moduleName, ' := ', iomClass name asString, ' new.'; cr;
										tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
										tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues.'; cr;
										tab; nextPutAll: '].'; cr; cr;
										tab; nextPutAll: iomClass moduleName, ' ', newName asString, ': ', valueToken; cr].
	^ method
]

{ #category : #'computer reflection' }
DicomIOD class >> computerReflection_accessor_03_for: iomClass [
	| method |

	method := String
		new: 10
		streamContents: [ :writeStream | 
									writeStream
										nextPutAll: iomClass moduleName; cr; cr;
										tab; nextPutAll: '^', iomClass moduleName].
	^ method
	


]

{ #category : #'computer reflection' }
DicomIOD class >> computerReflection_accessor_04_for: iomClass [
	| method parameter |

	parameter := 'a', iomClass name asString.
	method := String
		new: 10
		streamContents: [ :writeStream | 
					writeStream
						nextPutAll: iomClass moduleName, ': ', parameter; cr; cr; 
						tab; nextPutAll: iomClass moduleName, ' := ', parameter, '.'; cr;
						tab; nextPutAll: iomClass moduleName, ' encoder: self encoder.'; cr; cr;
						tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary == self dataElementsDictionary ifFalse: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary keysAndValuesDo: [:key :value |'; cr;
						tab; tab; tab; nextPutAll: 'self dataElementsDictionary at: key put: value].'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsDictionary: self dataElementsDictionary.'; cr;
						tab; nextPutAll: '].'; cr; cr;
						tab; nextPutAll: iomClass moduleName, ' dataElementsValues == self dataElementsValues ifFalse: ['; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues keysAndValuesDo: [:key :value |'; cr;
						tab; tab; tab; nextPutAll: 'self dataElementsValues at: key put: value].'; cr;
						tab; tab; nextPutAll: iomClass moduleName, ' dataElementsValues: self dataElementsValues'; cr;
						tab; nextPutAll: '].'; cr; cr].
	^ method
]

{ #category : #'computer reflection' }
DicomIOD class >> correctedDataElementNames [
	"Computer Reflection is Cool!!!

	The DICOM standard define a keyword for every data element in part 6,
	data dictionary. Some of the keys used in this implementation differ
	from the ones now defined in the standard. This method corrects the
	set the names of the data elements defined in this implementation using
	the keys from part 6.

	PRD - September 13, 2017"

	| dictionaryDataElement method |
	self subclasses do: [ :aSubclass | aSubclass correctedDataElementNames ].

	(InformationObjectModules isKindOf: OrderedCollection) ifTrue: [
		InformationObjectModules do: [:iomClass | 
			(iomClass DataElements isDictionary) ifTrue: [
				iomClass DataElements do: [:dataElement |
					"look for the DICOM data element definition in the data dictinary"
					dictionaryDataElement := DicomRegistry DataDictionary at: dataElement tag ifAbsent: [ nil ].
					dictionaryDataElement notNil
						ifTrue: [ 
							dataElement name = dictionaryDataElement name
								ifFalse: [

					Transcript show: self class printString; tab; show: dataElement name; tab; show: dictionaryDataElement name; cr.

					method := self computerReflection_accessor_01_for: dictionaryDataElement iomClass: iomClass.
					MethodAddition new
						compile: method
							classified: 'accessing IOM data elements'
							withStamp: DateAndTime now printString
							notifying: nil 
							logSource: true
							inClass: self; compile.

					method := self computerReflection_accessor_01_for: dataElement iomClass: iomClass newName: dictionaryDataElement name.
					MethodAddition new
						compile: method
							classified: 'accessing IOM data elements - talkDICOM names'
							withStamp: DateAndTime now printString
							notifying: nil 
							logSource: true
							inClass: self; compile.

					method := self computerReflection_accessor_02_for: dictionaryDataElement iomClass: iomClass.
					MethodAddition new
						compile: method
							classified: 'accessing IOM data elements'
							withStamp: DateAndTime now printString
							notifying: nil 
							logSource: true
							inClass: self; 	compile.
								
					method := self computerReflection_accessor_02_for: dataElement iomClass: iomClass newName: dictionaryDataElement name.
					MethodAddition new
						compile: method
							classified: 'accessing IOM data elements - talkDICOM names'
							withStamp: DateAndTime now printString
							notifying: nil 
							logSource: true
							inClass: self; 	compile  ] ] ] ] ] ]
			"dataElement name: dictionaryDataElement name"
]

{ #category : #'computer reflection' }
DicomIOD class >> correctedDataElementNames_II [
	"Computer Reflection is Cool!!!

	The DICOM standard define a keyword for every data element in part 6,
	data dictionary. Some of the keys used in this implementation differ
	from the ones now defined in the standard. This method corrects the
	set the names of the data elements defined in this implementation using
	the keys from part 6.

	PRD - September 13, 2017"

	| dictionaryDataElement |
	self subclasses do: [ :aSubclass | aSubclass correctedDataElementNames_II ].
	(InformationObjectModules isKindOf: OrderedCollection)
		ifTrue: [ InformationObjectModules
				do: [ :iomClass | 
					iomClass DataElements isDictionary
						ifTrue: [ iomClass DataElements
								do: [ :dataElement | 
									"look for the DICOM data element definition in the data dictinary"
									dictionaryDataElement := DicomRegistry DataDictionary at: dataElement tag ifAbsent: [ nil ].
									dictionaryDataElement notNil
										ifTrue: [ dataElement name = dictionaryDataElement name
												ifFalse: [ dataElement name: dictionaryDataElement name.
													iomClass DataElementsByName at: dictionaryDataElement name put: dataElement ] ] ] ] ] ].
	DataElements isDictionary
		ifTrue: [ DataElements
				do: [ :dataElement | 
					"look for the DICOM data element definition in the data dictinary"
					dictionaryDataElement := DicomRegistry DataDictionary at: dataElement tag ifAbsent: [ nil ].
					dictionaryDataElement notNil
						ifTrue: [ "ifPresent: [ :dicomDefinition | dataElement name: dicomDefinition name ]"
							dataElement name = dictionaryDataElement name
								ifFalse: [ Transcript
										show: self class printString;
										tab;
										show: dataElement name;
										tab;
										show: dictionaryDataElement name;
										cr.
									dataElement name: dictionaryDataElement name.
									DataElementsByName at: dictionaryDataElement name put: dataElement ] ] ] ]
]

{ #category : #printing }
DicomIOD class >> dataElementsTable [
"
	Return a string of characters with a table listing all the
	DICOM data elements that compose the IOD definition.
	PRD - July 15th 2004
"

	| aStream |
	aStream := WriteStream on: String new.
	80 timesRepeat: [aStream nextPutAll: '-'].
	aStream cr; nextPutAll: self DicomIODName; cr.
	80 timesRepeat: [aStream nextPutAll: '-'].
	aStream cr; cr.
	(SortedCollection withAll: DataElements) do: [:dataElement |
		aStream nextPutAll: dataElement printTableEntry
	].
	^aStream contents
]

{ #category : #initialize }
DicomIOD class >> initialize [

	self resetDataElements.

	"Take all the data elements from the information object modules 
	and add them to the list of Data Elements of the Information Object Definition"
	self InformationObjectModules
		do: [:iom | iom DataElements do: [:dataElement | self addDataElement: dataElement]].

	self SOPClassUID notNil ifTrue: 
			["Register myself as the Smalltalk Class as 
			Object for the Service-Object-Pair class UID"
			DicomRegistry SOPClasses at: self SOPClassUID put: self]
]

{ #category : #'computer reflection' }
DicomIOD class >> instanceVariableNames [
	| superInstSize orderedCollection |
	orderedCollection := OrderedCollection new.
	(superInstSize := self superclass notNil
		ifTrue: [ self superclass instSize ]
		ifFalse: [ 0 ]) > 0
		ifTrue: [ orderedCollection addAll: self superclass instanceVariableNames ].
	1 to: self instSize - superInstSize do: [ :i | orderedCollection add: (self instVarNames at: i) ].
	^ orderedCollection
]

{ #category : #comparing }
DicomIOD >> < aDicomIOD [
	"PRD - March 05th, 2004"

	^self subclassResponsibility
]

{ #category : #comparing }
DicomIOD >> <= aDicomIOD [
	"PRD - March 05th, 2004"

	^self subclassResponsibility
]

{ #category : #comparing }
DicomIOD >> > aDicomIOD [
	"PRD - March 05th, 2004"

	^self subclassResponsibility
]

{ #category : #comparing }
DicomIOD >> >= aDicomIOD [
	"PRD - March 05th, 2004"

	^self subclassResponsibility
]

{ #category : #accessing }
DicomIOD >> SOPClassUID [

	^self class SOPClassUID
]

{ #category : #pseudonymization }
DicomIOD >> _pseudonymize: pseudonym [
	"dcmodify -nb -imt -m PatientID=MEDINA_003987_01 -m
PatientName=MEDINA_003987_01  -e PatientBirthName -e PatientAddress -e
PatientTelephoneNumbers -ep path-to-file"

	"Dirks Script"
	(self canUnderstand: #patientID:)
		ifTrue: [ self patientID: pseudonym ].
	(self canUnderstand: #patientName:)
		ifTrue: [ self patientName: pseudonym ].
	(self canUnderstand: #patientBirthName:)
		ifTrue: [ self patientBirthName: '' ].
	(self canUnderstand: #patientAddress:)
		ifTrue: [ self patientAddress: '' ].
	(self canUnderstand: #patientTelephoneNumbers:)
		ifTrue: [ self patientTelephoneNumbers: '' ].
		
	"Obvious data elements"
	(self canUnderstand: #otherPatientNames)
		ifTrue: [ self otherPatientNames: '' ].
	(self canUnderstand: #patientMotherBirthName)
		ifTrue: [ self patientMotherBirthName: '' ].
		

]

{ #category : #converting }
DicomIOD >> asDICOMDIR_IE [

	^self subclassResponsibility
]

{ #category : #converting }
DicomIOD >> asDicomImage [
	"Create an instance of the appropriated graphical wrapper for my subclasse instances.

	PRD - June 11th, 2003"

	^self subclassResponsibility
]

{ #category : #accessing }
DicomIOD >> bsonDictionary: aDictionary [

	| iom |

	super bsonDictionary: aDictionary.
	self informationObjectModules do: 
			[:each |
			iom := each new.
			iom encoder: self encoder.
			iom dataElementsDictionary: self dataElementsDictionary.
			iom dataElementsValues: self dataElementsValues.
			self perform: (each moduleName , ':') asSymbol with: iom].
]

{ #category : #checking }
DicomIOD >> checkIOD [
	"Check the consistency of the DICOM IOD. 
	At a first moment, each IOM is checked individually.

	PRD 06-07.2001 - 01.2002"

	self informationObjectModules do: 
			[:each |
			(self perform: each moduleName asSymbol) checkIOM	"*** Inocuous code - some exception handling code must be writen for this ******"]
]

{ #category : #printing }
DicomIOD >> dataElementsTable [
"
	Return a string of characters with a table listing all the
	DICOM data elements that compose the IOD definition.
	PRD - July 15th 2004
"

	| aStream |
	aStream := WriteStream on: String new.
	(SortedCollection withAll: self dataElementsDefinition) do: [:dataElement |
		aStream nextPutAll: dataElement printTableEntry; cr.
	].
	^aStream contents
]

{ #category : #printing }
DicomIOD >> dataElementsTableWithValues [
	"Return a string of characters with a table listing all the DICOM 
	data elements that compose the IOD definition. 	PRD - July 15th 2004"

	| aStream |
	aStream := WriteStream on: String new.
	(SortedCollection withAll: self dataElementsCollection) do: 
			[:dataElement |
			dataElement elementNumber == 0
				ifFalse: 
					[aStream
						nextPutAll: dataElement printTableEntryWithValues;
						cr]].
	^aStream contents
]

{ #category : #accessing }
DicomIOD >> encoder: aDicomTransferSyntax [

	| iom |

	super encoder: aDicomTransferSyntax.
	self informationObjectModules do: 
			[:each |
			iom := each new.
			iom encoder: aDicomTransferSyntax.
			iom dataElementsDictionary: self dataElementsDictionary.
			iom dataElementsValues: self dataElementsValues.
			self perform: (each moduleName , ':') asSymbol with: iom].
]

{ #category : #'unique identifiers' }
DicomIOD >> identifyIOD [

	| studyInstanceUID seriesInstanceUID sopInstanceUID |

	studyInstanceUID := self newStudyInstanceUID.
	seriesInstanceUID := self newSeriesInstanceUID: studyInstanceUID seriesNumber: self seriesNumber.
	sopInstanceUID := self newSOPInstanceUID: seriesInstanceUID instanceNumber: self instanceNumber.

	self studyInstanceUID: studyInstanceUID.
	self seriesInstanceUID: seriesInstanceUID.
	self sopInstanceUID: sopInstanceUID.
]

{ #category : #accessing }
DicomIOD >> informationObjectModules [

	^self class InformationObjectModules
]

{ #category : #'unique identifiers' }
DicomIOD >> newSOPInstanceUID: seriesInstanceUID instanceNumber: aNumber [
	"See PS 3.5-2000 Annex B"

	^ seriesInstanceUID , '.' , aNumber , '.' , Time now asSeconds printString
]

{ #category : #'unique identifiers' }
DicomIOD >> newSeriesInstanceUID: studyInstanceUID seriesNumber: aSeriesNumber [
	"See PS 3.5-2000 Annex B"

	^ studyInstanceUID , '.' , aSeriesNumber
]

{ #category : #'unique identifiers' }
DicomIOD >> newStudyInstanceUID [
	"Root numbers explanation:

	1 		= ISO
	2 		= ANSI Member Body
      840 	= Country Code (U.S.)
	81469 	=  Member Organization Identifier (bogus)

	Suffix:
	01 		= SmallDICOM Software Identification
      0000	= SmallDICOM Software Serial Number

	See PS 3.5-2000 Annex B"	
	

	| root suffix |
	root := '1.2.840.81469'.
	suffix := '01.0000.', DateAndTime now asSeconds  printString.

	^root, '.', suffix
]

{ #category : #parsing }
DicomIOD >> pdvBytesStream: dicomPDVStream encoder: aDicomTransferSyntax [

	"encoder := aDicomTransferSyntax."

	| iom |
	super pdvBytesStream: dicomPDVStream encoder: aDicomTransferSyntax.
	self informationObjectModules do: 
			[:each |
			iom := each new.
			iom encoder: aDicomTransferSyntax.
			iom dataElementsDictionary: self dataElementsDictionary.
			iom dataElementsValues: self dataElementsValues.
			self perform: (each moduleName , ':') asSymbol with: iom].
	self checkIOD
]

{ #category : #pseudonymization }
DicomIOD >> pseudonymize: pseudonym [
	"dcmodify -nb -imt -m PatientID=MEDINA_003987_01 -m
PatientName=MEDINA_003987_01  -e PatientBirthName -e PatientAddress -e
PatientTelephoneNumbers -ep path-to-file"

	"Since it is not guaranteed that the IOD subclass implements the accessor
	to the data element, manipulate the values directly in the data elements
	dictionary (very ugly!) - PRD October 20, 2017"
	
	"Dirks Script"
	self pseudonymizeDataElement: #patientID value: pseudonym.
	self pseudonymizeDataElement: #patientName value: pseudonym.
	self pseudonymizeDataElement: #patientBirthName value: ''.
	self pseudonymizeDataElement: #patientAddress value: ''.
	self pseudonymizeDataElement: #patientTelephoneNumbers value: ''.

	"Other obvious data elements"
	self pseudonymizeDataElement: #otherPatientNames value: ''.
	self pseudonymizeDataElement: #patientMotherBirthName value: ''.

	"Other (not so) obvious data elements"
	"Private Creators Group of Data Elements:			
		0033;‘MITRA OBJECT UTF8 ATTRIBUTES 1.0‘;0002	'Patient Name (UTF8 Encoded)'
		0033;‘MITRA OBJECT UTF8 ATTRIBUTES 1.0‘;0013	'Patient's Name'"
	



]

{ #category : #pseudonymization }
DicomIOD >> pseudonymizeDataElement: aSymbolName value: anObject [
	| dataElement |
	dataElement := self dataElementsDictionary at: aSymbolName ifAbsent: [ nil ].
	dataElement notNil
		ifTrue: [ dataElement value: anObject ]
]