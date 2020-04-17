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
CuooraQuestionComponent >> renderAuthorOn: aCanvas [ 
	aCanvas render: 'Realizada por: '.
	aCanvas anchor
		callback: [ self showProfileFrom: self question autor];
		with: [ aCanvas strong: question autor nombre. ].
	aCanvas break.
]

{ #category : #rendering }
CuooraQuestionComponent >> renderContentOn: aCanvas [
	self renderTitleOn: aCanvas.
	aCanvas paragraph: [  
		self renderInfoOn: aCanvas.
		self renderReactionOptionsOn: aCanvas ].
	aCanvas horizontalRule
]

{ #category : #rendering }
CuooraQuestionComponent >> renderInfoOn: aCanvas [
	aCanvas render: 'Tópicos: '.
	aCanvas emphasis: (question topicosAsociados collect: [ :each | each nombre ]) asCommaString.
	aCanvas break.
	self renderAuthorOn: aCanvas.
	aCanvas
		render:
			question cantLikes asString , ' likes | '
				, question cantDislikes asString , ' dislikes'.
	aCanvas break.
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
						[ self showQuestionWithAnswers ];
				with: [ aCanvas emphasis: question titulo ] ].
	aCanvas paragraph: question descripcion.
]

{ #category : #accessing }
CuooraQuestionComponent >> showProfileFrom: anUser [
	| view |
	view := anUser = self session user
		ifTrue: [ CuooraPersonalProfile user: self session user ]
		ifFalse: [ CuooraProfileComponent user: anUser ].
	self session presenter show: view
]

{ #category : #callbacks }
CuooraQuestionComponent >> showQuestionWithAnswers [
	| component |
	component := CuooraQuestionWithAnswersComponent question: self question.
	self session presenter show: component.
]
