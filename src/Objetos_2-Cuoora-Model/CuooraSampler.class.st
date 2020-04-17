Class {
	#name : #CuooraSampler,
	#superclass : #Object,
	#category : #'Objetos_2-Cuoora-Model'
}

{ #category : #'as yet unclassified' }
CuooraSampler >> prebuiltCuoora: cuoora [ 
	| pedro diego juan oo1 testDeUnidad smalltalk question1 question2 |

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
