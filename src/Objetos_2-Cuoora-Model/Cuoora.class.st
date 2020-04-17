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

{ #category : #'instance creation' }
Cuoora class >> unicaInstancia [
	^ unicaInstancia ifNil: [ unicaInstancia := self new ].
	
]

{ #category : #adding }
Cuoora >> agregarTopicoConNombre: unNombre descripcion: unaDescripcion [
	| topico |
	topico := topicos detect: [ :each | each nombre asLowercase = (unNombre trim) asLowercase ] ifNone: [ nil ].
	topico ifNil: [ topico := (topicos add: (Topico conNombre: (unNombre trim) descripcion: unaDescripcion)) ].
	^ topico.
]

{ #category : #search }
Cuoora >> buscarUsuarioConNombre: unNombre yPassword: aPassword [
	^ usuarios detect: [ :each | each nombre = unNombre and: [ each password = aPassword ] ] ifNone: [ nil ].
]

{ #category : #initialization }
Cuoora >> initialize [ 
	topicos := OrderedCollection new.
	usuarios := OrderedCollection new.
	"carga de datos de prueba"
	CuooraSampler new prebuiltCuoora: self.
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

{ #category : #accessing }
Cuoora >> topicos [
	^ topicos copy 	asSortedCollection: [ :a :b | a nombre asLowercase < b nombre asLowercase ].
]

{ #category : #'private - testing' }
Cuoora >> usuarios [
	^usuarios copy.
]
