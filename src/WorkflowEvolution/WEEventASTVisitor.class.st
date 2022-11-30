Class {
	#name : #WEEventASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'event',
		'eventsAST'
	],
	#category : #'WorkflowEvolution-Obsolete'
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

	event:= OldWEEvent new.
]

{ #category : #accessing }
WEEventASTVisitor >> visitMember: aEventMemberNode [
	self event ast: aEventMemberNode
]

{ #category : #accessing }
WEEventASTVisitor >> visitString: aStringNode [
	self event ast: aStringNode
]
