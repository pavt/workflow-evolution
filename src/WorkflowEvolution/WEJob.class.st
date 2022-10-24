Class {
	#name : #WEJob,
	#superclass : #Object,
	#instVars : [
		'name',
		'steps'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEJob >> name [

	^ name
]

{ #category : #accessing }
WEJob >> name: anObject [

	name := anObject
]
