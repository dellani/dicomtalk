Class {
	#name : #FixedSizeDataElement,
	#superclass : #DataElement,
	#category : #'talkDICOM-Data'
}

{ #category : #'field value retrieving' }
FixedSizeDataElement >> byteSize [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
FixedSizeDataElement >> createInstanceFrom: pdvStream transferSyntax: transferSyntaxEncoder [
	
	^transferSyntaxEncoder 
				fixedSizeDataElementFrom: pdvStream 
				definition: self.
]

{ #category : #'field value retrieving' }
FixedSizeDataElement >> dataBytesByteSpliter [
	"Split the DICOM multi-byte values (for VM > 1) that are coded in dataBytes 
	instance variable into an OrderedCollection and then answer the 
	OrderedCollection with the splited strings 
	'byteValueSize' contains the size of an individual multi-byte value - PRD 06-07.2002"

	^self dataBytesByteSpliter: self byteSize
]

{ #category : #'field value retrieving' }
FixedSizeDataElement >> dataBytesByteSpliter: byteValueSize [
	"Split the DICOM multi-byte values (for VM > 1) that are coded in dataBytes 
	instance variable into an OrderedCollection and then answer the 
	OrderedCollection with the splited strings 
	'byteValueSize' contains the size of an individual multi-byte value - PRD 06-07.2002"

	| anOrderedCollection |
	anOrderedCollection := OrderedCollection new.
	1 to: self dataBytes size
				by: byteValueSize
				do: 
					[:index |
					anOrderedCollection
						add: (self dataBytes copyFrom: index to: index + byteValueSize - 1)].
	^anOrderedCollection
]

{ #category : #accessing }
FixedSizeDataElement >> dataElementLength [
	"Data Length of the message field in bytes

	PRD 04-10.2001"

	^ self subclassResponsibility
]

{ #category : #'field value retrieving' }
FixedSizeDataElement >> decodeElementDataBytes: valueDataBytes [

	^self subclassResponsibility
]

{ #category : #'field value retrieving' }
FixedSizeDataElement >> decodeValue [
	"Decode value from DICOM data element with fixed size - PRD 04.2001
	
	Refactoring - PRD June 28, 2017, August 29, 2017"

	^ self dataBytesByteSpliter collect: [ :item | self decodeElementDataBytes: item ]
]

{ #category : #'field bytes' }
FixedSizeDataElement >> pdvBytes: aByteStream [
	"Put the byte-coding of this DICOM Data Element in to a ByteStream

	PRD - February 07th, 2003"

	^ self subclassResponsibility
]

{ #category : #printing }
FixedSizeDataElement >> printValueOn: aStream [
	"Print the Dicom Data Element Value to 'aStream' 

	PRD January 10th, 2003 - August 20th, 2015, August 29, 2017"

	| valueCollection |
	self dataBytes notEmpty
		ifTrue: [ self dataBytes size >= self byteSize
				ifTrue: [ (valueCollection := self decodeValue) notEmpty
						ifTrue: [ aStream nextPutAll: valueCollection first printString.
							2 to: valueCollection size do: [ :index | 
								aStream nextPutAll: ' \\ '.
								aStream nextPutAll: (valueCollection at: index) printString ] ] ] ]
]

{ #category : #'field value retrieving' }
FixedSizeDataElement >> raiseElementSizeError [
	| errorMessage |
	errorMessage := WriteStream on: String new.
	errorMessage nextPutAll: 'Type ', self type, ' Data element ', (self name notNil ifTrue: [self name] ifFalse: ['unknown']), ' #['.
	self groupNumber notNil ifTrue: [self groupNumber printOn: errorMessage base: 16] ifFalse: [errorMessage nextPutAll: 'unknown'].
	errorMessage nextPutAll: ', '.
	self elementNumber notNil ifTrue: [self elementNumber printOn: errorMessage base: 16] ifFalse: [errorMessage nextPutAll: 'unknown'].
	errorMessage nextPutAll: '] has less data bytes then its element byte size and could not be decoded'.

	^self type ~= '3' ifTrue: [
		DataElementEncodingError signalWithDataElement: self.
		"Error raiseSignal: errorMessage contents"
	] ifFalse: [
		Transcript show: errorMessage contents; cr.
		nil
	].
]

{ #category : #'field value storing' }
FixedSizeDataElement >> validateValue: aValue [
	"Perform the validation of the value to be stored in a DICOM Data Element

	PRD 04.2001 - 06.2002"

	^ self subclassResponsibility
]

{ #category : #'field value retrieving' }
FixedSizeDataElement >> value [
	"Decode value from DICOM data element with fixed size - PRD 04.2001
	
	Refactoring - PRD June 28, 2017"

	| orderedCollection |
	^ self dataBytes notEmpty
		ifTrue: [ self dataBytes size >= self byteSize
				ifTrue: [ orderedCollection := self decodeValue.
					orderedCollection size = 1
						ifTrue: [ orderedCollection at: 1 ]
						ifFalse: [ orderedCollection ] ]
				ifFalse: [ self type = '3'
						ifTrue: [ nil ]
						ifFalse: [ self raiseElementSizeError ] ] ]
		ifFalse: [ nil ]
]

{ #category : #'field value storing' }
FixedSizeDataElement >> value: aValue [
	"Calculate the bytes corresponding to aValue for a message field value representation from the 'Smalltalk representation'

	PRD 05.2001"

	self subclassResponsibility
]