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
	| cuoora daniel maria jose informatica deportes tecnologia|
	cuoora := self new.
	informatica := cuoora agregarTopicoConNombre: 'informatica' descripcion: 'primer topico'.
	deportes:= cuoora agregarTopicoConNombre: 'deportes' descripcion: 'tercer topico'.
	tecnologia:= cuoora agregarTopicoConNombre: 'tecnologia' descripcion: 'segundo topico'.
	cuoora agregarTopicoConNombre: 'videojuegos' descripcion: 'cuarto topico'.
	cuoora agregarTopicoConNombre: 'Otro' descripcion: 'No pertenezco a ninguna categoria'.
	daniel := cuoora registrarUsuarioConNombre: 'daniel' password: '12345'.
	maria := cuoora registrarUsuarioConNombre: 'maria' password: '12345'.
	jose := cuoora registrarUsuarioConNombre: 'jose' password: '12345'.
	
	daniel seguirA: jose.
	maria seguirA: daniel.
	maria agregarTopicoDeInteres: deportes.
	daniel agregarTopicoDeInteres: informatica.
	jose agregarTopicoDeInteres: tecnologia.
	jose crearPreguntaConTitulo: 'pregunta de jose. relevante para daniel y maria' descripcion: 'soy jose' topicosAsociados: (OrderedCollection with: deportes).
	daniel crearPreguntaConTitulo: 'pregunta de daniel. relevante para maria' descripcion: 'soy daniel' topicosAsociados: (OrderedCollection with: tecnologia). 
	maria crearPreguntaConTitulo: 'pregunta de maria. relevante para daniel por topico informatica' descripcion: 'soy maria' topicosAsociados: (OrderedCollection with: informatica). 
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

{ #category : #'private - testing' }
Cuoora >> usuarios [
	^usuarios copy.
]
