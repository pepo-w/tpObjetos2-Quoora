Class {
	#name : #Topico,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'descripcion'
	],
	#category : #'Objetos_2-Cuoora-Model-Objetos_2-Cuoora-Model'
}

{ #category : #constructor }
Topico class >> conNombre: unNombre descripcion: unaDescripcion [ 
	^self new initConNombre: unNombre descripcion: unaDescripcion.
]

{ #category : #initialization }
Topico >> initConNombre: unNombre descripcion: unaDescripcion [ 
	nombre := unNombre.
	descripcion := unaDescripcion.
]
