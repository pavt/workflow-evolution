Class {
	#name : #WEEventASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'event'
	],
	#category : #'WorkflowEvolution-Visitor'
}

{ #category : #accessing }
WEEventASTVisitor >> event [

	^ event
]

{ #category : #accessing }
WEEventASTVisitor >> event: anObject [

	event := anObject
]

{ #category : #accessing }
WEEventASTVisitor >> initialize [

	event:= WEEvent new.
]
