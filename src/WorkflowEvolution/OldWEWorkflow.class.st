Class {
	#name : #OldWEWorkflow,
	#superclass : #OldWEModelEntity,
	#instVars : [
		'jobs',
		'events',
		'steps'
	],
	#category : #'WorkflowEvolution-Obsolete'
}

{ #category : #accessing }
OldWEWorkflow class >> astFor: aLocalPath [
	| ast jsonFile |
	jsonFile := self exampleFolder / (aLocalPath , '.json').
	ast := JSONParser parse: jsonFile contents.
	^ ast
]

{ #category : #accessing }
OldWEWorkflow class >> exampleFolder [
	^ FileLocator imageDirectory / 'pharo-local' / 'iceberg' / 'pavt'
		/ 'workflow-evolution' / 'yml-json-examples'
]

{ #category : #accessing }
OldWEWorkflow class >> forExample: aLocalPath [
	| ast visitor |
	ast := self astFor: aLocalPath.
	visitor := WEWorkflowASTVisitor new.
	ast acceptVisitor: visitor.
	^ visitor workflow
]

{ #category : #accessing }
OldWEWorkflow >> addEvent: anEvent [
	self events add: anEvent
]

{ #category : #accessing }
OldWEWorkflow >> addJob: aJob [
	self jobs add: aJob
]

{ #category : #accessing }
OldWEWorkflow >> events [
	^ events
]

{ #category : #accessing }
OldWEWorkflow >> events: anEventCollection [

	events := anEventCollection
]

{ #category : #accessing }
OldWEWorkflow >> gtEventsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Events';
		priority: 30;
		items: [ self events ];
		column: 'Events' text: [ :event | event name ]
]

{ #category : #accessing }
OldWEWorkflow >> gtJobsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Jobs';
		priority: 20;
		items: [ self jobs ];
		column: 'Jobs' text: [ :job | job name ]
]

{ #category : #accessing }
OldWEWorkflow >> initialize [
	events:= OrderedCollection new.
	jobs:= OrderedCollection new.
]

{ #category : #accessing }
OldWEWorkflow >> jobs [

	^ jobs
]

{ #category : #accessing }
OldWEWorkflow >> jobs: aJobCollection [

	jobs := aJobCollection
]

{ #category : #accessing }
OldWEWorkflow >> name [

	^ (self ast value members  detect: [ :n | n name value = '"name"' ]) value value value withoutQuoting.

]

{ #category : #accessing }
OldWEWorkflow >> steps [
	| job |
	
	job := self ast members value detect: [ :n | n name value = '"jobs"' ].
	^ (job value members first value members detect: [ :n | n name value = '"steps"' ])  value values
	
		
]

{ #category : #accessing }
OldWEWorkflow >> steps: anObject [

	steps := anObject
]
