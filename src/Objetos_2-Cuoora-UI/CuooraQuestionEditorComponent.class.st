Class {
	#name : #CuooraQuestionEditorComponent,
	#superclass : #WAComponent,
	#instVars : [
		'titulo',
		'descripcion',
		'topicos',
		'topicosAsociados'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #callbacks }
CuooraQuestionEditorComponent >> agregarTopicoAsociado: aTopic [
	topicosAsociados add: aTopic.
]

{ #category : #callbacks }
CuooraQuestionEditorComponent >> cancelar [
	self answer.
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
CuooraQuestionEditorComponent >> eliminarTopicoAsociado: aTopic [
	topicosAsociados remove: aTopic ifAbsent: nil.
]

{ #category : #initialization }
CuooraQuestionEditorComponent >> initialize [ 
	super initialize.
	topicosAsociados := OrderedCollection new.
]

{ #category : #callbacks }
CuooraQuestionEditorComponent >> nuevaPregunta [
"aca habria que controlar que se hayan completado todos los campos?"
	self session user crearPreguntaConTitulo: titulo descripcion: descripcion topicosAsociados: topicosAsociados.
	self answer. 
]

{ #category : #rendering }
CuooraQuestionEditorComponent >> renderCheckBoxOf: aTopic on: aCanvas [
	aCanvas text: aTopic nombre.
	aCanvas checkbox
		value: false;
		callback: [ :value | value  
									 ifTrue: [ self agregarTopicoAsociado: aTopic ] 
									 ifFalse: [self eliminarTopicoAsociado: aTopic]]. 
	aCanvas space.
		
]

{ #category : #rendering }
CuooraQuestionEditorComponent >> renderContentOn: aCanvas [
"Estaria bueno que tenga el mismo header que home"
	aCanvas heading level: 1; with: 'Cuoora'.
		aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Titulo: '.
					aCanvas textInput on: #titulo of: self ].
			aCanvas
				paragraph: [ aCanvas label: 'Descripción: '.
					aCanvas textInput on: #descripcion of: self ].
				
				"aca estaria el dropdown para los topicos"
			self renderTopicsOn: aCanvas.
			aCanvas submitButton 
				callback: [ self nuevaPregunta ];
				value: 'Crear pregunta'.
			aCanvas submitButton 
				callback: [ self cancelar ];
				value: 'Cancelar' ].
]

{ #category : #rendering }
CuooraQuestionEditorComponent >> renderTopicsOn: aCanvas [
	aCanvas text: 'Topicos: '.
	topicos do: [ :each | self renderCheckBoxOf: each on: aCanvas ].
	aCanvas break.
	aCanvas horizontalRule.
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
CuooraQuestionEditorComponent >> topicos: anObject [
	topicos := anObject
]
