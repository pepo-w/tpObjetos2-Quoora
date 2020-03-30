Class {
	#name : #Publicacion,
	#superclass : #Object,
	#instVars : [
		'fechaYHora',
		'autor',
		'likes',
		'dislikes'
	],
	#category : #'Objetos_2-Cuoora-Model'
}

{ #category : #private }
Publicacion >> agregarReaccionDe: unUsuario aLaColeccion: unaColeccion [
"comentario"
	unaColeccion detect: [ :reaccion | reaccion esDelAutor: unUsuario ] ifFound: [ ^nil ] ifNone: [ unaColeccion add: (Reaccion conAutor: unUsuario) ].
]

{ #category : #accessing }
Publicacion >> autor [
"comentario"
	^autor
]

{ #category : #calculating }
Publicacion >> diferenciaLikes [
"comentario"
	^ (likes size - dislikes size).
]

{ #category : #private }
Publicacion >> eliminarReaccionDe: unUsuario deLaColeccion: unaColeccion [ 
"comentario"
	| reaccion |
	reaccion:= unaColeccion detect: [ :each | each esDelAutor: unUsuario ] ifNone: [nil].
	reaccion ifNotNil: [ unaColeccion remove: reaccion ].
]

{ #category : #initialization }
Publicacion >> initConAutor: unUsuario [
	autor := unUsuario.
	fechaYHora := DateAndTime now.
]

{ #category : #abstract }
Publicacion >> puntaje [
	^self subclassResponsibility.
]

{ #category : #adding }
Publicacion >> registrarDislikeDe: unUsuario [
"comentario"
	self agregarReaccionDe: unUsuario aLaColeccion: dislikes.
	self eliminarReaccionDe: unUsuario deLaColeccion: likes.
]

{ #category : #adding }
Publicacion >> registrarLikeDe: unUsuario [
"comentario"
	self agregarReaccionDe: unUsuario aLaColeccion: likes.
	self eliminarReaccionDe: unUsuario deLaColeccion: dislikes.
]
