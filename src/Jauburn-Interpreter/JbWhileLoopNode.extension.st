Extension { #name : #JbWhileLoopNode }

{ #category : #'*Jauburn-Interpreter' }
JbWhileLoopNode >> executeIn: anEnvironment [
	[condition evaluateIn: anEnvironment]
		whileTrue:
			[trueStatements
				do: [ :statement | statement executeIn: anEnvironment ]]
]
