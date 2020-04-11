Class {
	#name : #CuooraResponseEditorComponent,
	#superclass : #WAComponent,
	#instVars : [
		'text',
		'question'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #services }
CuooraResponseEditorComponent class >> question: aQuestion [ 
	| instance |
	instance := self new.
	instance question: aQuestion.
	^instance.
]

{ #category : #'as yet unclassified' }
CuooraResponseEditorComponent >> crearRespuesta [ 
	(self session user) crearRespuestaConTexto: self text paraPregunta: self question. 
	self answer.
]

{ #category : #accessing }
CuooraResponseEditorComponent >> question [
	^ question
]

{ #category : #accessing }
CuooraResponseEditorComponent >> question: anObject [
	question := anObject
]

{ #category : #rendering }
CuooraResponseEditorComponent >> renderButtonsOn: aCanvas [
	aCanvas submitButton 
		callback: [ self crearRespuesta ];
		with: 'Guardar'.
	aCanvas submitButton
		attributeAt: 'formnovalidate' put: true;
		callback: [ self answer ];
		with: 'Cancelar'
]

{ #category : #rendering }
CuooraResponseEditorComponent >> renderContentOn: aCanvas [
	aCanvas
		form: [ self renderInputOn: aCanvas.
			self renderButtonsOn: aCanvas ]
]

{ #category : #rendering }
CuooraResponseEditorComponent >> renderInputOn: aCanvas [
	aCanvas label: 'RESPONDER'.
	aCanvas
		paragraph: [ (aCanvas textArea required on: #text of: self)
				columns: 70;
				rows: 10;
				attributeAt: 'placeholder'
					put: 'Ingrese el texto de la respuesta';
				style: 'resize:none'. ]
]

{ #category : #accessing }
CuooraResponseEditorComponent >> text [
	^ text
]

{ #category : #accessing }
CuooraResponseEditorComponent >> text: anObject [
	text := anObject
]
