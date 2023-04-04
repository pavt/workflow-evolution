Class {
	#name : #WEWorkflow2,
	#superclass : #WEModelEntity2,
	#instVars : [
		'jobs',
		'events',
		'steps'
	],
	#category : #'WorkflowEvolution-Model2'
}

{ #category : #accessing }
WEWorkflow2 class >> astFor: aLocalPath [
	| ast yamlFile |
	yamlFile := self exampleFolder / (aLocalPath , '.json').
	ast := YAMLParser parse: yamlFile contents.
	^ ast
]

{ #category : #accessing }
WEWorkflow2 class >> exampleFolder [
	^ FileLocator imageDirectory / 'pharo-local' / 'iceberg' / 'pavt'
		/ 'workflow-evolution' / 'yml-json-examples'
]

{ #category : #accessing }
WEWorkflow2 class >> forExample: aLocalPath [
	| ast visitor |
	ast := self astFor: aLocalPath.
	visitor := WEWorkflowASTVisitor2 new.
	ast acceptVisitor: visitor.
	^ visitor workflow
]

{ #category : #accessing }
WEWorkflow2 >> events [
	^ events
]

{ #category : #accessing }
WEWorkflow2 >> events: anObject [
	events := anObject
]

{ #category : #accessing }
WEWorkflow2 >> jobs [
	^ jobs
]

{ #category : #accessing }
WEWorkflow2 >> jobs: anObject [
	jobs := anObject
]

{ #category : #accessing }
WEWorkflow2 >> steps [
	^ steps
]

{ #category : #accessing }
WEWorkflow2 >> steps: anObject [
	steps := anObject
]
