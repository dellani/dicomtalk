Class {
	#name : #SRDocumentContentIOM,
	#superclass : #DicomIOM,
	#category : #'talkDICOM-Objects'
}

{ #category : #'class initialization' }
SRDocumentContentIOM class >> initialize [
	"Initialize the dictionary of DICOM Data Elements for the DICOM SR 
	Document Content Information Object Module
	Dicom Standard Supplement 23 - Table C.17.3-3
	DICOM Structured Reporting
	PRD, Charnovscki December 19th, 2001 - 03.2002
	RC MS- Jan 24th, 2002"

	self resetDataElements.
	Name := 'DICOM SR Document General Information Object Module'.
	moduleName := 'srDocumentContentIOM'.

	"DICOM SOP Instance Reference Macro Sequence Item - initialization method
	Table C.17.3-4 specifies the Attributes that reference a Document Relatiionship Macro
	************************************   Supplement 23 Table C.17.3-4 *************************************************************"
	self
		addDataElement:
			(DTDataElement
				newWith: #observationDateTime
				tag: #(16r0040 16rA032)
				vm: '1'
				type: '1C').
	self
		addDataElement:
			(SQDataElement
				newWith: #contentTemplateSequence
				tag: #(16r0040 16rA504)
				vm: '1'
				type: '1C'
				sequenceItemClass: ContentTemplateSequenceItem).
	self
		addDataElement:
			(SQDataElement
				newWith: #contentSequence
				tag: #(16r0040 16rA730)
				vm: '1'
				type: '1C'
				sequenceItemClass: ContentSequenceItem).

	"****************** Document Content Macro  - PS 3.3-2001 Table 17.3-5 *************************"
	self
		addDataElement:
			(CSDataElement
				newWith: #valueType
				tag: #(16r0040 16rA040)
				vm: '1'
				type: '1').
	self
		addDataElement:
			(SQDataElement
				newWith: #conceptNameCodeSequence
				tag: #(16r0040 16rA043)
				vm: '1'
				type: '1C'
				sequenceItemClass: ConceptNameCodeSequenceItem).
	self
		addDataElement:
			(CSDataElement
				newWith: #continuityOfContent
				tag: #(16r0040 16rA050)
				vm: '1'
				type: '1C').
	self
		addDataElement:
			(UTDataElement
				newWith: #textValue
				tag: #(16r0040 16rA160)
				vm: '1'
				type: '1C').
	self
		addDataElement:
			(DTDataElement
				newWith: #dateTime
				tag: #(16r0040 16rA120)
				vm: '1'
				type: '1C').
	self
		addDataElement:
			(DADataElement
				newWith: #date
				tag: #(16r0040 16rA121)
				vm: '1'
				type: '1C').
	self
		addDataElement:
			(TMDataElement
				newWith: #time
				tag: #(16r0040 16rA122)
				vm: '1'
				type: '1C').
	self
		addDataElement:
			(PNDataElement
				newWith: #personName
				tag: #(16r0040 16rA123)
				vm: '1'
				type: '1C').
	self
		addDataElement:
			(UIDataElement
				newWith: #UID
				tag: #(16r0040 16rA124)
				vm: '1'
				type: '1C').
	self
		addDataElement:
			(SQDataElement
				newWith: #measuredValueSequence
				tag: #(16r0040 16rA300)
				vm: '1'
				type: '2'
				sequenceItemClass: MeasuredValueSequenceItem).
	self
		addDataElement:
			(SQDataElement
				newWith: #conceptCodeSequence
				tag: #(16r0040 16rA168)
				vm: '1'
				type: '1'
				sequenceItemClass: ConceptCodeSequenceItem).
	self
		addDataElement:
			(SQDataElement
				newWith: #referencedSOPSequence
				tag: #(16r0008 16r1199)
				vm: '1'
				type: '1'
				sequenceItemClass: ReferencedSOPSequenceItem).
	self
		addDataElement:
			(FLDataElement
				newWith: #graphicData
				tag: #(16r0070 16r0022)
				vm: '2-n'
				type: '1').
	self
		addDataElement:
			(CSDataElement
				newWith: #graphicType
				tag: #(16r0070 16r0023)
				vm: '1'
				type: '1').
	self
		addDataElement:
			(CSDataElement
				newWith: #temporalRangeType
				tag: #(16r0040 16rA130)
				vm: '1'
				type: '1').
	self
		addDataElement:
			(ULDataElement
				newWith: #referencedSamplePositions
				tag: #(16r0040 16rA132)
				vm: '1-n'
				type: '1C').
	self
		addDataElement:
			(DSDataElement
				newWith: #referencedTimeOffsets
				tag: #(16r0040 16rA138)
				vm: '1-n'
				type: '1C').
	self
		addDataElement:
			(DTDataElement
				newWith: #referencedDatetime
				tag: #(16r0040 16rA13A)
				vm: '1-n'
				type: '1C')
]

{ #category : #'accessing - talkDICOM names' }
SRDocumentContentIOM >> UID [

	^self dataElementsValues at: 'uID' ifAbsent: [
		self dataElementsDictionary at: 'uID' ifPresent: [:dataElement |
			self dataElementsValues at: 'uID' put: (self dataElementsDictionary removeKey: 'uID') value.
		]
	]

]

{ #category : #'accessing - talkDICOM names' }
SRDocumentContentIOM >> UID: aUIValue [

	| dataElement |

	(self dataElementsDictionary at: 'uID' ifPresent: [:aDataElement | aDataElement value: aUIValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #uID.
			dataElement encoder: self encoder.
			dataElement value: aUIValue.
			self dataElementsDictionary at: 'uID' put: dataElement.
			self dataElementsValues removeKey: 'uID' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'uID' put: aUIValue
		]
	].

]

{ #category : #checking }
SRDocumentContentIOM >> checkIOM [
"
	Do some basic checking in the IOM data
	PRD 01.2002
"

	^true.
]

{ #category : #accessing }
SRDocumentContentIOM >> conceptCodeSequence [

	^self dataElementsValues at: 'conceptCodeSequence' ifAbsent: [
		self dataElementsDictionary at: 'conceptCodeSequence' ifPresent: [:dataElement |
			self dataElementsValues at: 'conceptCodeSequence' put: (self dataElementsDictionary removeKey: 'conceptCodeSequence') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> conceptCodeSequence: aSQValue [

	| dataElement |

	(self dataElementsDictionary at: 'conceptCodeSequence' ifPresent: [:aDataElement | aDataElement value: aSQValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #conceptCodeSequence.
			dataElement encoder: self encoder.
			dataElement value: aSQValue.
			self dataElementsDictionary at: 'conceptCodeSequence' put: dataElement.
			self dataElementsValues removeKey: 'conceptCodeSequence' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'conceptCodeSequence' put: aSQValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> conceptNameCodeSequence [

	^self dataElementsValues at: 'conceptNameCodeSequence' ifAbsent: [
		self dataElementsDictionary at: 'conceptNameCodeSequence' ifPresent: [:dataElement |
			self dataElementsValues at: 'conceptNameCodeSequence' put: (self dataElementsDictionary removeKey: 'conceptNameCodeSequence') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> conceptNameCodeSequence: aSQValue [

	| dataElement |

	(self dataElementsDictionary at: 'conceptNameCodeSequence' ifPresent: [:aDataElement | aDataElement value: aSQValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #conceptNameCodeSequence.
			dataElement encoder: self encoder.
			dataElement value: aSQValue.
			self dataElementsDictionary at: 'conceptNameCodeSequence' put: dataElement.
			self dataElementsValues removeKey: 'conceptNameCodeSequence' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'conceptNameCodeSequence' put: aSQValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> contentSequence [

	^self dataElementsValues at: 'contentSequence' ifAbsent: [
		self dataElementsDictionary at: 'contentSequence' ifPresent: [:dataElement |
			self dataElementsValues at: 'contentSequence' put: (self dataElementsDictionary removeKey: 'contentSequence') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> contentSequence: aSQValue [

	| dataElement |

	(self dataElementsDictionary at: 'contentSequence' ifPresent: [:aDataElement | aDataElement value: aSQValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #contentSequence.
			dataElement encoder: self encoder.
			dataElement value: aSQValue.
			self dataElementsDictionary at: 'contentSequence' put: dataElement.
			self dataElementsValues removeKey: 'contentSequence' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'contentSequence' put: aSQValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> contentTemplateSequence [

	^self dataElementsValues at: 'contentTemplateSequence' ifAbsent: [
		self dataElementsDictionary at: 'contentTemplateSequence' ifPresent: [:dataElement |
			self dataElementsValues at: 'contentTemplateSequence' put: (self dataElementsDictionary removeKey: 'contentTemplateSequence') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> contentTemplateSequence: aSQValue [

	| dataElement |

	(self dataElementsDictionary at: 'contentTemplateSequence' ifPresent: [:aDataElement | aDataElement value: aSQValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #contentTemplateSequence.
			dataElement encoder: self encoder.
			dataElement value: aSQValue.
			self dataElementsDictionary at: 'contentTemplateSequence' put: dataElement.
			self dataElementsValues removeKey: 'contentTemplateSequence' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'contentTemplateSequence' put: aSQValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> continuityOfContent [

	^self dataElementsValues at: 'continuityOfContent' ifAbsent: [
		self dataElementsDictionary at: 'continuityOfContent' ifPresent: [:dataElement |
			self dataElementsValues at: 'continuityOfContent' put: (self dataElementsDictionary removeKey: 'continuityOfContent') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> continuityOfContent: aCSValue [

	| dataElement |

	(self dataElementsDictionary at: 'continuityOfContent' ifPresent: [:aDataElement | aDataElement value: aCSValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #continuityOfContent.
			dataElement encoder: self encoder.
			dataElement value: aCSValue.
			self dataElementsDictionary at: 'continuityOfContent' put: dataElement.
			self dataElementsValues removeKey: 'continuityOfContent' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'continuityOfContent' put: aCSValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> date [

	^self dataElementsValues at: 'date' ifAbsent: [
		self dataElementsDictionary at: 'date' ifPresent: [:dataElement |
			self dataElementsValues at: 'date' put: (self dataElementsDictionary removeKey: 'date') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> date: aDAValue [

	| dataElement |

	(self dataElementsDictionary at: 'date' ifPresent: [:aDataElement | aDataElement value: aDAValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #date.
			dataElement encoder: self encoder.
			dataElement value: aDAValue.
			self dataElementsDictionary at: 'date' put: dataElement.
			self dataElementsValues removeKey: 'date' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'date' put: aDAValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> dateTime [

	^self dataElementsValues at: 'dateTime' ifAbsent: [
		self dataElementsDictionary at: 'dateTime' ifPresent: [:dataElement |
			self dataElementsValues at: 'dateTime' put: (self dataElementsDictionary removeKey: 'dateTime') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> dateTime: aDTValue [

	| dataElement |

	(self dataElementsDictionary at: 'dateTime' ifPresent: [:aDataElement | aDataElement value: aDTValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #dateTime.
			dataElement encoder: self encoder.
			dataElement value: aDTValue.
			self dataElementsDictionary at: 'dateTime' put: dataElement.
			self dataElementsValues removeKey: 'dateTime' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'dateTime' put: aDTValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> graphicData [

	^self dataElementsValues at: 'graphicData' ifAbsent: [
		self dataElementsDictionary at: 'graphicData' ifPresent: [:dataElement |
			self dataElementsValues at: 'graphicData' put: (self dataElementsDictionary removeKey: 'graphicData') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> graphicData: aFLValue [

	| dataElement |

	(self dataElementsDictionary at: 'graphicData' ifPresent: [:aDataElement | aDataElement value: aFLValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #graphicData.
			dataElement encoder: self encoder.
			dataElement value: aFLValue.
			self dataElementsDictionary at: 'graphicData' put: dataElement.
			self dataElementsValues removeKey: 'graphicData' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'graphicData' put: aFLValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> graphicType [

	^self dataElementsValues at: 'graphicType' ifAbsent: [
		self dataElementsDictionary at: 'graphicType' ifPresent: [:dataElement |
			self dataElementsValues at: 'graphicType' put: (self dataElementsDictionary removeKey: 'graphicType') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> graphicType: aCSValue [

	| dataElement |

	(self dataElementsDictionary at: 'graphicType' ifPresent: [:aDataElement | aDataElement value: aCSValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #graphicType.
			dataElement encoder: self encoder.
			dataElement value: aCSValue.
			self dataElementsDictionary at: 'graphicType' put: dataElement.
			self dataElementsValues removeKey: 'graphicType' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'graphicType' put: aCSValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> measuredValueSequence [

	^self dataElementsValues at: 'measuredValueSequence' ifAbsent: [
		self dataElementsDictionary at: 'measuredValueSequence' ifPresent: [:dataElement |
			self dataElementsValues at: 'measuredValueSequence' put: (self dataElementsDictionary removeKey: 'measuredValueSequence') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> measuredValueSequence: aSQValue [

	| dataElement |

	(self dataElementsDictionary at: 'measuredValueSequence' ifPresent: [:aDataElement | aDataElement value: aSQValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #measuredValueSequence.
			dataElement encoder: self encoder.
			dataElement value: aSQValue.
			self dataElementsDictionary at: 'measuredValueSequence' put: dataElement.
			self dataElementsValues removeKey: 'measuredValueSequence' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'measuredValueSequence' put: aSQValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> observationDateTime [

	^self dataElementsValues at: 'observationDateTime' ifAbsent: [
		self dataElementsDictionary at: 'observationDateTime' ifPresent: [:dataElement |
			self dataElementsValues at: 'observationDateTime' put: (self dataElementsDictionary removeKey: 'observationDateTime') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> observationDateTime: aDTValue [

	| dataElement |

	(self dataElementsDictionary at: 'observationDateTime' ifPresent: [:aDataElement | aDataElement value: aDTValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #observationDateTime.
			dataElement encoder: self encoder.
			dataElement value: aDTValue.
			self dataElementsDictionary at: 'observationDateTime' put: dataElement.
			self dataElementsValues removeKey: 'observationDateTime' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'observationDateTime' put: aDTValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> personName [

	^self dataElementsValues at: 'personName' ifAbsent: [
		self dataElementsDictionary at: 'personName' ifPresent: [:dataElement |
			self dataElementsValues at: 'personName' put: (self dataElementsDictionary removeKey: 'personName') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> personName: aPNValue [

	| dataElement |

	(self dataElementsDictionary at: 'personName' ifPresent: [:aDataElement | aDataElement value: aPNValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #personName.
			dataElement encoder: self encoder.
			dataElement value: aPNValue.
			self dataElementsDictionary at: 'personName' put: dataElement.
			self dataElementsValues removeKey: 'personName' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'personName' put: aPNValue
		]
	].

]

{ #category : #printing }
SRDocumentContentIOM >> printOn: aStream [

	aStream nextPutAll:  self valueType printString.
]

{ #category : #accessing }
SRDocumentContentIOM >> referencedDateTime [

	^self dataElementsValues at: 'referencedDateTime' ifAbsent: [
		self dataElementsDictionary at: 'referencedDateTime' ifPresent: [:dataElement |
			self dataElementsValues at: 'referencedDateTime' put: (self dataElementsDictionary removeKey: 'referencedDateTime') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> referencedDateTime: aDTValue [

	| dataElement |

	(self dataElementsDictionary at: 'referencedDateTime' ifPresent: [:aDataElement | aDataElement value: aDTValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #referencedDateTime.
			dataElement encoder: self encoder.
			dataElement value: aDTValue.
			self dataElementsDictionary at: 'referencedDateTime' put: dataElement.
			self dataElementsValues removeKey: 'referencedDateTime' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'referencedDateTime' put: aDTValue
		]
	].

]

{ #category : #'accessing - talkDICOM names' }
SRDocumentContentIOM >> referencedDatetime [

	^self dataElementsValues at: 'referencedDateTime' ifAbsent: [
		self dataElementsDictionary at: 'referencedDateTime' ifPresent: [:dataElement |
			self dataElementsValues at: 'referencedDateTime' put: (self dataElementsDictionary removeKey: 'referencedDateTime') value.
		]
	]

]

{ #category : #'accessing - talkDICOM names' }
SRDocumentContentIOM >> referencedDatetime: aDTValue [

	| dataElement |

	(self dataElementsDictionary at: 'referencedDateTime' ifPresent: [:aDataElement | aDataElement value: aDTValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #referencedDateTime.
			dataElement encoder: self encoder.
			dataElement value: aDTValue.
			self dataElementsDictionary at: 'referencedDateTime' put: dataElement.
			self dataElementsValues removeKey: 'referencedDateTime' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'referencedDateTime' put: aDTValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> referencedSOPSequence [

	^self dataElementsValues at: 'referencedSOPSequence' ifAbsent: [
		self dataElementsDictionary at: 'referencedSOPSequence' ifPresent: [:dataElement |
			self dataElementsValues at: 'referencedSOPSequence' put: (self dataElementsDictionary removeKey: 'referencedSOPSequence') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> referencedSOPSequence: aSQValue [

	| dataElement |

	(self dataElementsDictionary at: 'referencedSOPSequence' ifPresent: [:aDataElement | aDataElement value: aSQValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #referencedSOPSequence.
			dataElement encoder: self encoder.
			dataElement value: aSQValue.
			self dataElementsDictionary at: 'referencedSOPSequence' put: dataElement.
			self dataElementsValues removeKey: 'referencedSOPSequence' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'referencedSOPSequence' put: aSQValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> referencedSamplePositions [

	^self dataElementsValues at: 'referencedSamplePositions' ifAbsent: [
		self dataElementsDictionary at: 'referencedSamplePositions' ifPresent: [:dataElement |
			self dataElementsValues at: 'referencedSamplePositions' put: (self dataElementsDictionary removeKey: 'referencedSamplePositions') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> referencedSamplePositions: aULValue [

	| dataElement |

	(self dataElementsDictionary at: 'referencedSamplePositions' ifPresent: [:aDataElement | aDataElement value: aULValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #referencedSamplePositions.
			dataElement encoder: self encoder.
			dataElement value: aULValue.
			self dataElementsDictionary at: 'referencedSamplePositions' put: dataElement.
			self dataElementsValues removeKey: 'referencedSamplePositions' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'referencedSamplePositions' put: aULValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> referencedTimeOffsets [

	^self dataElementsValues at: 'referencedTimeOffsets' ifAbsent: [
		self dataElementsDictionary at: 'referencedTimeOffsets' ifPresent: [:dataElement |
			self dataElementsValues at: 'referencedTimeOffsets' put: (self dataElementsDictionary removeKey: 'referencedTimeOffsets') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> referencedTimeOffsets: aDSValue [

	| dataElement |

	(self dataElementsDictionary at: 'referencedTimeOffsets' ifPresent: [:aDataElement | aDataElement value: aDSValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #referencedTimeOffsets.
			dataElement encoder: self encoder.
			dataElement value: aDSValue.
			self dataElementsDictionary at: 'referencedTimeOffsets' put: dataElement.
			self dataElementsValues removeKey: 'referencedTimeOffsets' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'referencedTimeOffsets' put: aDSValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> temporalRangeType [

	^self dataElementsValues at: 'temporalRangeType' ifAbsent: [
		self dataElementsDictionary at: 'temporalRangeType' ifPresent: [:dataElement |
			self dataElementsValues at: 'temporalRangeType' put: (self dataElementsDictionary removeKey: 'temporalRangeType') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> temporalRangeType: aCSValue [

	| dataElement |

	(self dataElementsDictionary at: 'temporalRangeType' ifPresent: [:aDataElement | aDataElement value: aCSValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #temporalRangeType.
			dataElement encoder: self encoder.
			dataElement value: aCSValue.
			self dataElementsDictionary at: 'temporalRangeType' put: dataElement.
			self dataElementsValues removeKey: 'temporalRangeType' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'temporalRangeType' put: aCSValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> textValue [

	^self dataElementsValues at: 'textValue' ifAbsent: [
		self dataElementsDictionary at: 'textValue' ifPresent: [:dataElement |
			self dataElementsValues at: 'textValue' put: (self dataElementsDictionary removeKey: 'textValue') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> textValue: aUTValue [

	| dataElement |

	(self dataElementsDictionary at: 'textValue' ifPresent: [:aDataElement | aDataElement value: aUTValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #textValue.
			dataElement encoder: self encoder.
			dataElement value: aUTValue.
			self dataElementsDictionary at: 'textValue' put: dataElement.
			self dataElementsValues removeKey: 'textValue' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'textValue' put: aUTValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> time [

	^self dataElementsValues at: 'time' ifAbsent: [
		self dataElementsDictionary at: 'time' ifPresent: [:dataElement |
			self dataElementsValues at: 'time' put: (self dataElementsDictionary removeKey: 'time') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> time: aTMValue [

	| dataElement |

	(self dataElementsDictionary at: 'time' ifPresent: [:aDataElement | aDataElement value: aTMValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #time.
			dataElement encoder: self encoder.
			dataElement value: aTMValue.
			self dataElementsDictionary at: 'time' put: dataElement.
			self dataElementsValues removeKey: 'time' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'time' put: aTMValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> uID [

	^self dataElementsValues at: 'uID' ifAbsent: [
		self dataElementsDictionary at: 'uID' ifPresent: [:dataElement |
			self dataElementsValues at: 'uID' put: (self dataElementsDictionary removeKey: 'uID') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> uID: aUIValue [

	| dataElement |

	(self dataElementsDictionary at: 'uID' ifPresent: [:aDataElement | aDataElement value: aUIValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #uID.
			dataElement encoder: self encoder.
			dataElement value: aUIValue.
			self dataElementsDictionary at: 'uID' put: dataElement.
			self dataElementsValues removeKey: 'uID' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'uID' put: aUIValue
		]
	].

]

{ #category : #accessing }
SRDocumentContentIOM >> valueType [

	^self dataElementsValues at: 'valueType' ifAbsent: [
		self dataElementsDictionary at: 'valueType' ifPresent: [:dataElement |
			self dataElementsValues at: 'valueType' put: (self dataElementsDictionary removeKey: 'valueType') value.
		]
	]

]

{ #category : #accessing }
SRDocumentContentIOM >> valueType: aCSValue [

	| dataElement |

	(self dataElementsDictionary at: 'valueType' ifPresent: [:aDataElement | aDataElement value: aCSValue]) isNil ifTrue: [
		encoder notNil ifTrue: [
			dataElement := self newDataElementNamed: #valueType.
			dataElement encoder: self encoder.
			dataElement value: aCSValue.
			self dataElementsDictionary at: 'valueType' put: dataElement.
			self dataElementsValues removeKey: 'valueType' ifAbsent: [nil].
		]
		ifFalse: [
			self dataElementsValues at: 'valueType' put: aCSValue
		]
	].

]