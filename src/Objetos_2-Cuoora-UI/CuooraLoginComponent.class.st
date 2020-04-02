"
""para registrar el component""
WAAdmin register: CuooraLoginComponent asApplicationAt: 'cuoora'. 
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
	| home |
	home := CuooraHomeComponent conCombre: nombre password: password.
	self call: home.
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
					aCanvas textInput on: #nombre of: self ].
			aCanvas
				paragraph: [ aCanvas label: 'Contraseña: '.
					aCanvas passwordInput on: #password of: self ].
			aCanvas button
				callback: [ self nuevaSesion ];
				with: 'Iniciar sesion' ]
]
