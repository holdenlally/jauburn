Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #running }
JbInterpreterTest >> testComparisonExpressions [

	self interpret: 'var u = 1 == 1;'.
	self interpret: 'var v = 1 < 2;'.
	self interpret: 'var w = 2 <= 2;'.
	self interpret: 'var x = 2 > 1;'.
	self interpret: 'var y = 2 >= 2;'.
	self interpret: 'var z = 2 != 1;'.
	self assert: (interpreter environment at: 'u').
	self assert: (interpreter environment at: 'v').
	self assert: (interpreter environment at: 'w').
	self assert: (interpreter environment at: 'x').
	self assert: (interpreter environment at: 'y').
	self assert: (interpreter environment at: 'z').
	
	self interpret: 'var u = 1 == 2;'.
	self interpret: 'var v = 2 < 1;'.
	self interpret: 'var w = 2 <= 1;'.
	self interpret: 'var x = 1 > 2;'.
	self interpret: 'var y = 1 >= 2;'.
	self interpret: 'var z = 1 != 1;'.
	self deny: (interpreter environment at: 'u').
	self deny: (interpreter environment at: 'v').
	self deny: (interpreter environment at: 'w').
	self deny: (interpreter environment at: 'x').
	self deny: (interpreter environment at: 'y').
	self deny: (interpreter environment at: 'z').
	
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 3 - 4 / 2;'.
	self assert: (interpreter environment at: 'x') equals: 1.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #running }
JbInterpreterTest >> testFunction [
	
	self interpret: 'var x = function(a, b, c) {};'.
	self assert: (interpreter environment at: 'x') parameters size equals: 3.
	self assert: (interpreter environment at: 'x') body isEmpty.
	self assert: (interpreter environment at: 'x') environment equals: interpreter environment
	
]

{ #category : #running }
JbInterpreterTest >> testFunctionCall [
	
	self interpret: 'var x = function(a, b, c) {return a * b * c;};var y = x(1, 2, 3);'.
	self assert: (interpreter environment at: 'y') equals: 6
]

{ #category : #running }
JbInterpreterTest >> testIfElseLoop [
	self interpret: 'var x = 0; var y = 0; if (x == 0) {x = x + 5;} else {y = y + 5;}'.
	self assert: (interpreter environment at: 'x') equals: 5.
	self assert: (interpreter environment at: 'y') equals: 0
	
]

{ #category : #running }
JbInterpreterTest >> testIfLoop [
	self interpret: 'var y = 0; if (y < 1 ) {y = y + 1;}'.
	self assert: (interpreter environment at: 'y') equals: 1
]

{ #category : #running }
JbInterpreterTest >> testInput [
	| mu |
	mu := JbMockUIManager new.
	interpreter uimanager: mu.
	self interpret: 'var x = input("This is an example prompt");'.
	self assert: (interpreter environment at: 'x') equals: 'Example user output.'
]

{ #category : #running }
JbInterpreterTest >> testPrimitiveFunctionCalls [

	self interpret: 'var x = abs(-120);'.
	self interpret: 'var y = abs(120);'.
	self assert: (interpreter environment at: 'x') equals: 120.
	self assert: (interpreter environment at: 'y') equals: 120.
	
	self interpret: 'var x = concat("hello", " world");'.
	self interpret: 'var y = concat("a", "bc");'.
	self assert: (interpreter environment at: 'x') equals: 'hello world'.
	self assert: (interpreter environment at: 'y') equals: 'abc'.
	
	self interpret: 'var x = length("hello");'.
	self interpret: 'var y = length("");'.
	self assert: (interpreter environment at: 'x') equals: 5.
	self assert: (interpreter environment at: 'y') equals: 0.
	
	self interpret: 'var x = mod(10, 5);'.
	self interpret: 'var y = mod(-10, 5);'.
	self interpret: 'var z = mod(1, 2);'.
	self assert: (interpreter environment at: 'x') equals: 0.
	self assert: (interpreter environment at: 'y') equals: 0.
	self assert: (interpreter environment at: 'z') equals: 1.
	
	self interpret: 'var x = not(true);'.
	self interpret: 'var y = not(false);'.
	self deny: (interpreter environment at: 'x').
	self assert: (interpreter environment at: 'y').
	

	
	
]

{ #category : #running }
JbInterpreterTest >> testPrintAndPrintLn [
	| mt |
	mt := JbMockTranscript new.
	interpreter transcript: mt.
	self interpret: 'var x = print("hello");'.
	self assert: mt contents equals: 'hello'.
	mt clear.
	self interpret: 'var x = print(123);'.
	self assert: mt contents equals: '123'.
	mt clear.
	self interpret: 'var x = println("hello");'.
	self interpret: 'var y = print("world");'.
	self assert: mt contents equals:'hello
world'
]

{ #category : #running }
JbInterpreterTest >> testSingleArityExpression [
	self interpret: 'var x = 3;var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: -3
]

{ #category : #running }
JbInterpreterTest >> testWhileLoop [
	self interpret: 'var x = 0; var y = 0; while (y < 10 ) {y = y + 1; x = x + y;}'.
	self assert: (interpreter environment at: 'x') equals: 55
]
