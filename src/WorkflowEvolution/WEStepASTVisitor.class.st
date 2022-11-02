Class {
	#name : #WEStepASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'step',
		'propertiesAST'
	],
	#category : #'WorkflowEvolution-Visitor'
}

{ #category : #accessing }
WEStepASTVisitor >> initialize [

	step:= WEStep new.
]

{ #category : #accessing }
WEStepASTVisitor >> propertiesAST [

	^ propertiesAST
]

{ #category : #accessing }
WEStepASTVisitor >> propertiesAST: anObject [

	propertiesAST := anObject
]

{ #category : #accessing }
WEStepASTVisitor >> step [

	^ step
]

{ #category : #accessing }
WEStepASTVisitor >> step: anObject [

	step := anObject
]

{ #category : #accessing }
WEStepASTVisitor >> visitMember: anEventMemberNode [
	
	
	self step ast: anEventMemberNode.
	
	"step properties: anEventMemberNode value."
	
	"propertiesAST := (aEventMemberNode value)."
	
 


]
