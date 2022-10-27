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
WEJob >> addStep: aStep [
	self steps add: aStep
]

{ #category : #accessing }
WEJob >> initialize [
	steps := OrderedCollection new
]

{ #category : #accessing }
WEJob >> job [

	|job|
	job:= WEJob new.
	job name: self name.
	^ job
]

{ #category : #accessing }
WEJob >> name [
	^ name
		
]

{ #category : #accessing }
WEJob >> name: aString [

	name := aString
]

{ #category : #accessing }
WEJob >> steps [

	^ steps
]

{ #category : #accessing }
WEJob >> steps: anObject [

	steps := anObject
]
