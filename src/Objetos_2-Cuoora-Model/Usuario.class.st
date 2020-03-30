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
"capas habria que chequear que no lo agrege repetido con addIfNotPresent comentario"
	topicosDeInteres add: unTopico.
]

{ #category : #deleting }
Usuario >> borrarPregunta: unaPregunta [ 
	"todavia me quedan algunas dudas c son el tema de borrado, habría que chequear bien despues el mecanismo"
	unaPregunta borrarRespuestas.
	preguntas remove: unaPregunta.
]

{ #category : #deleting }
Usuario >> borrarRespuesta: unaRespuesta [
"comentario"
	respuestas remove: unaRespuesta.
]

{ #category : #calculating }
Usuario >> calcularPuntaje [
	"Se tienen encuenta todas las preguntas del usuario y todas las respuestas validas, osea las que responden a una pregunta que no hiz so el mismo"
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
Usuario >> preguntas [ 
	^ preguntas copy.
	"comentario"
]

{ #category : #accessing }
Usuario >> preguntasConTopico: unTopico [ 
"comentario"
	^ preguntas select: [ :each | each incluyeTopico: unTopico  ].
]

{ #category : #accessing }
Usuario >> preguntasDeUsuariosQueSigue [
"comentario"
	^ usuariosQueSigue flatCollect: [ :each | each preguntas ].
]

{ #category : #accessing }
Usuario >> respuestas [
"comentario"
	^ respuestas copy.
]

{ #category : #adding }
Usuario >> seguirA: otroUsuario [
"si ya seguia a ese sfsafusuario, no lo vuelve a agregar"
	usuariosQueSigue addIfNotPresent: otroUsuario.
]

{ #category : #accessing }
Usuario >> topicosDeInteres [
"comentario"
	^ topicosDeInteres copy.
]
