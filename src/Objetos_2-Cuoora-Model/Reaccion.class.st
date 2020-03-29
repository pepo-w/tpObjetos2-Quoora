Class {
	#name : #Reaccion,
	#superclass : #Object,
	#instVars : [
		'fechaYHora',
		'autor'
	],
	#category : #'Objetos_2-Cuoora-Model-Objetos_2-Cuoora-Model'
}

{ #category : #constructor }
Reaccion class >> conAutor: unUsuario [
	^self new initConAutor: unUsuario
]

{ #category : #boolean }
Reaccion >> esDelAutor: unUsuario [
	^ autor = unUsuario
]

{ #category : #initialization }
Reaccion >> initConAutor: unUsuario [
	autor:=unUsuario.
	fechaYHora := DateAndTime now.
]
