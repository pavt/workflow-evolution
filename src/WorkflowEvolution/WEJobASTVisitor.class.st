Class {
	#name : #WEJobASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'job'
	],
	#category : #'WorkflowEvolution-Visitor'
}

{ #category : #accessing }
WEJobASTVisitor >> initialize [

	job:= WEJob new.
]

{ #category : #accessing }
WEJobASTVisitor >> job [

	^ job
]

{ #category : #accessing }
WEJobASTVisitor >> job: anObject [

	job := anObject
]
