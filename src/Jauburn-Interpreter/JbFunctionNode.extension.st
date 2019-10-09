Extension { #name : #JbFunctionNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionNode >> evaluateIn: environment [
	^ JbFunction new
		parameters: self parameters;
		body: self body;
		environment: environment;
		yourself
]
