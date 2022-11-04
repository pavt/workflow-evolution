Class {
	#name : #WEWorkflowExamples,
	#superclass : #Object,
	#category : #'WorkflowEvolution-Examples'
}

{ #category : #accessing }
WEWorkflowExamples >> ciExample [
	<gtExample>
	| workflow |
	workflow := WEWorkflow forExample: 'ci'.
	self assert: workflow name equals: 'CI'.
	self assert: workflow events size equals: 1.
	self assert: workflow jobs size equals: 4.
	^ workflow
]

{ #category : #accessing }
WEWorkflowExamples >> visualizeClassDiagramExample [
	<gtExample>
	| workflow |
	workflow := WEWorkflow forExample: 'visualizeClassDiagram'.
	self assert: workflow name equals: 'UML Class diagram'.
	self assert: workflow events size equals: 3.
	self assert: workflow jobs size equals: 1.
	^ workflow
]