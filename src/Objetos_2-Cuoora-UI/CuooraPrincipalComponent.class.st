Class {
	#name : #CuooraPrincipalComponent,
	#superclass : #WAComponent,
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #callbacks }
CuooraPrincipalComponent >> cerrarSesion [
	self session logout.
	self requestContext redirectTo: self application url.
]

{ #category : #accessing }
CuooraPrincipalComponent >> library [ 
	^ CuooraFileLibrary.
]

{ #category : #accessing }
CuooraPrincipalComponent >> model [ 
	^Cuoora unicaInstancia.
]

{ #category : #rendering }
CuooraPrincipalComponent >> renderHeaderOn: aCanvas [
	self renderUserNameOn: aCanvas.
	aCanvas anchor 
		callback: [ self showHome ];
		with: [ aCanvas heading: 'CuOOra' ].
	aCanvas horizontalRule
]

{ #category : #rendering }
CuooraPrincipalComponent >> renderUserNameOn: aCanvas [
	aCanvas div
		class: 'right';
		with: [ aCanvas
				paragraph: [ aCanvas strong: [aCanvas anchor 
																callback: [self showPersonalProfile];
																with: self session user nombre , ' '] .
								aCanvas anchor
									callback: [ self cerrarSesion ];
									with: [ aCanvas button: 'logout' ] ] ].
]

{ #category : #geometry }
CuooraPrincipalComponent >> showHome [ 
	self call: CuooraHomeComponent new.

]

{ #category : #'as yet unclassified' }
CuooraPrincipalComponent >> showPersonalProfile [ 
	|view|
	view := CuooraPersonalProfile user: self session user.
	self call: view.
]

{ #category : #updating }
CuooraPrincipalComponent >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: (self library urlOf: #mainCss).
]
