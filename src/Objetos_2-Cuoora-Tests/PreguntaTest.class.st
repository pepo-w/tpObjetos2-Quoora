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
