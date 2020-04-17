Class {
	#name : #ReaccionTest,
	#superclass : #TestCase,
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #tests }
ReaccionTest >> testEsDelAutor [ 
	| pepe juan reaccion|
	
	pepe := Usuario conNombre: 'pepe' password: '12345'.
	juan := Usuario conNombre: 'juan' password: '12345'.
	
	reaccion:= Reaccion conAutor: juan.
	
	self assert: (reaccion esDelAutor: juan).
	self deny: (reaccion esDelAutor: pepe).
]
