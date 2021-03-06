Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'password',
		'fechaCreacion',
		'usuariosQueSigue',
		'topicosDeInteres',
		'preguntas',
		'respuestas'
	],
	#category : #'Objetos_2-Cuoora-Model'
}

{ #category : #constructor }
Usuario class >> conNombre: unNombre password: unPassword [
	^self new initConNombre:unNombre password: unPassword.
]

{ #category : #adding }
Usuario >> agregarTopicoDeInteres: unTopico [
	topicosDeInteres addIfNotPresent: unTopico.
]

{ #category : #deleting }
Usuario >> borrarPregunta: unaPregunta [ 
	unaPregunta borrarRespuestas.
	preguntas remove: unaPregunta.
]

{ #category : #deleting }
Usuario >> borrarRespuesta: unaRespuesta [
"se elimina de su coleccion de respuestas, pero sigue estando en la coleccion de respuestas de la pregunta"
	respuestas remove: unaRespuesta.
]

{ #category : #calculating }
Usuario >> calcularPuntaje [
	"Se tienen en cuenta todas las preguntas del usuario y todas las respuestas validas, osea las que responden a una pregunta que no hizo él mismo"
	| puntajePreguntas respuestasValidas |
	puntajePreguntas := preguntas sumNumbers: [ :each | each puntaje ].
	respuestasValidas := respuestas select: [ :each | each esDistintoAutorQueLaPregunta ].
	^ (puntajePreguntas + (respuestasValidas sumNumbers: [ :each | each puntaje ])).
]

{ #category : #adding }
Usuario >> crearPreguntaConTitulo: unTitulo descripcion: unaDescripcion topicosAsociados: unaColeccionDeTopicos [ 
	^ (preguntas add: (Pregunta conTitulo: unTitulo descripcion: unaDescripcion topicosAsociados: unaColeccionDeTopicos autor: self)).
]

{ #category : #adding }
Usuario >> crearRespuestaConTexto: unTexto paraPregunta: unaPregunta [
	|nuevaRta|
	nuevaRta := Respuesta conTexto: unTexto autor: self pregunta: unaPregunta.
	respuestas add: nuevaRta.
	unaPregunta agregarRespuesta: nuevaRta.
	^nuevaRta.
]

{ #category : #initialization }
Usuario >> initConNombre: unNombre password: unPassword [
	nombre:=unNombre.
	password := unPassword.
	fechaCreacion := DateAndTime now.
	usuariosQueSigue := OrderedCollection new.
	preguntas:= OrderedCollection new.
	respuestas := OrderedCollection new.
	topicosDeInteres := OrderedCollection new.
]

{ #category : #accessing }
Usuario >> nombre [ 
	^ nombre.
]

{ #category : #accessing }
Usuario >> password [
	^password
]

{ #category : #accessing }
Usuario >> preguntas [ 
	^ preguntas copy.
]

{ #category : #accessing }
Usuario >> preguntasConTopico: unTopico [ 
	^ preguntas select: [ :each | each incluyeTopico: unTopico ].
]

{ #category : #accessing }
Usuario >> preguntasDeUsuariosQueSigue [
	^ usuariosQueSigue flatCollect: [ :each | each preguntas ].
]

{ #category : #accessing }
Usuario >> respuestas [
	^ respuestas copy.
]

{ #category : #adding }
Usuario >> seguirA: otroUsuario [
	usuariosQueSigue addIfNotPresent: otroUsuario.
]

{ #category : #boolean }
Usuario >> sigueA: unUsuario [ 
	^ (usuariosQueSigue includes: unUsuario ).
]

{ #category : #accessing }
Usuario >> topicosDeInteres [
	^ topicosDeInteres copy.
]

{ #category : #'private - testing' }
Usuario >> usuariosQueSigue [
	^usuariosQueSigue.
]
