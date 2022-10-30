Class {
	#name : #WEJobASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'job',
		'stepsAST',
		'runner'
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
WEJobASTVisitor >> stepsAST [

	^ stepsAST
]

{ #category : #accessing }
WEJobASTVisitor >> stepsAST: anObject [

	stepsAST := anObject
]

{ #category : #accessing }
WEJobASTVisitor >> visitMember: aJobMemberMemberNode [

	| members test |
	
	members:= aJobMemberMemberNode value members.
	test:= aJobMemberMemberNode value members .
	
	job name: aJobMemberMemberNode  name value withoutQuoting.
	
	job runner: (members detect: [:n | n  name value = '"runs-on"']) value value value withoutQuoting.
	
	

	"problem: need to cut the content of steps AST?"
	
	
]
