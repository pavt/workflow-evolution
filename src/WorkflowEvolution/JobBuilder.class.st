Class {
	#name : #JobBuilder,
	#superclass : #Object,
	#instVars : [
		'name',
		'steps'
	],
	#category : #'WorkflowEvolution-Builder'
}

{ #category : #accessing }
JobBuilder >> job [
	| aJob |
	aJob := JobBuilder new.
	aJob name: self name.
	aJob steps: self steps.

	^ aJob
]

{ #category : #accessing }
JobBuilder >> name [

	^ name
]

{ #category : #accessing }
JobBuilder >> name: anObject [

	name := anObject
]

{ #category : #accessing }
JobBuilder >> steps [
	^ steps 
]

{ #category : #accessing }
JobBuilder >> steps: anObject [

	steps := anObject
]
