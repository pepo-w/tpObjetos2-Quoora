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
		'password'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

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
	| user sistema home|
	sistema := Cuoora unicaInstancia.
	user := sistema buscarUsuarioConNombre: self nombre yPassword: self password.
	self session login: user.
	self session isLoggedIn 
		ifFalse: [ self inform: 'Datos invalidos'  ]
		ifTrue: [  home := CuooraHomeComponent new.
						  self call: home ].

	
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
	aCanvas heading level: 1; with: 'Cuoora'.
		aCanvas
		form: [ aCanvas
				paragraph: [ aCanvas label: 'Usuario: '.
					aCanvas textInput required on: #nombre of: self ].
			aCanvas
				paragraph: [ aCanvas label: 'Contraseña: '.
					aCanvas passwordInput required on: #password of: self ].
			aCanvas button
				callback: [ self nuevaSesion ];
				with: 'Iniciar sesion' ]
			
]
