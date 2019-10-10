"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> euclidGCD [
"self run: #euclidGCD"
"Well...I tried. And I think I have the right idea here, but there is clearly something I'm missing about making recursive calls in Jauburn. Var b would usually be where user input would be requested, but similar to newtonSquareRoot, my input does not implement the asNumber method for user inputs."
^'var a = gcd(x, y) {
	if (x == 0) { 
		return y;
	} 
	else { 
		var z = mod(x,y);
		return gcd(y, z);
		}
	}
var b = a(45, 10);
var c = print(b);'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> newtonSquareRoot [
	"self run: #newtonSquareRoot"
	"Code that I wanted to implement below. Var a in either version should ask for user input, but input was not 	implemented to send the asNumber message. Var a can be changed to whatever the user input would be."
^'var a = 5;
var x = a / 2;
var y = 1;
var z = 0;
var p = println(x);
var c = 6;
while (c > 0) {
	y = x * x - a;
	z = 2 * x;
	x = x - y / z;
	p = println(x);
	c = c - 1;
}
'
"
Code that I was trying to implement in which you subtracted the old x from the new x to determine if there was a significant difference. It caused several crashes and infinite loops so I had to go with the simpler approach above, but I still can't figure out why this wouldn't work.
^'var a = 5;
var x = a / 2;
var y = 1;
var z = 0;
var p = println(x);
var c = a / 2;
while (c > 1/1000) {
y = x * x - a;
z = 2 * x;
x = x - y / z;
p = println(x);
c = c - x;
c = abs(c);
}
'"
]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 10;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
var z = println(x);
var a = println(y);
'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> printTest [
"self run: #euclidGCD"
^'var a = print("This is a test");'


]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]
