Class {
	#name : #WEWorkflow,
	#superclass : #Object,
	#instVars : [
		'name',
		'jobs'
	],
	#category : #'WorkflowEvolution-Model'
}

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
