Class {
	#name : #RespuestaTest,
	#superclass : #TestCase,
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #tests }
RespuestaTest >> testEsDistintoAutorQueLaPregunta [ 
	| pepe juan pregunta respuesta|
	pepe:= Object new.
	juan:= Object new.
	pregunta := Pregunta conTitulo: 'pregunta de pepe' descripcion: '' topicosAsociados: (OrderedCollection new) autor: pepe. 
	respuesta := Respuesta conTexto: 'respuesta de juan' autor: juan pregunta: pregunta. 
	self assert: (respuesta esDistintoAutorQueLaPregunta).
	pregunta := Pregunta conTitulo: 'pregunta de juan' descripcion: '' topicosAsociados: (OrderedCollection new) autor: juan.
	respuesta := Respuesta conTexto: 'respuesta de juan' autor: juan pregunta: pregunta. 
	self deny: (respuesta esDistintoAutorQueLaPregunta).  
	
]

{ #category : #tests }
RespuestaTest >> testPuntaje [
	|usuario respuesta|
	respuesta := Respuesta conTexto: 'un texto' autor: (Object new) pregunta: (Object new).
	usuario := Object new.
	self assert: (respuesta puntaje) equals: 50. 
	respuesta registrarLikeDe: usuario.
	self assert: (respuesta puntaje) equals: 51.
	respuesta registrarDislikeDe: usuario.
	self assert: (respuesta puntaje) equals: 49.
	
]
