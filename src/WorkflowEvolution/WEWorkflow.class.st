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
WEWorkflow class >> astFor: aLocalPath [
	| ast jsonFile |
	jsonFile := self exampleFolder / (aLocalPath , '.json').
	ast := JSONParser parse: jsonFile contents.
	^ ast
]

{ #category : #accessing }
WEWorkflow class >> exampleFolder [
	^ FileLocator imageDirectory / 'pharo-local' / 'iceberg' / 'pavt'
		/ 'workflow-evolution' / 'yml-json-examples'
]

{ #category : #accessing }
WEWorkflow class >> forExample: aLocalPath [
	| ast visitor |
	ast := self astFor: aLocalPath.
	visitor := WEWorkflowASTVisitor new.
	ast acceptVisitor: visitor.
	^ visitor workflow
]

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
WEWorkflow >> gtEventsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Events';
		priority: 30;
		items: [ self events ];
		column: 'Events' text: [ :event | event name ]
]

{ #category : #accessing }
WEWorkflow >> gtJobsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Jobs';
		priority: 20;
		items: [ self jobs ];
		column: 'Jobs' text: [ :job | job name ]
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
