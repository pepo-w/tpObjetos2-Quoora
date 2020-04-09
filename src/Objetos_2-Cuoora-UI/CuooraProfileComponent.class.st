Class {
	#name : #CuooraProfileComponent,
	#superclass : #WAComponent,
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
	aCanvas heading 
		level: 2;
		with: [aCanvas render: 'Preguntas de ', self user nombre.
				 (self verifyForFollowOption)
					ifTrue: [ aCanvas render: ' - '.
								 aCanvas anchor 
										callback: [ self session user seguirA: self user ];
										with: 'Follow' ]].
	self renderQuestionsOn: aCanvas.
	
	
]

{ #category : #rendering }
CuooraProfileComponent >> renderQuestionsOn: aCanvas [
	(self user preguntas) do: [ :each | aCanvas render: (self questionViewForQuestion: each) ]. 
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
