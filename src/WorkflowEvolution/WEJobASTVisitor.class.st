Class {
	#name : #WEJobASTVisitor,
	#superclass : #JSONParseNodeVisitor,
	#instVars : [
		'job',
		'stepsAST',
		'runner'
	],
	#category : #'WorkflowEvolution-Obsolete'
}

{ #category : #accessing }
WEJobASTVisitor >> initialize [

	job:= OldWEJob new.
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
WEJobASTVisitor >> runner [

	^ runner
]

{ #category : #accessing }
WEJobASTVisitor >> runner: anObject [

	runner := anObject
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

	| members stepVisitor |
	
	self job ast: aJobMemberMemberNode.
	
	members:= aJobMemberMemberNode value members.
	
	job name: aJobMemberMemberNode name value withoutQuoting.
	
	job runner: (members detect: [:n | n  name value = '"runs-on"']) value value value withoutQuoting.

	stepsAST := ( members detect: [ :n | n name value = '"steps"' ]) .  
	
	stepsAST value values
		do: [ :each | 
			stepVisitor := WEStepASTVisitor new.
			each acceptVisitor: stepVisitor.
			self job addStep: stepVisitor step].
			
	 
		 
	
]
