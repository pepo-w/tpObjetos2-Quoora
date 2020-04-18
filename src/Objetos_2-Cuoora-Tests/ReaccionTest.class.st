Class {
	#name : #ReaccionTest,
	#superclass : #TestCase,
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #tests }
ReaccionTest >> testEsDelAutor [ 
	|pepe juan reaccion|
	pepe := Object new.
	juan := Object new.
	reaccion:= Reaccion conAutor: juan.
	self assert: (reaccion esDelAutor: juan).
	self deny: (reaccion esDelAutor: pepe).
]
