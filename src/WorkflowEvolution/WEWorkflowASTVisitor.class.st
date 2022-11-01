Class {
	#name : #WEWorkflowASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'workflow',
		'eventsAST',
		'jobsAST'
	],
	#category : #'WorkflowEvolution-Visitor'
}

{ #category : #accessing }
WEWorkflowASTVisitor >> eventsAST [

	^ eventsAST
]

{ #category : #accessing }
WEWorkflowASTVisitor >> eventsAST: anObject [

	eventsAST := anObject
]

{ #category : #accessing }
WEWorkflowASTVisitor >> initialize [
	workflow := WEWorkflow new
]

{ #category : #accessing }
WEWorkflowASTVisitor >> jobsAST [

	^ jobsAST
]

{ #category : #accessing }
WEWorkflowASTVisitor >> jobsAST: anObject [

	jobsAST := anObject
]

{ #category : #accessing }
WEWorkflowASTVisitor >> visitObject: anASTObjectNode [
	
	| members eventVisitor jobVisitor |
	
	members := anASTObjectNode members.	"Is this true? Can there be more members?"
	
	self assert: members size equals: 3.


	self workflow ast: anASTObjectNode.	
	
	"Now we should visit the events and jobs ASTs with their own dedicated visitors.
	Open question: do these ASTs contain just one or multiple events, respectively jobs? This will have an impact on the design."	"answer: some of them do not have a collection of events"

	eventsAST := (members detect: [ :n1 | n1 name value = '"on"' ]) .
	
	
	eventsAST value members
		do: [ :each | 
			eventVisitor := WEEventASTVisitor new.
			each acceptVisitor: eventVisitor.
			self workflow addEvent: eventVisitor event ].


	jobsAST := members detect: [ :n2 | n2 name value = '"jobs"' ].
	
	jobsAST value members
		do: [ :each | 
			jobVisitor := WEJobASTVisitor new.
			each acceptVisitor: jobVisitor.
			self workflow addJob: jobVisitor job ].
]

{ #category : #accessing }
WEWorkflowASTVisitor >> workflow [

	^ workflow
]

{ #category : #accessing }
WEWorkflowASTVisitor >> workflow: aWorkflow [

	workflow := aWorkflow
]
