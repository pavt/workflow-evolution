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
WEWorkflowASTVisitor >> workflow [

	^ workflow
]

{ #category : #accessing }
WEWorkflowASTVisitor >> workflow: aWorkflow [

	workflow := aWorkflow
]
