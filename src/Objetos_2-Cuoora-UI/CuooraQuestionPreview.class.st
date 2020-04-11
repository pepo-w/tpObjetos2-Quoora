Class {
	#name : #CuooraQuestionPreview,
	#superclass : #CuooraQuestionComponent,
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #rendering }
CuooraQuestionPreview >> renderAuthorOn: aCanvas [
	super renderAuthorOn: aCanvas.
	aCanvas strong: question respuestas size asString , ' respuestas'.
	aCanvas break
]

{ #category : #rendering }
CuooraQuestionPreview >> renderTitleOn: aCanvas [
	aCanvas heading
		level: 3;
		attributeAt: 'title' put: question descripcion;
		with: [ aCanvas anchor
				callback: [ self showQuestionWithAnswers ];
				with: [ aCanvas emphasis: question titulo ] ]
]
