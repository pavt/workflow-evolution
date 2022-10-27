Class {
	#name : #WEJobASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'job',
		'stepsAST'
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

{ #category : #accessing }
WEJobASTVisitor >> newMethod [
	"This is a new method"
]

{ #category : #accessing }
WEJobASTVisitor >> stepsAST [

	^ stepsAST
]

{ #category : #accessing }
WEJobASTVisitor >> stepsAST: anObject [

	stepsAST := anObject
]

{ #category : #accessing }
WEJobASTVisitor >> visitMember: aJobMemberMemberNode [

	job name: aJobMemberMemberNode  name value withoutQuoting
	
]
