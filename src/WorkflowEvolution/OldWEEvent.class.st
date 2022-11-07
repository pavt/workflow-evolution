Class {
	#name : #OldWEEvent,
	#superclass : #OldWEModelEntity,
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
OldWEEvent >> event [

	|event|
	event:= OldWEEvent new.
	event name: self name.
	^ event
]

{ #category : #accessing }
OldWEEvent >> name [
	^ (self ast isKindOf: JSONStringNode)
		ifTrue: [ self ast value value withoutQuoting ]
		ifFalse: [ self ast name value value value withoutQuoting ]
]
