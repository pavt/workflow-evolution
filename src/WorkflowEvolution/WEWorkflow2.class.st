Class {
	#name : #WEWorkflow2,
	#superclass : #WENamedEntity2,
	#instVars : [
		'file'
	],
	#category : #'WorkflowEvolution-Model2'
}

{ #category : #accessing }
WEWorkflow2 class >> fromFile: aFileReference [
	^ self new
		file: aFileReference;
		data: (YAMLParser parse: aFileReference)
]

{ #category : #accessing }
WEWorkflow2 >> addJob: aJob [ 

	jobs add: aJob
]

{ #category : #accessing }
WEWorkflow2 >> data: aDictionary [
	super data: aDictionary.
	self name: (data object at: 'name' ifAbsent: ['(missing name)'])
]

{ #category : #accessing }
WEWorkflow2 >> file [
	^ file
]

{ #category : #accessing }
WEWorkflow2 >> file: aFileReference [

	file := aFileReference
]

{ #category : #accessing }
WEWorkflow2 >> jobs [

	^ jobs
]

{ #category : #accessing }
WEWorkflow2 >> jobs: aJobObject [

	jobs := aJobObject
]

{ #category : #accessing }
WEWorkflow2 >> numberOfJobs [

	^ jobs size
]
