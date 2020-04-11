"
""para registrar el component""
  | application |
    application := WAAdmin register: CuooraLoginComponent asApplicationAt: 'cuoora'.
    application preferenceAt: #sessionClass put: CuooraSession.

""para limpiar la unica instancia de Cuoora""
Cuoora clearUnicaInstancia.
"
Class {
	#name : #CuooraLoginComponent,
	#superclass : #WAComponent,
	#instVars : [
		'nombre',
		'password',
		'errorMsg'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #'class initialization' }
CuooraLoginComponent class >> initialize [
	 | application |
    application := WAAdmin register: self asApplicationAt: 'cuoora'.
    application preferenceAt: #sessionClass put: CuooraSession.
]

{ #category : #accessing }
CuooraLoginComponent >> nombre [
	^ nombre
]

{ #category : #accessing }
CuooraLoginComponent >> nombre: anObject [
	nombre := anObject
]

{ #category : #callbacks }
CuooraLoginComponent >> nuevaSesion [
	| user sistema |
	sistema := Cuoora unicaInstancia.
	user := sistema buscarUsuarioConNombre: self nombre yPassword: self password.
	self session login: user.
	self session isLoggedIn
		ifFalse: [ errorMsg := 'El nombre de usuario y/o contraseña son inválidos' ]
		ifTrue: [ self call: CuooraHomeComponent new ]
]

{ #category : #accessing }
CuooraLoginComponent >> password [
	^ password
]

{ #category : #accessing }
CuooraLoginComponent >> password: anObject [
	password := anObject
]

{ #category : #rendering }
CuooraLoginComponent >> renderContentOn: aCanvas [
	aCanvas heading
		level: 1;
		with: 'CuOOra'.
	self showErrorMsgOn: aCanvas.
	aCanvas
		form: [ self renderInputElementsOn: aCanvas.
			aCanvas button
				callback: [ self nuevaSesion ];
				with: 'Iniciar sesion' ].
	
]

{ #category : #rendering }
CuooraLoginComponent >> renderInputElementsOn: aCanvas [
	aCanvas
		paragraph: [ aCanvas label: 'Usuario: '.
			aCanvas textInput required on: #nombre of: self ].
	aCanvas
		paragraph: [ aCanvas label: 'Contraseña: '.
			aCanvas passwordInput required on: #password of: self ]
]

{ #category : #'as yet unclassified' }
CuooraLoginComponent >> showErrorMsgOn: aCanvas [
	errorMsg ifNotNil: [ aCanvas paragraph
								style: 'color:red';
								with: errorMsg.
								errorMsg := nil ]
]

{ #category : #updating }
CuooraLoginComponent >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: (CuooraFileLibrary urlOf: #mainCss).
]
