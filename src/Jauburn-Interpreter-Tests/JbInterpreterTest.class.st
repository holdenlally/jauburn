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
JbInterpreterTest >> testPrimitiveFunctionCalls [

	self interpret: 'var x = concat("hello", "world");'.
	self assert: (interpreter environment at: 'x') equals: 'hello world'.
]

{ #category : #running }
JbInterpreterTest >> testSingleArityExpression [
	self interpret: 'var x = 3;var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: -3
]
