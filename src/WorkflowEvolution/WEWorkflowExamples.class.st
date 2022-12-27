Class {
	#name : #WEWorkflowExamples,
	#superclass : #Object,
	#category : #'WorkflowEvolution-Examples'
}

{ #category : #accessing }
WEWorkflowExamples >> ahistoryExample [
]

{ #category : #accessing }
WEWorkflowExamples >> ciExample [
	<gtExample>
	| workflow |
	workflow := OldWEWorkflow forExample: 'ci'.
	self assert: workflow name equals: 'CI'.
	self assert: workflow events size equals: 1.
	self assert: workflow jobs size equals: 4.
	^ workflow
]

{ #category : #accessing }
WEWorkflowExamples >> docsYMLHistoryExample [
	<gtExample>
	| history |
	history := WEHistory fromRepoPath: '../fastai' forYML: 'docs.yml' .
	self assert: history workflowCommits size equals: 112.
	self assert: history stickyCommits size equals: 12.
	^ history
]

{ #category : #accessing }
WEWorkflowExamples >> visualizeClassDiagramExample [
	<gtExample>
	| workflow |
	workflow := OldWEWorkflow forExample: 'visualizeClassDiagram'.
	self assert: workflow name equals: 'UML Class diagram'.
	self assert: workflow events size equals: 3.
	self assert: workflow jobs size equals: 1.
	^ workflow
]
