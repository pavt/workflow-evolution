Class {
	#name : #WorkflowBasicExamples,
	#superclass : #Object,
	#category : #'WorkflowEvolution-Examples'
}

{ #category : #accessing }
WorkflowBasicExamples >> basicExample [
	<gtExample>
	| workflow |
	workflow := WorkflowBuilder new.
	self assert: workflow directory isNil.
	self assert: workflow filename isNil.
	"self assert: result ast isNil."
	^ workflow
]

{ #category : #accessing }
WorkflowBasicExamples >> nameExample [
	<gtExample>
	| workflow |
	workflow := self visualizeClassDiagramExample.

	self assert: workflow name equals: 'UML Class diagram'.
	^ workflow
]

{ #category : #accessing }
WorkflowBasicExamples >> visualizeClassDiagramExample [

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

{ #category : #accessing }
WorkflowBasicExamples >> visualizeExampleJSON [

	<gtExample>
	| workflow directory filename |
	workflow := self basicExample.
	directory:= FileLocator imageDirectory/ 'pharo-local' / 'iceberg' / 'pavt'/ 'workflow-evolution' / 'yml-json-examples'.
	filename:= 'example'.
	workflow filename: filename.
	workflow directory: directory.
	self assert: workflow directory equals: directory.
	self assert: workflow filename equals: filename.
	self assert: workflow ast isNotNil.
	^ workflow
]
