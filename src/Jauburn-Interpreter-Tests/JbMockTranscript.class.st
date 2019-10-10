Class {
	#name : #JbMockTranscript,
	#superclass : #Object,
	#instVars : [
		'mtcontents'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #showing }
JbMockTranscript >> clear [ 

	mtcontents reset
]

{ #category : #showing }
JbMockTranscript >> contents [

	^mtcontents contents
]

{ #category : #showing }
JbMockTranscript >> cr [ 
    mtcontents nextPut: Character cr
]

{ #category : #showing }
JbMockTranscript >> initialize [ 

	mtcontents := String new writeStream
]

{ #category : #showing }
JbMockTranscript >> show: aString [

	mtcontents nextPutAll: aString
]
