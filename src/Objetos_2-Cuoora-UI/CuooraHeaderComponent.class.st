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
	aCanvas div
		class: 'right';
		with: [ aCanvas
				paragraph: [ aCanvas strong: self session user nombre , ' '.
					aCanvas anchor
						callback: [ self cerrarSesion ];
						with: [ aCanvas button: 'logout' ] ] ].
	aCanvas anchor 
		callback: [ self showHome ];
		with: [ aCanvas heading: 'CuOOra' ].
	aCanvas horizontalRule
]

{ #category : #geometry }
CuooraHeaderComponent >> showHome [ 
	self call: CuooraHomeComponent new.
]

{ #category : #updating }
CuooraHeaderComponent >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot stylesheet url: (self library urlOf: #mainCss).
]
