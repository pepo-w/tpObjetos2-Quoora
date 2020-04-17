"
Componente que muestra las respuestas a una determinada pregunta.
    Instance Variables
	question:		<a Pregunta>
			
necesito tener como variable de instancia a la pregunta implicada ya que si se agrega una nueva respuesta se mantiene la consistencia en la interfaz
			
recibe un mensaje de Clase para instanciar correctamente:
	CuooraResponsesComponent question: aQuestion
	

"
Class {
	#name : #CuooraResponsesComponent,
	#superclass : #WAComponent,
	#instVars : [
		'question'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #accessing }
CuooraResponsesComponent class >> question: aQuestion [  
	| instance |
	instance := self new.
	instance question: aQuestion.
	^instance.
]

{ #category : #accessing }
CuooraResponsesComponent >> question [ 
	^question 
]

{ #category : #accessing }
CuooraResponsesComponent >> question: aQuestion [
	question := aQuestion.
]

{ #category : #rendering }
CuooraResponsesComponent >> renderButtonOn: aCanvas [
	aCanvas anchor
		callback: [ self showCreateResponsesComponent ];
		with: [  
			aCanvas imageButton 
			url: (CuooraFileLibrary urlOf: #plusIconpngPng);
			style: 'vertical-align:middle'.
			aCanvas render: 'Crear respuesta' ].
]

{ #category : #rendering }
CuooraResponsesComponent >> renderContentOn: aCanvas [
	self responses do: [ :each | self renderResponse: each on: aCanvas  ].
	self renderButtonOn: aCanvas.
	
]

{ #category : #rendering }
CuooraResponsesComponent >> renderReactionsOf: aResponse On: aCanvas [
	aCanvas
		render:
			aResponse cantLikes asString , ' likes | '
				, aResponse cantDislikes asString , ' dislikes '.
	aCanvas break.
	aCanvas anchor
		callback: [ aResponse registrarLikeDe: self session user ];
		with: 'Like '.
	aCanvas render: ' | '.
	^ aCanvas anchor
		callback: [ aResponse registrarDislikeDe: self session user ];
		with: 'Dislike'
]

{ #category : #rendering }
CuooraResponsesComponent >> renderResponse: aResponse on: aCanvas [
	self renderTitleOf: aResponse On: aCanvas.
	aCanvas
		paragraph: [ self renderTextOf: aResponse On: aCanvas.
						self renderReactionsOf: aResponse On: aCanvas ].
	aCanvas horizontalRule
]

{ #category : #rendering }
CuooraResponsesComponent >> renderTextOf: aResponse On: aCanvas [
	aCanvas render: aResponse texto.
	aCanvas break.
	aCanvas break
]

{ #category : #rendering }
CuooraResponsesComponent >> renderTitleOf: aResponse On: aCanvas [
	aCanvas heading
		level: 3;
		with: [ aCanvas emphasis: 'Respuesta de '.
			aCanvas anchor
				callback: [ self showProfileFrom: aResponse autor ];
				with: [ aCanvas emphasis: aResponse autor nombre ]]
]

{ #category : #accessing }
CuooraResponsesComponent >> responses [
	^ question respuestas.
]

{ #category : #'as yet unclassified' }
CuooraResponsesComponent >> showCreateResponsesComponent [ 
	| view |
	view := CuooraResponseEditorComponent question: self question.
	self call: view.
]

{ #category : #'as yet unclassified' }
CuooraResponsesComponent >> showProfileFrom: anUser [
	| view |
	(anUser = self session user) 
		ifTrue: [ view := CuooraPersonalProfile user: self session user ] 
		ifFalse: [ view := CuooraProfileComponent user: anUser ].
	self session presenter call: view.
]
