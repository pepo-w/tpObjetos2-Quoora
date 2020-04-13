Class {
	#name : #CuooraProfileComponent,
	#superclass : #CuooraPrincipalComponent,
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

{ #category : #hooks }
CuooraProfileComponent >> children [ 
	^ self questions collect: [ :each | self questionViewForQuestion: each ].
	
]

{ #category : #initialization }
CuooraProfileComponent >> initialize [ 
	super initialize.
	questionViews := Dictionary new.
]

{ #category : #'dictionary access' }
CuooraProfileComponent >> questionViewForQuestion: aQuestion [ 
	^ questionViews at: aQuestion ifAbsentPut: [ CuooraQuestionPreview question: aQuestion ]
]

{ #category : #'as yet unclassified' }
CuooraProfileComponent >> questions [ 
	"Retorna las preguntas del usuario correspondiente al perfil actual, ordenadas con las más recientes primero"
	^ (self user preguntas) asSortedCollection: [ :q1 :q2 | q1 fechaYHora > q2 fechaYHora ].
]

{ #category : #rendering }
CuooraProfileComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	self renderTitleOn: aCanvas.
	self renderUserInfoOn: aCanvas.
	aCanvas horizontalRule.
	self renderQuestionsOn: aCanvas.
	
	
]

{ #category : #rendering }
CuooraProfileComponent >> renderQuestionsOn: aCanvas [
	aCanvas heading 
		level: 3;
		with: 'Preguntas'.
	(self user preguntas isEmpty)
			ifTrue: [ aCanvas emphasis: 'Sin preguntas' ]
			ifFalse: [ (self questions) do: [ :each | aCanvas render: (self questionViewForQuestion: each) ] ].
			 
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
CuooraProfileComponent >> renderTopicsOfInterestOn: aCanvas [
	aCanvas render: 'Topicos de interes: '.
	(self user topicosDeInteres) isEmpty
		ifTrue: [ aCanvas strong: ' - ' ] 
		ifFalse: [ aCanvas emphasis: (self user topicosDeInteres collect: [ :each | each nombre ]) asCommaString ].
	aCanvas break.
]

{ #category : #rendering }
CuooraProfileComponent >> renderUserInfoOn: aCanvas [
	aCanvas
		paragraph: [ aCanvas emphasis: 'Puntaje: [' , self user calcularPuntaje asString , ']'.
						 aCanvas break.
						 self renderTopicsOfInterestOn: aCanvas ]
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
