Extension { #name : #JbIfNode }

{ #category : #'*Jauburn-Interpreter' }
JbIfNode >> executeIn: anEnvironment [
	(condition evaluateIn: anEnvironment)
		ifTrue:
			[trueStatements
				do: [ :statement | statement executeIn: anEnvironment ]]
]
