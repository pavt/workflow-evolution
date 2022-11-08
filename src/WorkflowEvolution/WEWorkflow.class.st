Class {
	#name : #WEWorkflow,
	#superclass : #WENamedEntity,
	#instVars : [
		'events',
		'jobs'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #initialization }
WEWorkflow >> data: aDictionary [
	super data: aDictionary.
	self initializeEvents.
	self initializeJobs.
	self name: (data at: 'name' ifAbsent: ['(missing name)'])
]

{ #category : #accessing }
WEWorkflow >> events [
	^ events
]

{ #category : #accessing }
WEWorkflow >> gtEventsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Events';
		priority: 20;
		items: [ self events ];
		column: 'Event' text: [ :event | event name ]
]

{ #category : #accessing }
WEWorkflow >> gtJobsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Jobs';
		priority: 30;
		items: [ self jobs ];
		column: 'Job' text: [ :job | job name ]
]

{ #category : #initialization }
WEWorkflow >> initializeEvents [
	| eventDictionary |
	eventDictionary := data at: 'on' ifAbsent: [ '' ].
	(eventDictionary isKindOf: String)
		ifTrue: [ events := OrderedCollection new ]
		ifFalse: [ events := (data at: 'on') associations
					collect: [ :asoc | 
						WEEvent new
							name: asoc key;
							data: asoc value ] ]
]

{ #category : #initialization }
WEWorkflow >> initializeJobs [
	| jobDictionary |
	jobDictionary := data at: 'jobs' ifAbsent: [''].
	(jobDictionary isKindOf: String)
		ifTrue: [ jobs := OrderedCollection new ]
		ifFalse: [ jobs := (data at: 'jobs') associations
					collect: [ :asoc | 
						WEJob new
							name: asoc key;
							data: asoc value ] ]
]

{ #category : #accessing }
WEWorkflow >> jobs [
	^ jobs
]
