Class {
	#name : #CuooraQuestionEditorComponent,
	#superclass : #CuooraHeaderComponent,
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
	^ nombresTopicos collect: [ :each | (self model agregarTopicoConNombre: each descripcion: '' ) ].
	
]

{ #category : #boolean }
CuooraQuestionEditorComponent >> datosInvalidos [
	^ (self descripcion isEmpty or: [ self titulo isEmpty or: [ self topicosAsociados isEmpty ]]).
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> descripcion [
	^ descripcion
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> descripcion: anObject [
	descripcion := anObject
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> model [ 
	^Cuoora unicaInstancia.
]

{ #category : #callbacks }
CuooraQuestionEditorComponent >> nuevaPregunta [
	self datosInvalidos
		ifTrue: [ self inform: 'Debe completar todos los campos e ingresar al menos 1 topico' ]
		ifFalse: [ self session user crearPreguntaConTitulo: titulo descripcion: descripcion topicosAsociados: self crearTopicos.
			self answer ]
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
		paragraph: [ (aCanvas textInput on: #titulo of: self) size: 80;
			attributeAt: 'placeholder' put: 'ingrese aqui el titulo de su pregunta' ].
	aCanvas label: 'Descripción: '.
	aCanvas
		paragraph: [ (aCanvas textArea on: #descripcion of: self)
				columns: 80;
				rows: 5;
				attributeAt: 'placeholder' put: 'ingrese aqui el desarrollo de su pregunta' ].
	aCanvas label: 'Topicos: '.
	aCanvas
		paragraph: [ (aCanvas textInput on: #topicosAsociados of: self) size: 80; 
			attributeAt: 'placeholder' put: 'ingrese topicos separados por coma' ].
]

{ #category : #rendering }
CuooraQuestionEditorComponent >> renderSubmitButtonsOn: aCanvas [
	aCanvas submitButton
		callback: [ self nuevaPregunta ];
		value: 'Crear pregunta'.
	aCanvas submitButton
		callback: [ self answer ];
		value: 'Cancelar'
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
