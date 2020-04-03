Class {
	#name : #CuooraHomeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'sistema'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #initialization }
CuooraHomeComponent >> initialize [ 
	super initialize.
	sistema := Cuoora unicaInstancia.
]

{ #category : #rendering }
CuooraHomeComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: 'Pagina principal'.
	aCanvas paragraph: 'Preguntas relevantes para el usuario: ', self session user nombre.
	aCanvas
		unorderedList: [ (sistema preguntasRelevantesParaElUsuario: self session user)
				do: [ :each | aCanvas listItem: each titulo ] ].
	aCanvas button
				callback: [  ];
				with: 'Hacer una pregunta'.
]
