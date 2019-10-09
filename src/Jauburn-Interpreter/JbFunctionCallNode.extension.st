Extension { #name : #JbFunctionCallNode }

{ #category : #'*Jauburn-Interpreter' }
JbFunctionCallNode >> evaluateIn: environment [
	| eval |
	eval := arguments collect: [ :arg | arg evaluateIn: environment ].
	^ (environment at: identifier) call: eval in: environment
]
