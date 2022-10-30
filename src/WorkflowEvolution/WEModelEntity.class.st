Class {
	#name : #WEModelEntity,
	#superclass : #Object,
	#instVars : [
		'ast',
		'aJob'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEModelEntity >> aJob [

	^ aJob
]

{ #category : #accessing }
WEModelEntity >> aJob: anObject [

	aJob := anObject
]

{ #category : #accessing }
WEModelEntity >> ast [

	^ ast
]

{ #category : #accessing }
WEModelEntity >> ast: anObject [

	ast := anObject
]
