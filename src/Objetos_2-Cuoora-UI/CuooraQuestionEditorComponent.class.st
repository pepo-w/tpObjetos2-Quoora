Class {
	#name : #CuooraQuestionEditorComponent,
	#superclass : #CuooraPrincipalComponent,
	#instVars : [
		'titulo',
		'descripcion',
		'topicosAsociados'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #'as yet unclassified' }
CuooraQuestionEditorComponent >> crearTopicos [
	| nombresTopicos |
	nombresTopicos := topicosAsociados findBetweenSubstrings: ','.
	^ (nombresTopicos collect: [ :each | (self model agregarTopicoConNombre: each descripcion: '' ) ]) asSet.
	
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> descripcion [
	^ descripcion
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> descripcion: anObject [
	descripcion := anObject
]

{ #category : #callbacks }
CuooraQuestionEditorComponent >> nuevaPregunta [
	self session user crearPreguntaConTitulo: titulo descripcion: descripcion topicosAsociados: self crearTopicos.
	self answer.
]

{ #category : #rendering }
CuooraQuestionEditorComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	aCanvas heading 
		level: 2;
		with: 'Nueva pregunta '.
	aCanvas horizontalRule.
	aCanvas
		form: [ self renderInputElementsOn: aCanvas.
				  self renderSubmitButtonsOn: aCanvas ].
]

{ #category : #rendering }
CuooraQuestionEditorComponent >> renderInputElementsOn: aCanvas [ 
	aCanvas label: 'Título: '.
	aCanvas
		paragraph: [ (aCanvas textInput required on: #titulo of: self) size: 80;
			attributeAt: 'placeholder' put: 'ingrese aqui el titulo de su pregunta' ].
	aCanvas label: 'Descripción: '.
	aCanvas
		paragraph: [ (aCanvas textArea required on: #descripcion of: self)
				columns: 80;
				rows: 5;
				attributeAt: 'placeholder' put: 'ingrese aqui el desarrollo de su pregunta' ].
	aCanvas label: 'Topicos: '.
	aCanvas
		paragraph: [ (aCanvas textInput required on: #topicosAsociados of: self) size: 80; 
			attributeAt: 'placeholder' put: 'ingrese topicos separados por coma' ].
]

{ #category : #rendering }
CuooraQuestionEditorComponent >> renderSubmitButtonsOn: aCanvas [
	aCanvas submitButton
		callback: [ self nuevaPregunta ];
		value: 'Guardar'.
	aCanvas submitButton
		attributeAt: 'formnovalidate' put: true;
		callback: [ self answer ];
		value: 'Cancelar'.
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> titulo [
	^ titulo
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> titulo: anObject [
	titulo := anObject
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> topicosAsociados [
	^ topicosAsociados
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> topicosAsociados: anObject [
	topicosAsociados := anObject
]
