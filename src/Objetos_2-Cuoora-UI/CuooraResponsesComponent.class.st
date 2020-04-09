"
Componente que muestra las respuestas a una determinada pregunta.
    Instance Variables
	question:		<una coleccion de respuestas>
			
recibe un mensaje de Clase para instanciar con las respuestas:
	CuooraResponsesComponent responses: aCollectionOfRespuestas
"
Class {
	#name : #CuooraResponsesComponent,
	#superclass : #WAComponent,
	#instVars : [
		'responses'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #accessing }
CuooraResponsesComponent class >> responses: aCollection [ 
	| instance |
	instance := self new.
	instance responses: aCollection.
	^instance.
]

{ #category : #rendering }
CuooraResponsesComponent >> renderContentOn: aCanvas [
	responses do: [ :each | self renderResponse: each on: aCanvas  ].
]

{ #category : #rendering }
CuooraResponsesComponent >> renderResponse: aResponse on: aCanvas [
	"Aca iran todos los datos de la respuesta para que quede de la siguiente manera: 
		Respuesta de Pedro
		Texto de la respuesta ....
		0 likes | 0 dislikes
		Like | Dislike"
]

{ #category : #accessing }
CuooraResponsesComponent >> responses [
	^ responses
]

{ #category : #accessing }
CuooraResponsesComponent >> responses: aCollection [
	responses := aCollection.
]
