Class {
	#name : #CuooraTest,
	#superclass : #TestCase,
	#instVars : [
		'sistema',
		'topico1',
		'topico2',
		'topico3'
	],
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #'test-initialization' }
CuooraTest >> setUp [
	sistema := Cuoora new.
	topico1 := Topico conNombre: 'topico1' descripcion: 'descripcion1'.
	topico2 := Topico conNombre: 'topico2' descripcion: 'descripcion2'.
	topico3 := Topico conNombre: 'topico3' descripcion: 'descripcion3'.
]

{ #category : #tests }
CuooraTest >> testAgregarTopicoConNombredescripcion [
	self assert: sistema topicos isEmpty.
	sistema agregarTopicoConNombre: 'topico1' descripcion: 'descripcion 1'. 
	self assert: (sistema topicos size) equals: 1.
	sistema agregarTopicoConNombre: 'TopIcO1' descripcion: 'blablabla'.
	self assert: (sistema topicos size) equals: 1.
	sistema agregarTopicoConNombre: ' topico1 ' descripcion: 'blablabla'.
	self assert: (sistema topicos size) equals: 1.
	sistema agregarTopicoConNombre: 'topico2' descripcion:'blablabla'.
	self assert: (sistema topicos size) equals: 2. 
]

{ #category : #tests }
CuooraTest >> testBuscarUsuarioConNombreYPassword [
	|user|
	sistema registrarUsuarioConNombre: 'Dave Chappelle' password: '12345'.
	user := sistema buscarUsuarioConNombre: 'Dave Chappelle' yPassword: '12345'.
	self assert: user isNotNil.
	user := sistema buscarUsuarioConNombre: 'Dave Chappelle' yPassword: '123456'.
	self assert: user isNil.
	user := sistema buscarUsuarioConNombre: 'dave chappelle' yPassword: '12345'.
	self assert: user isNil.
	user := sistema buscarUsuarioConNombre: ' dave chappelle ' yPassword: '12345'.
	self assert: user isNil.
]

{ #category : #tests }
CuooraTest >> testObtenerPreguntasConTopico [
   |juan pepe|
	juan := sistema registrarUsuarioConNombre: 'juan' password: '1234'.
	pepe := sistema registrarUsuarioConNombre: 'pepe' password: '5678'.
	juan crearPreguntaConTitulo: 'pregunta 1' descripcion: 'con topico1' topicosAsociados: (OrderedCollection with: topico1).
	pepe crearPreguntaConTitulo: 'pregunta 2' descripcion: 'con topico1 y topico2' topicosAsociados: (OrderedCollection with: topico1 with: topico2).
	self assert: (sistema obtenerPreguntasConTopico: topico1) size equals: 2.
	self assert: (sistema obtenerPreguntasConTopico: topico2) size equals: 1. 
	self assert: (sistema obtenerPreguntasConTopico: topico3) isEmpty.
]

{ #category : #tests }
CuooraTest >> testPreguntasRelevantesParaElUsuario [ 
	|juan pepe|
	juan := sistema registrarUsuarioConNombre: 'juan' password: '1234'.
	pepe := sistema registrarUsuarioConNombre: 'pepe' password: '5678'.
	pepe crearPreguntaConTitulo: 'pregunta de pepe' descripcion: 'con topico1' topicosAsociados: (OrderedCollection with: topico1).
	juan crearPreguntaConTitulo: 'pregunta de juan' descripcion: 'con topico2' topicosAsociados: (OrderedCollection with: topico2).
	self assert: (sistema preguntasRelevantesParaElUsuario: juan) isEmpty.
	juan agregarTopicoDeInteres: topico2. 
	"ahora la pregunta de juan es relevante para él mismo porque tiene un tópico de interes"
	self assert: (sistema preguntasRelevantesParaElUsuario: juan) size equals: 1.
	juan seguirA: pepe.
	"ahora la pregunta de pepe es relevante porque lo sigue"
	self assert: (sistema preguntasRelevantesParaElUsuario: juan) size equals: 2.
	juan agregarTopicoDeInteres: topico1. 
	"este caso comprueba que la coleccion que retorna el metodo no tenga preguntas repetidas"
	self assert: (sistema preguntasRelevantesParaElUsuario: juan) size equals: 2.
	
]

{ #category : #tests }
CuooraTest >> testRegistrarUsuarioConNombrepassword [
	self assert: sistema usuarios isEmpty.
	sistema registrarUsuarioConNombre: 'juan' password: '1234'.
	self assert: (sistema usuarios) size equals: 1.
	sistema registrarUsuarioConNombre: 'Gabriel Iglesias' password: 'Fluffy'.
	self assert: (sistema usuarios) size equals: 2.
]
