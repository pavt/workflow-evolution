Class {
	#name : #WEWorkflow,
	#superclass : #WEModelEntity,
	#instVars : [
		'jobs',
		'events'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEWorkflow >> addEvent: anEvent [
	self events add: anEvent
]

{ #category : #accessing }
WEWorkflow >> addJob: aJob [
	self jobs add: aJob
]

{ #category : #accessing }
WEWorkflow >> events [
	^ events
]

{ #category : #accessing }
WEWorkflow >> events: anEventCollection [

	events := anEventCollection
]

{ #category : #accessing }
WEWorkflow >> initialize [
	events:= OrderedCollection new.
	jobs:= OrderedCollection new.
]

{ #category : #accessing }
WEWorkflow >> jobs [

	^ jobs
]

{ #category : #accessing }
WEWorkflow >> jobs: aJobCollection [

	jobs := aJobCollection
]

{ #category : #accessing }
WEWorkflow >> name [

	^ (self ast value members  detect: [ :n | n name value = '"name"' ]) value value value withoutQuoting.

]
