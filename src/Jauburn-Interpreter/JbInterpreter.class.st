"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [
	^ #abs -> [ :f | f abs ]
]

{ #category : #primitives }
JbInterpreter >> concatBinding [
	^ #concat -> [ :s1 :s2 | s1, s2 ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [
	| prims |
	super initialize.
	environment := JbEnvironment new.
	prims := self class selectors
		select: [ :method | method endsWith: 'Binding' ].
	prims
		do: [ :method | 
			| prim |
			prim := self perform: method.
			environment at: prim key put: (JbPrimitive new block: prim value; yourself)]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [
	^ #length -> [ :s | s size ]
]

{ #category : #primitives }
JbInterpreter >> modBinding [
	^ #mod-> [ :a :b | a \\ b ]
]

{ #category : #primitives }
JbInterpreter >> notBinding [
	^ #not -> [ :b | b not ]
]

{ #category : #primitives }
JbInterpreter >> printBinding [
	^#print -> [ :value | Transcript show: value printString ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]
