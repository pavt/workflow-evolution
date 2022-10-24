Class {
	#name : #Workflow,
	#superclass : #Object,
	#instVars : [
		'name',
		'jobs'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
Workflow >> jobs [

	^ jobs
]

{ #category : #accessing }
Workflow >> jobs: aJobCollection [

	jobs := aJobCollection
]

{ #category : #accessing }
Workflow >> name [
	^ name
]

{ #category : #accessing }
Workflow >> name: aString [
	name := aString
]
