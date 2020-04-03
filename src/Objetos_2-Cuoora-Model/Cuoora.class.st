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
	| cuoora |
	cuoora := self new.
	cuoora registrarUsuarioConNombre: 'daniel' password: '12345'.
	cuoora registrarUsuarioConNombre: 'maria' password: '12345'.
	cuoora registrarUsuarioConNombre: 'jose' password: '12345'.
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
"las retorna ordenadas segun fecha de creacion (primero las mas nuevas)."
"el tema de mostrar solo las 5 ultimas capas es mejor resolverlo desde seaside"
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

{ #category : #'private - testing' }
Cuoora >> usuarios [
	^usuarios copy.
]
