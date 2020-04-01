Class {
	#name : #RespuestaTest,
	#superclass : #TestCase,
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #tests }
RespuestaTest >> testPuntaje [
	| respuesta |
	respuesta := Respuesta conTexto: 'un texto' autor: (Object new)  pregunta: (Object new).
	self assert: (respuesta puntaje) equals: 50. 
	respuesta registrarLikeDe: (Object new).
	self assert: (respuesta puntaje) equals: 51.
	respuesta registrarLikeDe: (Object new).
	self assert: (respuesta puntaje) equals: 52.
	respuesta registrarDislikeDe: (Object new).
	self assert: (respuesta puntaje) equals: 51.
	 
]
