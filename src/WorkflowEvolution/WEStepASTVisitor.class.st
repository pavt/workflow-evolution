Class {
	#name : #WEStepASTVisitor,
	#superclass : #Object,
	#instVars : [
		'step'
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
