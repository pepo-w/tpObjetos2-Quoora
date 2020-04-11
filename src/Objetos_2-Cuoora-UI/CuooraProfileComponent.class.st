Class {
	#name : #CuooraProfileComponent,
	#superclass : #CuooraHeaderComponent,
	#instVars : [
		'user',
		'questionViews'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #constructor }
CuooraProfileComponent class >> user: anUser [ 
	| instance |
	instance := self new.
	instance user: anUser.
	^ instance.
]

{ #category : #initialization }
CuooraProfileComponent >> initialize [ 
	super initialize.
	questionViews := Dictionary new.
]

{ #category : #'as yet unclassified' }
CuooraProfileComponent >> questionViewForQuestion: aQuestion [ 
	^ questionViews at: aQuestion ifAbsentPut: [ CuooraQuestionComponent question: aQuestion ]
]

{ #category : #rendering }
CuooraProfileComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	self renderTitleOn: aCanvas.
	self renderUserInfoOn: aCanvas.
	aCanvas heading 
		level: 3;
		with: 'Preguntas'.
	self renderQuestionsOn: aCanvas.
	
	
]

{ #category : #rendering }
CuooraProfileComponent >> renderQuestionsOn: aCanvas [
	(self user preguntas) do: [ :each | aCanvas render: (self questionViewForQuestion: each) ]. 
]

{ #category : #rendering }
CuooraProfileComponent >> renderTitleOn: aCanvas [
	aCanvas heading
		level: 2;
		with: [ aCanvas render: 'Perfil de ' , self user nombre.
			(self verifyForFollowOption)
				ifTrue: [ aCanvas render: ' - '.
					aCanvas anchor
						callback: [ self session user seguirA: self user ];
						with: 'Follow' ] ]
]

{ #category : #rendering }
CuooraProfileComponent >> renderUserInfoOn: aCanvas [
	aCanvas
		paragraph: [ aCanvas
				emphasis: 'Puntaje: [' , self user calcularPuntaje asString , ']'.
			aCanvas break.
			aCanvas render: 'Topicos de interes: '.
			aCanvas
				emphasis:
					(self user topicosDeInteres collect: [ :each | each nombre ]) asCommaString.
			aCanvas break ].
]

{ #category : #accessing }
CuooraProfileComponent >> user [
	^ user
]

{ #category : #accessing }
CuooraProfileComponent >> user: anObject [
	user := anObject
]

{ #category : #accessing }
CuooraProfileComponent >> verifyForFollowOption [
	^ self session user ~= self user
		and: [ (self session user sigueA: self user) not ]
]
