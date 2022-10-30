Class {
	#name : #WEWorkflow,
	#superclass : #WEModelEntity,
	#instVars : [
		'name',
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
WEWorkflow >> events: aEventCollection [

	events := aEventCollection
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
	^ name
]

{ #category : #accessing }
WEWorkflow >> name: aString [
	name := aString
]
