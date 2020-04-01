Class {
	#name : #PublicacionTest,
	#superclass : #TestCase,
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #tests }
PublicacionTest >> testDiferenciaLikes [
	| publicacion |
	publicacion := Respuesta conTexto: 'texto' autor: (Object new) pregunta: (Object new).
	self assert: (publicacion diferenciaLikes) equals: 0.
	publicacion registrarLikeDe: (Object new).
	self assert: (publicacion diferenciaLikes) equals: 1.
	publicacion registrarDislikeDe: (Object new).
	self assert: (publicacion diferenciaLikes) equals: 0.
	publicacion registrarDislikeDe: (Object new).
	self assert: (publicacion diferenciaLikes) equals: -1.
	
]

{ #category : #tests }
PublicacionTest >> testRegistrarDislikeDe [
	| publicacion usuario|
	usuario := Usuario conNombre: 'José' password: 'abcde'.
	publicacion := Pregunta conTitulo: 'titulo' descripcion: 'descripcion' topicosAsociados: (OrderedCollection new) autor: usuario.
	self assert: (publicacion cantDislikes) equals: 0.
	publicacion registrarDislikeDe: usuario.
	self assert: (publicacion cantDislikes) equals: 1.
	publicacion registrarDislikeDe: usuario.
	self assert: (publicacion cantDislikes) equals: 1.
	publicacion registrarLikeDe: usuario.
	self assert: (publicacion cantLikes) equals: 1.
	self assert: (publicacion cantDislikes) equals: 0.
]

{ #category : #tests }
PublicacionTest >> testRegistrarLikeDe [
	| publicacion usuario |
	usuario := Usuario conNombre: 'José' password: 'abcde'.
	publicacion := Pregunta conTitulo: 'titulo' descripcion: 'descripcion' topicosAsociados: (OrderedCollection new) autor: usuario.
	self assert: (publicacion cantLikes) equals: 0.
	publicacion registrarLikeDe: usuario.
	self assert: (publicacion cantLikes) equals: 1.
	publicacion registrarLikeDe: usuario.
	self assert: (publicacion cantLikes) equals: 1.
	publicacion registrarDislikeDe: usuario.
	self assert: (publicacion cantDislikes) equals: 1.
	self assert: (publicacion cantLikes) equals: 0.
]
