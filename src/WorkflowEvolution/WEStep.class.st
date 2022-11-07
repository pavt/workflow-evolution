Class {
	#name : #WEStep,
	#superclass : #WEModelEntity,
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEStep >> getField: fieldName [
	^ (self data at: fieldName ifAbsent: [''])
]

{ #category : #accessing }
WEStep >> uses [
	^ (self getField: 'uses')
]

{ #category : #accessing }
WEStep >> with [
	^ (self getField: 'with')
]
