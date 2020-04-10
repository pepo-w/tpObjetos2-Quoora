Class {
	#name : #CuooraHomeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'questionViews'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #callbacks }
CuooraHomeComponent >> cerrarSesion [
	self session logout.
	self answer.
]

{ #category : #hooks }
CuooraHomeComponent >> children [ 	
	^(self obtenerUltimasPreguntas) collect: [ :each | self questionViewForQuestion: each ].
]

{ #category : #callbacks }
CuooraHomeComponent >> crearPregunta [
	self call: (CuooraQuestionEditorComponent new).
	
]

{ #category : #initialization }
CuooraHomeComponent >> initialize [ 
	super initialize.
	self obtenerUltimasPreguntas.
	questionViews := Dictionary new.
]

{ #category : #accessing }
CuooraHomeComponent >> model [ 
	^Cuoora unicaInstancia.
]

{ #category : #'as yet unclassified' }
CuooraHomeComponent >> obtenerUltimasPreguntas [
	"Retorna una coleccion con las ultimas 5 preguntas"
		^(((self model) preguntasRelevantesParaElUsuario: self session user) takeFirst: 5).
]

{ #category : #'as yet unclassified' }
CuooraHomeComponent >> questionViewForQuestion: aQuestion [
	^ questionViews at: aQuestion ifAbsentPut: [ CuooraQuestionComponent question: aQuestion ].
]

{ #category : #rendering }
CuooraHomeComponent >> renderButtonOn: aCanvas [
	aCanvas anchor
		class: 'right';
		callback: [ self crearPregunta ];
		with: [ aCanvas button: 'Hacer una nueva pregunta' ]
]

{ #category : #rendering }
CuooraHomeComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	self renderButtonOn: aCanvas.
	self renderRelevantQuestionsOn: aCanvas.
	aCanvas anchor 
		callback: [ self showAddTopics ];
		with: [ aCanvas button with: 'Agregar tópicos de interes' ].
]

{ #category : #rendering }
CuooraHomeComponent >> renderHeaderOn: aCanvas [
	aCanvas div
		class: 'right';
		with: [ aCanvas
				paragraph: [ aCanvas strong: self session user nombre , ' '.
					aCanvas anchor
						callback: [ self cerrarSesion ];
						with: [ aCanvas button: 'logout' ] ] ].
	aCanvas heading: 'CuOOra'.
	aCanvas horizontalRule
]

{ #category : #rendering }
CuooraHomeComponent >> renderRelevantQuestion: aQuestion on: aCanvas [
	aCanvas render: (self questionViewForQuestion: aQuestion).
]

{ #category : #rendering }
CuooraHomeComponent >> renderRelevantQuestionsOn: aCanvas [
	aCanvas heading
		level: 2;
		with: 'Ultimas Preguntas'.	
	(self obtenerUltimasPreguntas) do: [ :pregunta | self renderRelevantQuestion: pregunta on: aCanvas ].
]

{ #category : #'as yet unclassified' }
CuooraHomeComponent >> showAddTopics [ 
	self call: (CuooraAddInterestTopicComponent new)
]

{ #category : #updating }
CuooraHomeComponent >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: (CuooraFileLibrary urlOf: #mainCss).
]
