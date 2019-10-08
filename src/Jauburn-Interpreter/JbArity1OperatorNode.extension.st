Extension { #name : #JbArity1OperatorNode }

{ #category : #'*Jauburn-Interpreter' }
JbArity1OperatorNode >> evaluateIn: environment [

	| operandValue |
	operandValue := self operand evaluateIn: environment.
	self operator = $-
		ifTrue: [ ^operandValue negative ].
]
