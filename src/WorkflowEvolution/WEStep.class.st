Class {
	#name : #WEStep,
	#superclass : #WEModelEntity,
	#instVars : [
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
WEStep >> initialize [
	content := OrderedCollection new
]

{ #category : #accessing }
WEStep >> step [

	|step|
	step:= WEStep new.
	step content: self content.
	^ step
]
