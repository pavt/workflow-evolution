Class {
	#name : #WEWorkflow,
	#superclass : #WEModelEntity,
	#instVars : [
		'events'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEWorkflow >> data: aDictionary [
	super data: aDictionary.
	self initializeEvents
]

{ #category : #accessing }
WEWorkflow >> initializeEvents [
	events := (data at: 'on') associations
			collect: [ :asoc | 
				WEEvent new
					name: asoc key;
					data: asoc value ]
]

{ #category : #accessing }
WEWorkflow >> name [
	^ data at: 'name'
]
