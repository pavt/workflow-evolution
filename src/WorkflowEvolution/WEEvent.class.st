Class {
	#name : #WEEvent,
	#superclass : #WEModelEntity,
	#instVars : [
		'name'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEEvent >> event [

	|event|
	event:= WEEvent new.
	event name: self name.
	^ event
]

{ #category : #accessing }
WEEvent >> name [

	^ name
]

{ #category : #accessing }
WEEvent >> name: anObject [

	name := anObject
]
