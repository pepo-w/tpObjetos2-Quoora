Class {
	#name : #CuooraPersonalProfile,
	#superclass : #CuooraProfileComponent,
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #callbacks }
CuooraPersonalProfile >> crearPregunta [ 
	self call: CuooraQuestionEditorComponent new.
]

{ #category : #rendering }
CuooraPersonalProfile >> renderFollowingUsersListOn: aCanvas [
	aCanvas
		unorderedList: [ self user usuariosQueSigue
				do: [ :usr | 
					aCanvas
						listItem: [ aCanvas anchor
								callback: [ self showProfileOf: usr ];
								with: usr nombre ] ] ]
	
]

{ #category : #rendering }
CuooraPersonalProfile >> renderFollowingUsersOn: aCanvas [
	aCanvas strong: 'Sigues a: '.
	((self user usuariosQueSigue isEmpty))
		ifTrue: [ aCanvas emphasis: 'Todavía no sigues a nadie...' ] 
		ifFalse: [ self renderFollowingUsersListOn: aCanvas ].
	
]

{ #category : #rendering }
CuooraPersonalProfile >> renderQuestionsOn: aCanvas [
	aCanvas anchor
		class: 'right';
		callback: [ self crearPregunta ];
		with: [ aCanvas imageButton 
							url: (self library urlOf: #plusIconpngPng);
							style: 'vertical-align:middle'.
			aCanvas render: 'crear pregunta' ].
	super renderQuestionsOn: aCanvas
]

{ #category : #rendering }
CuooraPersonalProfile >> renderTitleOn: aCanvas [
	aCanvas heading 
		level: 2;
		with: 'Tu perfil'.
]

{ #category : #rendering }
CuooraPersonalProfile >> renderUserInfoOn: aCanvas [
	super renderUserInfoOn: aCanvas.
	aCanvas
		paragraph: [ aCanvas anchor
				callback: [ self showAddTopics ];
				with: [ aCanvas button with: 'Agregar tópicos de interes' ].
			aCanvas break ].
	self renderFollowingUsersOn: aCanvas
]

{ #category : #'as yet unclassified' }
CuooraPersonalProfile >> showAddTopics [ 
	self call: (CuooraAddInterestTopicComponent new)
]

{ #category : #'as yet unclassified' }
CuooraPersonalProfile >> showProfileOf: anUser [ 
	| view |
	view := CuooraProfileComponent user: anUser.
	self call: view.
]
