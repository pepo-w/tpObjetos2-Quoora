Class {
	#name : #CuooraQuestionEditorComponent,
	#superclass : #WAComponent,
	#instVars : [
		'titulo',
		'descripcion',
		'topicos'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

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
CuooraQuestionEditorComponent >> nuevaPregunta [
"aca habria que controlar que se hayan completado todos los campos?"
topicos := OrderedCollection new.
	self session user crearPreguntaConTitulo: titulo descripcion: descripcion topicosAsociados: topicos.
	self answer. 
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
				
			aCanvas submitButton 
				callback: [ self nuevaPregunta ];
				value: 'Crear pregunta'.
			aCanvas submitButton 
				callback: [ self cancelar ];
				value: 'Cancelar' ].
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
CuooraQuestionEditorComponent >> topicos [
	^ topicos
]

{ #category : #accessing }
CuooraQuestionEditorComponent >> topicos: anObject [
	topicos := anObject
]
