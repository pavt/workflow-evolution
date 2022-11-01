Class {
	#name : #WorkflowExamples,
	#superclass : #Object,
	#category : #'WorkflowEvolution-Examples'
}

{ #category : #accessing }
WorkflowExamples >> visualizeClassDiagramExample [
	<gtExample>
	| workflow |
	workflow := WEWorkflow forExample: 'visualizeClassDiagram'.
	self assert: workflow name equals: 'UML Class diagram'.
	self assert: workflow events size equals: 3.
	self assert: workflow jobs size equals: 1.
	^ workflow
]
