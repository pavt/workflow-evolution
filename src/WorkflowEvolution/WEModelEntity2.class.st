Class {
	#name : #WEModelEntity2,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : #'WorkflowEvolution-Model2'
}

{ #category : #accessing }
WEModelEntity2 >> data [
	^ data
]

{ #category : #accessing }
WEModelEntity2 >> data: dictionary [ 

	data:= dictionary ifNil: [Dictionary new]
]
