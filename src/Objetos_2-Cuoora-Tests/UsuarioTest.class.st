Class {
	#name : #UsuarioTest,
	#superclass : #TestCase,
	#instVars : [
		'pepe',
		'juan',
		'flor',
		'topico1',
		'topico2',
		'topico3'
	],
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #'test-initialization' }
UsuarioTest >> setUp [
	pepe := Usuario conNombre: 'pepe' password: '1234'.
	juan := Usuario conNombre: 'juan' password: '5678'.
	flor := Usuario conNombre: 'flor' password: 'abcd'.
	
	topico1:= Topico conNombre: 'topico1' descripcion: 'descripcion1'.
	topico2:= Topico conNombre: 'topico2' descripcion: 'descripcion2'.
	topico3:= Topico conNombre: 'topico3' descripcion: 'descripcion3'. 
	
	

]

{ #category : #tests }
UsuarioTest >> testAgregarTopicoDeInteres [
	self assert: juan topicosDeInteres isEmpty.
	juan agregarTopicoDeInteres: topico1.
	self assert: (juan topicosDeInteres size) equals: 1.
	juan agregarTopicoDeInteres: topico1.
	self assert: (juan topicosDeInteres size) equals: 1.
	juan agregarTopicoDeInteres: topico3.
	self assert: (juan topicosDeInteres size) equals: 2.
]

{ #category : #tests }
UsuarioTest >> testBorrarPregunta [
	| pregunta |
	pregunta:= pepe crearPreguntaConTitulo: 'un titulo' descripcion: 'blablabla' topicosAsociados: (OrderedCollection new).
	flor crearRespuestaConTexto: 'hola te respondo' paraPregunta: pregunta.
	juan crearRespuestaConTexto: 'hola yo tambien te respondo pepe querido' paraPregunta: pregunta.
	flor crearRespuestaConTexto: 'la primer respuesta que dí no me convenció' paraPregunta: pregunta.
	self assert: (pepe preguntas size) equals: 1. 
	self assert: (flor respuestas size) equals: 2.
	self assert: (juan respuestas size) equals: 1.
	
	pepe borrarPregunta: pregunta.
	self assert: pepe preguntas isEmpty.
	self assert: flor respuestas isEmpty.
	self assert: juan respuestas isEmpty.	
	
]

{ #category : #tests }
UsuarioTest >> testBorrarRespuesta [ 
	| pregunta respuesta |
	pregunta := juan crearPreguntaConTitulo: 'titulo' descripcion: 'descripcion' topicosAsociados: (OrderedCollection new).
	respuesta := flor crearRespuestaConTexto: 'Te respondo, juan' paraPregunta: pregunta.
	self assert: (flor respuestas size) equals: 1.
	flor borrarRespuesta: respuesta.
	self assert: flor respuestas isEmpty.
]

{ #category : #tests }
UsuarioTest >> testCalcularPuntaje [ 
	| pregunta respuesta |
	pregunta := flor crearPreguntaConTitulo: 'pregunta de flor' descripcion: 'desc' topicosAsociados: (OrderedCollection new).
	self assert: flor calcularPuntaje equals: 20.
	respuesta := flor crearRespuestaConTexto: 'se responde a si misma, esto no deberia sumar puntos' paraPregunta: pregunta.
	"el siguiente dislike tampoco deberia restar"
	respuesta registrarDislikeDe: pepe.
	self assert: flor calcularPuntaje equals: 20.
	pregunta := pepe crearPreguntaConTitulo: 'pregunta de pepe' descripcion: 'desc' topicosAsociados: (OrderedCollection new).
	respuesta := flor crearRespuestaConTexto: 'flor responde a pepe' paraPregunta: pregunta.
	respuesta registrarLikeDe: pepe.
	respuesta registrarLikeDe: juan.
	self assert: flor calcularPuntaje equals: 72.
	respuesta:= juan crearRespuestaConTexto: 'respuesta polemica de juan' paraPregunta: pregunta.
	self assert: juan calcularPuntaje equals: 50.
	respuesta registrarDislikeDe: flor.
	respuesta registrarDislikeDe: pepe.
	self assert: juan calcularPuntaje equals: 48.
	
]

{ #category : #tests }
UsuarioTest >> testCrearPreguntaConTitulodescripciontopicosAsociados [
	self assert: juan preguntas isEmpty.
	juan crearPreguntaConTitulo: 'titulo' descripcion: 'descripcion' topicosAsociados: (OrderedCollection new).
	self deny: juan preguntas isEmpty.
	
]

{ #category : #tests }
UsuarioTest >> testCrearRespuestaConTextoparaPregunta [
	| pregunta |
	pregunta := pepe crearPreguntaConTitulo: 'titulo' descripcion: 'descripcion' topicosAsociados: (OrderedCollection new).
	juan crearRespuestaConTexto: 'esto es una respuesta' paraPregunta: pregunta.
	self assert: (juan respuestas size) equals: 1.
	self assert: (pregunta respuestas size) equals: 1.
	 
]

{ #category : #tests }
UsuarioTest >> testPreguntasConTopico [
	juan crearPreguntaConTitulo: 'un titulo' descripcion: 'pregunta con topico 1' topicosAsociados: (OrderedCollection with: topico1).
	juan crearPreguntaConTitulo: 'otro titulo' descripcion: 'pregunta con topicos 1 y 2' topicosAsociados: (OrderedCollection with: topico1 with: topico2).
	self assert: ((juan preguntasConTopico: topico1) size) equals: 2.
	self assert: ((juan preguntasConTopico: topico2) size) equals: 1.
	self assert: (juan preguntasConTopico: topico3) isEmpty.
]

{ #category : #tests }
UsuarioTest >> testPreguntasDeUsuariosQueSigue [
	juan crearPreguntaConTitulo: 'una pregunta de juan' descripcion: 'descripcion' topicosAsociados: (OrderedCollection new).
	flor crearPreguntaConTitulo: 'una pregunta de flor' descripcion: 'descripcion' topicosAsociados: (OrderedCollection new).
	flor crearPreguntaConTitulo: 'otra pregunta de flor' descripcion: 'descripcion' topicosAsociados: (OrderedCollection new).
	self assert: (pepe preguntasDeUsuariosQueSigue) isEmpty.
	pepe seguirA: flor.
	self assert: (pepe preguntasDeUsuariosQueSigue size) equals: 2.
	pepe seguirA: juan.
	self assert: (pepe preguntasDeUsuariosQueSigue size) equals: 3.

	
]

{ #category : #tests }
UsuarioTest >> testSeguirA [
	self assert: pepe usuariosQueSigue isEmpty.
	pepe seguirA: flor.
	self deny: pepe usuariosQueSigue isEmpty.
	self assert: flor usuariosQueSigue isEmpty.
	pepe seguirA: flor.
	self assert: (pepe usuariosQueSigue) size equals: 1.
	
]

{ #category : #tests }
UsuarioTest >> testSigueA [ 
	pepe seguirA: flor.
	self assert: (pepe sigueA: flor).
	self deny: (flor sigueA: pepe).
	self deny: (pepe sigueA: juan).
	
]
