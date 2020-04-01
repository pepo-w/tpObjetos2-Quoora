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
	unaColeccion detect: [ :reaccion | reaccion esDelAutor: unUsuario ] ifFound: [ ^nil ] ifNone: [ unaColeccion add: (Reaccion conAutor: unUsuario) ].
]

{ #category : #accessing }
Publicacion >> autor [
	^autor
]

{ #category : #private }
Publicacion >> cantDislikes [
	^dislikes size.
]

{ #category : #private }
Publicacion >> cantLikes [
	^likes size.
]

{ #category : #calculating }
Publicacion >> diferenciaLikes [
	^ (self cantLikes) - (self cantDislikes).
]

{ #category : #private }
Publicacion >> eliminarReaccionDe: unUsuario deLaColeccion: unaColeccion [ 
	| reaccion |
	reaccion:= unaColeccion detect: [ :each | each esDelAutor: unUsuario ] ifNone: [nil].
	reaccion ifNotNil: [ unaColeccion remove: reaccion ].
]

{ #category : #initialization }
Publicacion >> initConAutor: unUsuario [
	autor := unUsuario.
	fechaYHora := DateAndTime now.
	likes:= OrderedCollection new.
	dislikes:= OrderedCollection new.
]

{ #category : #abstract }
Publicacion >> puntaje [
	^self subclassResponsibility.
]

{ #category : #adding }
Publicacion >> registrarDislikeDe: unUsuario [
	self agregarReaccionDe: unUsuario aLaColeccion: dislikes.
	self eliminarReaccionDe: unUsuario deLaColeccion: likes.
]

{ #category : #adding }
Publicacion >> registrarLikeDe: unUsuario [
	self agregarReaccionDe: unUsuario aLaColeccion: likes.
	self eliminarReaccionDe: unUsuario deLaColeccion: dislikes.
]
