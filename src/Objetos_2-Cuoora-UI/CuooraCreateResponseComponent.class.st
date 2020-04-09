Class {
	#name : #CuooraCreateResponseComponent,
	#superclass : #WAComponent,
	#instVars : [
		'text',
		'question'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #services }
CuooraCreateResponseComponent class >> question: aQuestion [ 
	| instance |
	instance := self new.
	instance question: aQuestion.
	^instance.
]

{ #category : #'as yet unclassified' }
CuooraCreateResponseComponent >> crearRespuesta [ 
	
]

{ #category : #accessing }
CuooraCreateResponseComponent >> question [
	^ question
]

{ #category : #accessing }
CuooraCreateResponseComponent >> question: anObject [
	question := anObject
]

{ #category : #rendering }
CuooraCreateResponseComponent >> renderButtonsOn: aCanvas [
	aCanvas submitButton 
		callback: [ self crearRespuesta ];
		with: 'Guardar'.
	aCanvas submitButton
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
CuooraCreateResponseComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ self renderInputOn: aCanvas.
			self renderButtonsOn: aCanvas ]
]

{ #category : #rendering }
CuooraCreateResponseComponent >> renderInputOn: aCanvas [
	aCanvas label: 'RESPONDER'.
	aCanvas
		paragraph: [ (aCanvas textArea on: #text of: self)
				columns: 80;
				rows: 5;
				attributeAt: 'placeholder'
					put: 'Ingrese el texto de la respuesta' ]
]

{ #category : #accessing }
CuooraCreateResponseComponent >> text [
	^ text
]

{ #category : #accessing }
CuooraCreateResponseComponent >> text: anObject [
	text := anObject
]
