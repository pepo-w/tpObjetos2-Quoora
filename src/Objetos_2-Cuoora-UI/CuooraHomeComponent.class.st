Class {
	#name : #CuooraHomeComponent,
	#superclass : #CuooraPrincipalComponent,
	#instVars : [
		'questionViews'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

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

{ #category : #'as yet unclassified' }
CuooraHomeComponent >> obtenerUltimasPreguntas [
	"Retorna una coleccion con las ultimas 5 preguntas"
		^(((self model) preguntasRelevantesParaElUsuario: self session user) takeFirst: 5).
]

{ #category : #'as yet unclassified' }
CuooraHomeComponent >> questionViewForQuestion: aQuestion [
	^ questionViews at: aQuestion ifAbsentPut: [ CuooraQuestionPreview question: aQuestion ].
]

{ #category : #rendering }
CuooraHomeComponent >> renderButtonOn: aCanvas [
	aCanvas anchor
		class: 'right';
		callback: [ self crearPregunta ];
		with: [  
			aCanvas imageButton
			url: (self library urlOf: #plusIconpngPng);
			style: 'vertical-align:middle'.
			aCanvas render: 'crear pregunta' ].
]

{ #category : #rendering }
CuooraHomeComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	self renderButtonOn: aCanvas.
	self renderRelevantQuestionsOn: aCanvas.
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
	(self obtenerUltimasPreguntas isEmpty)
			ifTrue: [ aCanvas emphasis: 'No hay preguntas en tu feed' ]
			ifFalse: [ self obtenerUltimasPreguntas do:[ :pregunta | self renderRelevantQuestion: pregunta on: aCanvas ]].
]
