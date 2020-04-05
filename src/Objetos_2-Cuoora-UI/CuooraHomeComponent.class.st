Class {
	#name : #CuooraHomeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'sistema'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #'as yet unclassified' }
CuooraHomeComponent >> cerrarSesion [
	self session logout.
	self answer.
]

{ #category : #initialization }
CuooraHomeComponent >> initialize [ 
	super initialize.
	sistema := Cuoora unicaInstancia.
]

{ #category : #rendering }
CuooraHomeComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	aCanvas heading
		level: 2;
		with: 'Ultimas Preguntas'.
	(sistema ultimasPreguntasRelevantesParaElUsuario: self session user) do: [ :pregunta | self renderRelevantQuestion: pregunta on: aCanvas ].
	aCanvas button
				callback: [  ];
				with: 'Hacer una pregunta'.
]

{ #category : #rendering }
CuooraHomeComponent >> renderHeaderOn: aCanvas [
	aCanvas div 
		class: 'right';
		with: [aCanvas paragraph: [ aCanvas strong: self session user nombre, ' '.  
								aCanvas anchor callback: [self cerrarSesion];
								               with: 'logout']].	
	aCanvas heading: 'CuOOra'.
	aCanvas horizontalRule
]

{ #category : #rendering }
CuooraHomeComponent >> renderRelevantQuestion: aQuestion on: aCanvas [
	aCanvas heading
		level: 3;
		with: aQuestion titulo.
	aCanvas
		paragraph: [ aCanvas render: 'Realizada por: '. 
			aCanvas strong: aQuestion autor nombre. aCanvas render: ' | '.
			aCanvas render: (aQuestion respuestas size) asString,' respuestas'.
			aCanvas break.
			aCanvas render: (aQuestion cantLikes) asString,' likes | ',(aQuestion cantDislikes) asString, ' dislikes'.
			aCanvas break.
			aCanvas anchor 
						callback: [aQuestion registrarLikeDe: self session user];
						with: 'like '.
			aCanvas space.
			aCanvas anchor 
						callback: [ aQuestion registrarDislikeDe: self session user ];
						with: 'dislike'].
	aCanvas horizontalRule
]

{ #category : #hooks }
CuooraHomeComponent >> style [
	^'.right {
    float: right;
	}'
]
