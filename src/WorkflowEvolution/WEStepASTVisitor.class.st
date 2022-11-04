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
WEStepASTVisitor >> step [

	^ step
]

{ #category : #accessing }
WEStepASTVisitor >> step: anObject [

	step := anObject
]

{ #category : #accessing }
WEStepASTVisitor >> visitObject: anASTObjectNode [
	
	| propertiesAsDictionary |
	self step ast: anASTObjectNode.
	propertiesAsDictionary:= self step properties.
	
	step ast members
		do: [ :propAST | propertiesAsDictionary at: propAST name value withoutQuoting put: propAST value value value ]
]
