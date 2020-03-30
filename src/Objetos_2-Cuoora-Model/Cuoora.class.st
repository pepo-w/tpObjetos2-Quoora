Class {
	#name : #Cuoora,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#classInstVars : [
		'sistemaUnico'
	],
	#category : #'Objetos_2-Cuoora-Model'
}

{ #category : #accessing }
Cuoora class >> sistemaUnico [
	"implementacion para singleton. si Cuoora se instancia con el mensaje sistemaUnico en vez de new, solo existira una instancia referenciada por la variable de clase sistemaUnico"
	sistemaUnico ifNil: [ sistemaUnico := self new ].
	^ sistemaUnico.
]

{ #category : #adding }
Cuoora >> agregarTopicoConNombre: unNombre descripcion: unaDescripcion [
	^ (topicos add: (Topico conNombre: unNombre descripcion: unaDescripcion)).
]

{ #category : #initialization }
Cuoora >> initialize [ 
	topicos := OrderedCollection new.
	usuarios := OrderedCollection new.
]

{ #category : #accessing }
Cuoora >> obtenerPreguntasConTopico: unTopico [
	^ usuarios flatCollect: [ :each | each preguntasConTopico: unTopico ].
]

{ #category : #accessing }
Cuoora >> obtenerPreguntasDe: unUsuario [
	^unUsuario preguntas.
]

{ #category : #accesing }
Cuoora >> obtenerRespuestasDe: unUsuario [
	^ unUsuario respuestas.
]

{ #category : #accessing }
Cuoora >> preguntasRelevantesParaElUsuario: unUsuario [
	|relevantes|
	relevantes := unUsuario preguntasDeUsuariosQueSigue.
	unUsuario topicosDeInteres do: [ :each | relevantes addAll: (self obtenerPreguntasConTopico: each) ].
	^relevantes asSet.

]

{ #category : #adding }
Cuoora >> registrarUsuarioConNombre: unNombre password: unPassword [
	^ (usuarios add: (Usuario conNombre: unNombre password: unPassword)).
]

{ #category : #'private - testing' }
Cuoora >> topicos [
	^topicos copy.
]

{ #category : #'private - testing' }
Cuoora >> usuarios [
	^usuarios copy.
]
