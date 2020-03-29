Class {
	#name : #UsuarioTest,
	#superclass : #TestCase,
	#instVars : [
		'usuario1',
		'usuario2',
		'usuario3'
	],
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #'test-initialization' }
UsuarioTest >> setUp [
	usuario1 := Usuario conNombre: 'pepe' password: '1234'.
	usuario2 := Usuario conNombre: 'juan' password: '5678'.
	usuario3 := Usuario conNombre: 'flor' password: 'abcd'.

]
