Class {
	#name : #WEWorkflowASTVisitor2,
	#superclass : #YAMLParseNodeVisitor,
	#instVars : [
		'workflow',
		'eventsAST',
		'jobsAST'
	],
	#category : #'WorkflowEvolution-Model2'
}

{ #category : #accessing }
WEWorkflowASTVisitor2 >> eventsAST [
	^ eventsAST
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> eventsAST: anObject [
	eventsAST := anObject
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> initialize [
	workflow := WEWorkflow2 new
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> jobsAST [
	^ jobsAST
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> jobsAST: anObject [
	jobsAST := anObject
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitObject: anASTObjectNode [
	| members |
	members := anASTObjectNode members.	 
	self assert: members size equals: 3.

	self workflow ast: anASTObjectNode.
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> workflow [
	^ workflow
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> workflow: anObject [
	workflow := anObject
]
