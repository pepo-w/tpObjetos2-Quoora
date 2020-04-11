Class {
	#name : #CuooraAddInterestTopicComponent,
	#superclass : #CuooraPrincipalComponent,
	#instVars : [
		'lastSelectedTopic'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #adding }
CuooraAddInterestTopicComponent >> addInterestTopic: aTopic [
	self session user agregarTopicoDeInteres: aTopic.
	lastSelectedTopic := aTopic nombre.
]

{ #category : #'as yet unclassified' }
CuooraAddInterestTopicComponent >> getValidTopics [ 
	| topics |
	topics := (self model topicos).
	(self session user topicosDeInteres) do: [ :each | topics remove: each ifAbsent: [ nil ] ].
	^ topics asSortedCollection: [ :t1 :t2 | (t1 nombre) asUppercase <= (t2 nombre) asUppercase ].
]

{ #category : #rendering }
CuooraAddInterestTopicComponent >> renderContentOn: aCanvas [
	self renderHeaderOn: aCanvas.
	aCanvas heading 
		level: 2;
		with: 'Tópicos de CuOOra'.
	self renderTopicListOn: aCanvas.
	aCanvas anchor 
		callback: [ self answer ];
		with: [ aCanvas button with: 'Hecho' ].	
	self renderLastSelectedTopicOn: aCanvas.
		
]

{ #category : #rendering }
CuooraAddInterestTopicComponent >> renderLastSelectedTopicOn: aCanvas [
	lastSelectedTopic
		ifNotNil: [ aCanvas paragraph: 
							[ aCanvas render: 'Se añadió '.
							  aCanvas emphasis: lastSelectedTopic.
							  aCanvas render: ' a tópicos de interés' ] ] 
]

{ #category : #rendering }
CuooraAddInterestTopicComponent >> renderTopicListOn: aCanvas [
	aCanvas
		paragraph: 'Haga click en un tópico para agregarlo a sus tópicos de interés'.
	aCanvas
		unorderedList: [ self getValidTopics
				do: [ :topic | 
					aCanvas
						listItem: [ aCanvas anchor
								callback: [ self addInterestTopic: topic ];
								with: topic nombre ] ] ]
]
