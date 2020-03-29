Class {
	#name : #Respuesta,
	#superclass : #Publicacion,
	#instVars : [
		'texto',
		'pregunta'
	],
	#category : #'Objetos_2-Cuoora-Model-Objetos_2-Cuoora-Model'
}

{ #category : #constructor }
Respuesta class >> conTexto: unTexto autor: unUsuario pregunta: unaPregunta [
	^ self new initConTexto: unTexto autor: unUsuario pregunta: unaPregunta. 
]

{ #category : #deleting }
Respuesta >> eliminate [ 
	autor borrarRespuesta: self.
]

{ #category : #boolean }
Respuesta >> esDistintoAutorQueLaPregunta [
	^ self autor ~= pregunta autor.
]

{ #category : #initialization }
Respuesta >> initConTexto: unTexto autor: unUsuario pregunta: unaPregunta [
	texto := unTexto.
	pregunta:= unaPregunta.
	self initConAutor: unUsuario.
]

{ #category : #abstract }
Respuesta >> puntaje [
	^ 50 + self diferenciaLikes.
]
