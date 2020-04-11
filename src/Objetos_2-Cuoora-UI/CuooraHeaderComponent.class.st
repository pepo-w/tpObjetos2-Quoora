Class {
	#name : #CuooraHeaderComponent,
	#superclass : #WAComponent,
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #callbacks }
CuooraHeaderComponent >> cerrarSesion [
	self session logout.
	self requestContext redirectTo: self application url.
]

{ #category : #accessing }
CuooraHeaderComponent >> library [ 
	^ CuooraFileLibrary.
]

{ #category : #accessing }
CuooraHeaderComponent >> model [ 
	^Cuoora unicaInstancia.
]

{ #category : #rendering }
CuooraHeaderComponent >> renderHeaderOn: aCanvas [
	self renderUserNameOn: aCanvas.
	aCanvas anchor 
		callback: [ self showHome ];
		with: [ aCanvas heading: 'CuOOra' ].
	aCanvas horizontalRule
]

{ #category : #rendering }
CuooraHeaderComponent >> renderUserNameOn: aCanvas [
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
CuooraHeaderComponent >> showHome [ 
	self call: CuooraHomeComponent new.
]

{ #category : #'as yet unclassified' }
CuooraHeaderComponent >> showPersonalProfile [ 
	|view|
	view := CuooraPersonalProfile user: self session user.
	self call: view.
]

{ #category : #updating }
CuooraHeaderComponent >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: (self library urlOf: #mainCss).
]
