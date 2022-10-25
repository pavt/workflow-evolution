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
	We wantto extract the name, the steps and the jobs."
	
	
	anASTObjectNode members.
	
	
	^ self visitParse: anASTObjectNode
]

{ #category : #accessing }
WEWorkflowASTVisitor >> workflow [

	^ workflow
]

{ #category : #accessing }
WEWorkflowASTVisitor >> workflow: aWorkflow [

	workflow := aWorkflow
]
