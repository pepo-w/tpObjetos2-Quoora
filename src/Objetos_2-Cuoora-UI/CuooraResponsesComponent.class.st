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
CuooraResponsesComponent >> renderContentOn: aCanvas [
	self responses do: [ :each | self renderResponse: each on: aCanvas  ].
	aCanvas anchor 
		callback: [ self showCreateResponsesComponent ];
		with: 'crear respuesta'.
	
]

{ #category : #rendering }
CuooraResponsesComponent >> renderResponse: aResponse on: aCanvas [
	aCanvas heading 
		level: 3;
		with: [ aCanvas render: 'Respuesta de '.
				  aCanvas anchor
						callback: [ self showProfileFrom: aResponse autor ];
						with: aResponse autor nombre ].
	aCanvas paragraph: [
		aCanvas emphasis: aResponse texto.
		aCanvas break.
		aCanvas break.
		aCanvas render: (aResponse cantLikes asString), ' likes | ', (aResponse cantDislikes asString), ' dislikes '.
		aCanvas break.
		aCanvas anchor 
			callback: [aResponse registrarLikeDe: self session user];
			with: 'Like '.
		aCanvas render: ' | '.
		aCanvas anchor 
			callback: [ aResponse registrarDislikeDe: self session user ];
			with: 'Dislike'. ].
	aCanvas horizontalRule
]

{ #category : #accessing }
CuooraResponsesComponent >> responses [
	^ question respuestas.
]

{ #category : #'as yet unclassified' }
CuooraResponsesComponent >> showCreateResponsesComponent [ 
	| view |
	view := CuooraCreateResponseComponent question: self question.
	self call: view.
]

{ #category : #'as yet unclassified' }
CuooraResponsesComponent >> showProfileFrom: anUser [
	| view |
	view := CuooraProfileComponent user: anUser.
	self session presenter call: view
]
