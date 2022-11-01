Class {
	#name : #WEEvent,
	#superclass : #WEModelEntity,
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
	^ (self ast isKindOf: JSONStringNode)
		ifTrue: [ self ast value value withoutQuoting ]
		ifFalse: [ self ast name value value value withoutQuoting ]
]
