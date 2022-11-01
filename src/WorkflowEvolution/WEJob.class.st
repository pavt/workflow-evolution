Class {
	#name : #WEJob,
	#superclass : #WEModelEntity,
	#instVars : [
		'steps',
		'runner',
		'name'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEJob >> addRunner: aRunner [
	self runner add: aRunner
]

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
WEJob >> name: anObject [

	name := anObject
]

{ #category : #accessing }
WEJob >> runner [

	^ runner
]

{ #category : #accessing }
WEJob >> runner: aString [

	runner := aString
]

{ #category : #accessing }
WEJob >> steps [

	^ steps
]

{ #category : #accessing }
WEJob >> steps: anObject [

	steps := anObject
]
