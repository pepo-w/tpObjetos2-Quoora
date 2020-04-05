Class {
	#name : #Cuoora,
	#superclass : #Object,
	#instVars : [
		'usuarios',
		'topicos'
	],
	#classInstVars : [
		'unicaInstancia'
	],
	#category : #'Objetos_2-Cuoora-Model'
}

{ #category : #clearing }
Cuoora class >> clearUnicaInstancia [
	unicaInstancia := nil.
]

{ #category : #'as yet unclassified' }
Cuoora class >> prebuiltInstance [
	| cuoora daniel maria jose topico1|
	cuoora := self new.
	topico1 := cuoora agregarTopicoConNombre: 'topico1' descripcion: 'primer topico'.
	daniel := cuoora registrarUsuarioConNombre: 'daniel' password: '12345'.
	maria := cuoora registrarUsuarioConNombre: 'maria' password: '12345'.
	jose := cuoora registrarUsuarioConNombre: 'jose' password: '12345'.
	daniel seguirA: jose.
	jose crearPreguntaConTitulo: 'pregunta de jose. relevante para daniel' descripcion: 'soy jose' topicosAsociados: (OrderedCollection new).
	maria seguirA: daniel.
	daniel crearPreguntaConTitulo: 'pregunta de daniel. relevante para maria' descripcion: 'soy daniel' topicosAsociados: (OrderedCollection new). 
	daniel agregarTopicoDeInteres: topico1.
	maria crearPreguntaConTitulo: 'pregunta de maria. relevante para daniel por topico1' descripcion: 'soy maria' topicosAsociados: (OrderedCollection with: topico1). 
	^cuoora.
]

{ #category : #'instance creation' }
Cuoora class >> unicaInstancia [
	"implementacion para singleton"
	unicaInstancia ifNil: [ unicaInstancia := self prebuiltInstance ].
	^ unicaInstancia.
	
]

{ #category : #adding }
Cuoora >> agregarTopicoConNombre: unNombre descripcion: unaDescripcion [
"deberia verificar que no se repita el topico??"
	^ (topicos add: (Topico conNombre: unNombre descripcion: unaDescripcion)).
]

{ #category : #search }
Cuoora >> buscarUsuarioConNombre: unNombre yPassword: aPassword [
	^ usuarios detect: [ :each | each nombre = unNombre and: [ each password = aPassword ] ] ifNone: [ nil ].
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
Cuoora >> preguntasRelevantesParaElUsuario: unUsuario [
"retorna las preguntas relevantes ordenadas por fecha y hora, sin ocurrencias"
	|relevantes|
	relevantes := unUsuario preguntasDeUsuariosQueSigue.
	unUsuario topicosDeInteres do: [ :each | relevantes addAll: (self obtenerPreguntasConTopico: each) ].
	^ (relevantes asSet) asSortedCollection: [ :unaPreg :otraPreg | unaPreg fechaYHora > otraPreg fechaYHora ].

]

{ #category : #adding }
Cuoora >> registrarUsuarioConNombre: unNombre password: unPassword [
"deberia verificar que no se repita el nombre de usuario??"
	^ (usuarios add: (Usuario conNombre: unNombre password: unPassword)).
]

{ #category : #'private - testing' }
Cuoora >> topicos [
	^topicos copy.
]

{ #category : #accessing }
Cuoora >> ultimasPreguntasRelevantesParaElUsuario: unUsuario [
	"retorna las primeras 5 preguntas relevantes, ordenadas por fecha y hora, sin ocurrencias"
	|relevantes|
	relevantes := self preguntasRelevantesParaElUsuario: unUsuario.
	(relevantes size > 5)
	ifTrue: [ ^ relevantes first: 5 ].
	^ relevantes.
]

{ #category : #'private - testing' }
Cuoora >> usuarios [
	^usuarios copy.
]
