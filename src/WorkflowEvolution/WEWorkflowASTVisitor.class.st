Class {
	#name : #WEWorkflowASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'workflow'
	],
	#category : #'WorkflowEvolution-Visitor'
}

{ #category : #accessing }
WEWorkflowASTVisitor >> initialize [
	workflow := WEWorkflow new
]

{ #category : #accessing }
WEWorkflowASTVisitor >> visitObject: anASTObjectNode [
	"The AST root is an object node with members.
	We want to extract the name, the steps and the jobs."
	| members workflowNameAST eventsAST jobsAST |
	members := anASTObjectNode members.
	
	"Is this true? Can there be more members?"
	self assert: members size equals: 3.
	
	workflowNameAST := members detect: [: n | n name value = '"name"' ].
	self workflow name: workflowNameAST value value value withoutQuoting.
	
	"Now we should visit the events and jobs ASTs with their own dedicated visitors.
	Open question: do these ASTs contain just one or multiple events, respectively jobs? This will have an impact on the design."

	eventsAST := members detect: [: n | n name value = '"on"' ].
	
	jobsAST := members detect: [: n | n name value = '"jobs"' ].
	
	"When this is done, we can add the events and jobs to the workflow."

]

{ #category : #accessing }
WEWorkflowASTVisitor >> workflow [

	^ workflow
]

{ #category : #accessing }
WEWorkflowASTVisitor >> workflow: aWorkflow [

	workflow := aWorkflow
]
