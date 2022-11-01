Class {
	#name : #WEEventASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'event',
		'eventsAST'
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
WEEventASTVisitor >> eventsAST [

	^ eventsAST
]

{ #category : #accessing }
WEEventASTVisitor >> eventsAST: anObject [

	eventsAST := anObject
]

{ #category : #accessing }
WEEventASTVisitor >> initialize [

	event:= WEEvent new.
]

{ #category : #accessing }
WEEventASTVisitor >> visitMember: aEventMemberNode [

	self event ast: aEventMemberNode
]
