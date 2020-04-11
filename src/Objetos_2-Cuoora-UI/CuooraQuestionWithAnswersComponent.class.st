"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

Represento un componente que muestra una pregunta en específico y sus respectivas respuestas.

para crear instancias se debe mander el mensaje de clase:
	CuooraQuestionWithAnswersComponent question: aQuestion.


Internal Representation and Key Implementation Points.

    Instance Variables
	question:		<aPregunta>
	questionView:		<aCuooraQuestionComponent>
	responsesView:		<aCuooraResponsesComponent>


"
Class {
	#name : #CuooraQuestionWithAnswersComponent,
	#superclass : #CuooraPrincipalComponent,
	#instVars : [
		'question',
		'questionView',
		'responsesView'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #services }
CuooraQuestionWithAnswersComponent class >> question: aQuestion [
	| instance |
	instance := self new.
	instance question: aQuestion.
	instance questionView: (CuooraQuestionComponent question: aQuestion).
	instance responsesView: (CuooraResponsesComponent question: aQuestion).
	^ instance
]

{ #category : #hooks }
CuooraQuestionWithAnswersComponent >> children [ 
	^Array with: responsesView with: questionView.
]

{ #category : #accessing }
CuooraQuestionWithAnswersComponent >> question [
	^ question
]

{ #category : #accessing }
CuooraQuestionWithAnswersComponent >> question: anObject [
	question := anObject
]

{ #category : #accessing }
CuooraQuestionWithAnswersComponent >> questionView [
	^ questionView
]

{ #category : #accessing }
CuooraQuestionWithAnswersComponent >> questionView: anObject [
	questionView := anObject
]

{ #category : #rendering }
CuooraQuestionWithAnswersComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	aCanvas render: questionView.
	aCanvas render: responsesView.
]

{ #category : #accessing }
CuooraQuestionWithAnswersComponent >> responsesView [
	^ responsesView
]

{ #category : #accessing }
CuooraQuestionWithAnswersComponent >> responsesView: anObject [
	responsesView := anObject
]
