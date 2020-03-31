Class {
	#name : #PreguntaTest,
	#superclass : #TestCase,
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #tests }
PreguntaTest >> testAgregarRepuesta [
	| usuario pregunta |
	usuario := Usuario conNombre: 'Jose' password: 'acbd'.
	pregunta := usuario crearPreguntaConTitulo: 'un titulo' descripcion: 'una descripcion' topicosAsociados: (OrderedCollection new).
	self assert: pregunta respuestas isEmpty.
	pregunta agregarRespuesta: (Respuesta conTexto: 'un texto' autor: usuario pregunta: pregunta).
	self deny: pregunta respuestas isEmpty.
]

{ #category : #tests }
PreguntaTest >> testIncluyeTopico [
	| topicos topico1 topico2 topico3 pregunta|
	topico1:= Topico conNombre: 'topico1' descripcion: 'descripcion1'. 
	topico2:= Topico conNombre: 'topico2' descripcion: 'descripcion2'. 
	topico3:= Topico conNombre: 'topico3' descripcion: 'descripcion3'. 
	 
	topicos:= OrderedCollection with: topico1 with: topico2.
	pregunta := Pregunta conTitulo: 'titulo' descripcion: 'descripcion' topicosAsociados: topicos autor: (Usuario conNombre: 'Daniel' password: 'abcd').
	self assert: (pregunta incluyeTopico: topico1).
	self assert: (pregunta incluyeTopico: topico2).
	self deny: (pregunta incluyeTopico: topico3).
]

{ #category : #tests }
PreguntaTest >> testPuntaje [
"el test de puntaje para la respuesta seria basicamente lo mismo, no se si son necesarios ambos"
	| usuario pregunta |
	usuario := Usuario conNombre: 'Jose' password: 'acbd'.
	pregunta := usuario crearPreguntaConTitulo: 'un titulo' descripcion: 'una descripcion' topicosAsociados: (OrderedCollection new).
	self assert: (pregunta puntaje) equals: 20.
	pregunta registrarLikeDe: usuario.
	self assert: (pregunta puntaje) equals: 21.
	pregunta registrarDislikeDe: usuario.
	self assert: (pregunta puntaje) equals: 19.
	
]

{ #category : #tests }
PreguntaTest >> testRespuestas [
	| pregunta respuesta1 respuesta2 |
	pregunta := Pregunta conTitulo: 'preg' descripcion: 'desc' topicosAsociados: (OrderedCollection new) autor: (Object new).
	respuesta1 := Respuesta conTexto: 'rta mala' autor: (Object new) pregunta: pregunta.
	respuesta2 := Respuesta conTexto: 'rta buena' autor: (Object new) pregunta: pregunta.
	pregunta agregarRespuesta: respuesta1.
	pregunta agregarRespuesta: respuesta2.
	respuesta1 registrarDislikeDe: (Object new).
	self assert: (pregunta respuestas) first equals: respuesta2. 
	respuesta1 registrarLikeDe: (Object new).
	respuesta1 registrarLikeDe: (Object new).
	self assert: (pregunta respuestas) first equals: respuesta1. 
]
