Class {
	#name : #WEStep,
	#superclass : #WEModelEntity,
	#instVars : [
		'name'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEStep >> name [

	^ name
]

{ #category : #accessing }
WEStep >> name: anObject [

	name := anObject
]

{ #category : #accessing }
WEStep >> step [

	|step|
	step:= WEStep new.
	step name: self name.
	^ step
]
