Class {
	#name : #CuooraQuestionComponent,
	#superclass : #WAComponent,
	#instVars : [
		'question'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #services }
CuooraQuestionComponent class >> question: aQuestion [
	| instance |
	instance := self new.
	instance question: aQuestion.
	^instance.
]

{ #category : #accessing }
CuooraQuestionComponent >> question [
	^ question
]

{ #category : #accessing }
CuooraQuestionComponent >> question: anObject [
	question := anObject
]

{ #category : #rendering }
CuooraQuestionComponent >> renderBodyOn: aCanvas [
	aCanvas render: 'Topicos asociados: '.
	question topicosAsociados
		do: [ :each | aCanvas render: each nombre , '. ' ].
	aCanvas break.
	aCanvas render: 'Realizada por: '.
	aCanvas strong: question autor nombre.
	aCanvas render: ' | '.
	aCanvas render: question respuestas size asString , ' respuestas'.
	aCanvas break.
	aCanvas
		render:
			question cantLikes asString , ' likes | '
				, question cantDislikes asString , ' dislikes'.
	aCanvas break
]

{ #category : #rendering }
CuooraQuestionComponent >> renderContentOn: aCanvas [
	self renderTitleOn: aCanvas.
	self renderBodyOn: aCanvas.
	self renderReactionOptionsOn:aCanvas.
	aCanvas horizontalRule
]

{ #category : #rendering }
CuooraQuestionComponent >> renderReactionOptionsOn: aCanvas [
	aCanvas anchor
		callback: [ question registrarLikeDe: self session user ];
		with: 'Like'.
	aCanvas space.
	aCanvas render: ' | '.
	aCanvas space.
	aCanvas anchor
		callback: [ question registrarDislikeDe: self session user ];
		with: 'Dislike'
]

{ #category : #rendering }
CuooraQuestionComponent >> renderTitleOn: aCanvas [
	aCanvas heading
		level: 3;
		with: [ aCanvas anchor
				callback:
						[ 'Esto generara un nuevo componente para mostrar la pregunta con sus respuestas' ];
				with: [ aCanvas emphasis: question titulo ] ]
]
