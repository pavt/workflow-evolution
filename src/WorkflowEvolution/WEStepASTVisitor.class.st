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
WEStepASTVisitor >> visitObject: aStepObjectNode [
	| propertiesVisitor |
	self step ast: aStepObjectNode.

	propertiesAST := aStepObjectNode value.


	propertiesAST value members
		do: [ :each | 
			propertiesVisitor := WEStepASTVisitor new.
			each acceptVisitor: propertiesVisitor.
			self halt.
			self step addProperties: propertiesVisitor value].
					
]
