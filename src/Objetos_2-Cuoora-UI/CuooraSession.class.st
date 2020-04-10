Class {
	#name : #CuooraSession,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'Objetos_2-Cuoora-UI'
}

{ #category : #testing }
CuooraSession >> isLoggedIn [
	^ user isNil not.
]

{ #category : #'as yet unclassified' }
CuooraSession >> login: anUser [
	user := anUser.
]

{ #category : #'as yet unclassified' }
CuooraSession >> logout [
	user := nil.
	self session unregister.
]

{ #category : #accessing }
CuooraSession >> user [
	^user.
]
