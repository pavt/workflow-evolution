Class {
	#name : #WorkflowExamples,
	#superclass : #Object,
	#category : #WorkflowEvolution
}

{ #category : #accessing }
WorkflowExamples >> basicExample [
	<gtExample>
	| workflow |
	workflow := Workflow new.
	self assert: workflow directory isNil.
	self assert: workflow filename isNil.
	"self assert: result ast isNil."
	^ workflow
]

{ #category : #accessing }
WorkflowExamples >> nameExample [
	<gtExample>
	| workflow |
	workflow := self visualizeClassDiagramExample.

	self assert: workflow name equals: 'UML Class diagram'.
	^ workflow
]

{ #category : #accessing }
WorkflowExamples >> visualizeClassDiagramExample [

	<gtExample>
	| workflow directory filename |
	workflow := self basicExample.
	directory:= FileLocator imageDirectory/ 'pharo-local' / 'iceberg' / 'pavt'/ 'workflow-evolution' / 'yml-json-examples'.
	filename:= 'visualizeClassDiagram'.
	workflow filename: filename.
	workflow directory: directory.
	self assert: workflow directory equals: directory.
	self assert: workflow filename equals: filename.
	self assert: workflow ast isNotNil.
	^ workflow
	
]
