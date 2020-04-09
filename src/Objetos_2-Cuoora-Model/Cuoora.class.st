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
	| cuoora pedro diego juan oo1 testDeUnidad smalltalk question1 question2 |
	cuoora := self new.
	"usuarios"
	pedro := cuoora registrarUsuarioConNombre: 'pedro@cuoora.com' password: 'pedro@cuoora.com'.
	diego := cuoora registrarUsuarioConNombre: 'diego@cuoora.com' password: 'diego@cuoora.com'.
	juan := cuoora registrarUsuarioConNombre: 'juan@cuoora.com' password: 'juan@cuoora.com'.
	juan seguirA: diego.
	pedro seguirA: juan.

	"topicos"
	oo1 := cuoora agregarTopicoConNombre: 'oo1' descripcion: 'orientacion a objetos 1'.
	testDeUnidad := cuoora agregarTopicoConNombre: 'Test de unidad' descripcion: 'testing con SUnit'.
	smalltalk := cuoora agregarTopicoConNombre: 'Smalltalk' descripcion: 'lenguaje de programacion'.
	
	"preguntas y respuestas"
	question1 := pedro crearPreguntaConTitulo: '¿Para qué sirve el método SetUp?' descripcion: '' topicosAsociados: (OrderedCollection with: oo1 with: testDeUnidad).
	diego crearRespuestaConTexto: 'Sirve para instanciar los objetos que son evaluados por el test en un único método y que se ejecute siempre antes de cada test.' paraPregunta: question1.
	question2 := diego crearPreguntaConTitulo: '¿Qué significa #messageNotUnderstood?' descripcion: '' topicosAsociados: (OrderedCollection with: oo1 with: smalltalk).
	pedro crearRespuestaConTexto: 'Significa que el objeto que recibió el mensaje no encontró ningún método para ejecutar en respuesta.' paraPregunta: question2.
	
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
	| topico |
	topico := topicos detect: [ :each | each nombre asLowercase = unNombre asLowercase ] ifNone: [ nil ].
	topico ifNil: [ topico := (topicos add: (Topico conNombre: unNombre descripcion: unaDescripcion)) ].
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
