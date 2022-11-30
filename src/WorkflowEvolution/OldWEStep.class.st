Class {
	#name : #OldWEStep,
	#superclass : #OldWEModelEntity,
	#instVars : [
		'properties'
	],
	#category : #'WorkflowEvolution-Obsolete'
}

{ #category : #accessing }
OldWEStep >> initialize [
	properties := Dictionary new.
]

{ #category : #accessing }
OldWEStep >> properties [
	^ properties
]

{ #category : #accessing }
OldWEStep >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
OldWEStep >> step [

	|step|
	step:= OldWEStep new.
	step properties: self properties.
	^ step
]

{ #category : #accessing }
OldWEStep >> step: anObject [

	step := anObject
]
