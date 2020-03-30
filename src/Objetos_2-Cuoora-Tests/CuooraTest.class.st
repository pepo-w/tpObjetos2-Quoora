Class {
	#name : #CuooraTest,
	#superclass : #TestCase,
	#instVars : [
		'sistema',
		'juan',
		'pepe',
		'topico1',
		'topico2',
		'topico3'
	],
	#category : #'Objetos_2-Cuoora-Tests'
}

{ #category : #'test-initialization' }
CuooraTest >> setUp [
	"para los test no es necesario. pero la idea seria instanciar sistema := Cuoora sistemaUnico"
	sistema := Cuoora new.
	juan := Usuario conNombre: 'juan' password: '1234'.
	pepe := Usuario conNombre: 'pepe' password: '5678'.
	topico1 := Topico conNombre: 'topico1' descripcion: 'desc1'.
	topico2 := Topico conNombre: 'topico2' descripcion: 'desc2'.
	topico3 := Topico conNombre: 'topico3' descripcion: 'desc3'.
]

{ #category : #tests }
CuooraTest >> testAgregarTopicoConNombredescripcion [
	self assert: sistema topicos isEmpty.
	sistema agregarTopicoConNombre: 'topico1' descripcion: 'descripcion 1'. 
	self assert: (sistema topicos size) equals: 1.
]

{ #category : #tests }
CuooraTest >> testObtenerPreguntasConTopico [
	"juan y pepe ya se crean en setUp pero tienen que estar en la coleccion de Cuoora para que funcione el metodo"
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
	|pregunta|
	juan := sistema registrarUsuarioConNombre: 'juan' password: '1234'.
	pepe := sistema registrarUsuarioConNombre: 'pepe' password: '5678'.
	pregunta := pepe crearPreguntaConTitulo: 'pregunta de pepe' descripcion: 'con topico1' topicosAsociados: (OrderedCollection with: topico1).
	juan crearPreguntaConTitulo: 'pregunta de juan' descripcion: 'con topico2' topicosAsociados: (OrderedCollection with: topico2).
	self assert: (sistema preguntasRelevantesParaElUsuario: juan) isEmpty.
	juan agregarTopicoDeInteres: topico2. 
	"ahora la pregunta de juan es relevante porque tiene un topico de interes"
	self assert: (sistema preguntasRelevantesParaElUsuario: juan) size equals: 1.
	juan seguirA: pepe.
	"ahora la pregunta de pepe es relevante porque lo sigue"
	self assert: (sistema preguntasRelevantesParaElUsuario: juan) size equals: 2.
	juan agregarTopicoDeInteres: topico1. 
	"este caso comprueba que la coleccion que retorna el metodo no tenga preguntas repetidas"
	self assert: (sistema preguntasRelevantesParaElUsuario: juan) size equals: 2.
	pepe borrarPregunta: pregunta.
	self assert: (sistema preguntasRelevantesParaElUsuario: juan) size equals: 1.
]

{ #category : #tests }
CuooraTest >> testRegistrarUsuarioConNombrepassword [
	self assert: sistema usuarios isEmpty.
	sistema registrarUsuarioConNombre: 'juan' password: '1234'.
	self assert: (sistema usuarios) size equals: 1.
]
