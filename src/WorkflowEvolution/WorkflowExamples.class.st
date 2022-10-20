Class {
	#name : #WorkflowExamples,
	#superclass : #Object,
	#category : #WorkflowEvolution
}

{ #category : #accessing }
WorkflowExamples >> basicExample [
	<gtExample>
	| result |
	result := Workflow new.
	self assert: result directory isNil.
	self assert: result filename isNil.
	self assert: result ast isNil.
	^ result
]

{ #category : #accessing }
WorkflowExamples >> visualizeClassDiagramExample [

	<gtExample>
	| result |
	result := self basicExample.
	self assert: result directory isNil.
	self assert: result filename isNil.
	self assert: result ast isNil.
	^ result
]
