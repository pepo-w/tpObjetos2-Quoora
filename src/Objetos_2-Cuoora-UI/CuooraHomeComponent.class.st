Class {
	#name : #CuooraHomeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'sistema'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #callbacks }
CuooraHomeComponent >> cerrarSesion [
	self session logout.
	self answer.
]

{ #category : #callbacks }
CuooraHomeComponent >> crearPregunta [
	self call: (CuooraQuestionEditorComponent new topicos: (sistema topicos); yourself).
	
]

{ #category : #initialization }
CuooraHomeComponent >> initialize [ 
	super initialize.
	sistema := Cuoora unicaInstancia.
]

{ #category : #rendering }
CuooraHomeComponent >> renderButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self crearPregunta ];
		with: [ aCanvas button: 'Hacer una nueva pregunta' ]
]

{ #category : #rendering }
CuooraHomeComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	self renderRelevantQuestionsOn: aCanvas.
	self renderButtonOn: aCanvas
]

{ #category : #rendering }
CuooraHomeComponent >> renderDataOf: aQuestion on: aCanvas [
	aCanvas render: 'Topicos asociados: '.
	(aQuestion topicosAsociados) 
		do: [ :each | aCanvas render: each nombre,'. ' ].
	aCanvas break.
	aCanvas render: 'Realizada por: '.
	aCanvas strong: aQuestion autor nombre.
	aCanvas render: ' | '.
	aCanvas render: aQuestion respuestas size asString , ' respuestas'.
	aCanvas break.
	aCanvas
		render:
			aQuestion cantLikes asString , ' likes | '
				, aQuestion cantDislikes asString , ' dislikes'.
	aCanvas break
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
CuooraHomeComponent >> renderReactionOptionsOf: aQuestion on: aCanvas [
	aCanvas anchor
		callback: [ aQuestion registrarLikeDe: self session user ];
		with: 'Like'.
	aCanvas space.
	aCanvas render: ' | '.
	aCanvas space.
	aCanvas anchor
		callback: [ aQuestion registrarDislikeDe: self session user ];
		with: 'Dislike'
]

{ #category : #rendering }
CuooraHomeComponent >> renderRelevantQuestion: aQuestion on: aCanvas [
	self renderTitleOf: aQuestion on: aCanvas.
	aCanvas
		paragraph: [ self renderDataOf: aQuestion on: aCanvas.
			self renderReactionOptionsOf: aQuestion on: aCanvas ].
	aCanvas horizontalRule
]

{ #category : #rendering }
CuooraHomeComponent >> renderRelevantQuestionsOn: aCanvas [
	| ultimasPreguntas |
	
	aCanvas heading
		level: 2;
		with: 'Ultimas Preguntas'.
	
	ultimasPreguntas := (sistema preguntasRelevantesParaElUsuario: self session user) takeFirst: 5.
	ultimasPreguntas do: [ :pregunta | self renderRelevantQuestion: pregunta on: aCanvas ].
]

{ #category : #rendering }
CuooraHomeComponent >> renderTitleOf: aQuestion on: aCanvas [
	aCanvas heading
		level: 3;
		with: [aCanvas anchor 	
					callback: ['Esto mostrara de alguna forma las respuestas'];
					with: [ aCanvas emphasis: aQuestion titulo ]]
]

{ #category : #hooks }
CuooraHomeComponent >> style [
	^'.right {
    float: right;
	}
	a {
	 text-decoration: none;
	 color: rgb(0,15,70);
	}
	body {
		font-family: Lucida Sans Unicode, Lucida Grande, sans-serif;
	}'
]
