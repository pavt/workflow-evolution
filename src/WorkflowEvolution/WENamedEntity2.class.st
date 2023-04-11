Class {
	#name : #WENamedEntity2,
	#superclass : #WEModelEntity2,
	#instVars : [
		'name'
	],
	#category : #'WorkflowEvolution-Model2'
}

{ #category : #accessing }
WENamedEntity2 >> name [
	^ name
]

{ #category : #accessing }
WENamedEntity2 >> name: anObject [
	name := anObject
]

{ #category : #accessing }
WENamedEntity2 >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '(', self name,')'
]
