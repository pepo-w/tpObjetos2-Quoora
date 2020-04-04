Class {
	#name : #CuooraHomeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'sistema'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #'as yet unclassified' }
CuooraHomeComponent >> cerrarSesion [
	self session logout.
	self answer.
]

{ #category : #initialization }
CuooraHomeComponent >> initialize [ 
	super initialize.
	sistema := Cuoora unicaInstancia.
]

{ #category : #rendering }
CuooraHomeComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	aCanvas paragraph: 'Pagina principal'.
	aCanvas paragraph: 'Preguntas relevantes para el usuario: ', self session user nombre.
	aCanvas
		unorderedList: [ (sistema preguntasRelevantesParaElUsuario: self session user)
				do: [ :each | aCanvas listItem: each titulo ] ].
	aCanvas button
				callback: [  ];
				with: 'Hacer una pregunta'.
]

{ #category : #rendering }
CuooraHomeComponent >> renderHeaderOn: aCanvas [
	aCanvas div 
		class: 'right';
		with: [aCanvas paragraph: [ aCanvas render: self session user nombre, ' | '.  
								aCanvas anchor callback: [self cerrarSesion];
								               with: 'logout']].	
	aCanvas heading: 'CuOOra'.
	aCanvas horizontalRule
]

{ #category : #hooks }
CuooraHomeComponent >> style [
	^'.right {
    float: right;
	}'
]
