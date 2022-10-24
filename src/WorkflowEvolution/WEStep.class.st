Class {
	#name : #WEStep,
	#superclass : #Object,
	#instVars : [
		'name',
		'content'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEStep >> content [

	^ content
]

{ #category : #accessing }
WEStep >> content: anObject [

	content := anObject
]

{ #category : #accessing }
WEStep >> name [

	^ name
]

{ #category : #accessing }
WEStep >> name: anObject [

	name := anObject
]
