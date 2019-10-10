Extension { #name : #JbIfElseNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfElseNode >> executeIn: anEnvironment [
	(condition evaluateIn: anEnvironment)
	ifTrue:
			[trueStatements
				do: [:statement | statement executeIn: anEnvironment]]
	ifFalse:
			[falseStatements
				do: [:statement | statement executeIn: anEnvironment]].
]
