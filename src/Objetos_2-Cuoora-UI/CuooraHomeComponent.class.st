Class {
	#name : #CuooraHomeComponent,
	#superclass : #WAComponent,
	#instVars : [
		'sistema',
		'usuario'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #initialization }
CuooraHomeComponent class >> conCombre: unNombre password: unPassword [ 
	^ self new conNombre: unNombre password: unPassword. 
]

{ #category : #initialization }
CuooraHomeComponent >> conNombre: unNombre password: unPassword [
	self initialize.
	sistema := Cuoora unicaInstancia.
	usuario := sistema registrarUsuarioConNombre: unNombre password: unPassword.
]

{ #category : #rendering }
CuooraHomeComponent >> renderContentOn: aCanvas [
	aCanvas paragraph: 'Pagina principal'.
	aCanvas paragraph: 'Preguntas relevantes para el usuario: ', usuario nombre.
	aCanvas
		unorderedList: [ (sistema preguntasRelevantesParaElUsuario: usuario)
				do: [ :each | aCanvas listItem: each titulo ] ].
	aCanvas button
				callback: [  ];
				with: 'Hacer una pregunta'.
]
