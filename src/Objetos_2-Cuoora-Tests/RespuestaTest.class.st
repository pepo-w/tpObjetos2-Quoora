Class {
	#name : #RespuestaTest,
	#superclass : #TestCase,
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #tests }
RespuestaTest >> testEsDistintoAutorQueLaPregunta [ 
	| pepe juan pregunta respuesta|
	pepe:= Usuario conNombre: 'pepe' password: '12345'.
	juan:= Usuario conNombre: 'juan' password: '12345'.
	
	pregunta:= pepe crearPreguntaConTitulo: 'Una pregunta' descripcion: 'blablabla'  topicosAsociados: Object new.
	respuesta := juan crearRespuestaConTexto: 'Una respuesta' paraPregunta: pregunta.
	self assert: (respuesta esDistintoAutorQueLaPregunta).
	
	pregunta := juan crearPreguntaConTitulo: 'una pregunta' descripcion: 'blablabla' topicosAsociados: Object new.
	respuesta := juan crearRespuestaConTexto: 'Me respondo solo' paraPregunta: pregunta.
	self deny: (respuesta esDistintoAutorQueLaPregunta).  
	
]

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
