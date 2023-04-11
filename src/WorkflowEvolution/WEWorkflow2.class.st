Class {
	#name : #WEWorkflow2,
	#superclass : #WENamedEntity2,
	#instVars : [
		'jobs',
		'events',
		'steps',
		'file'
	],
	#category : #'WorkflowEvolution-Model2'
}

{ #category : #accessing }
WEWorkflow2 class >> astFor: ymlFile [
	| ast |
	ast := YAMLParser parse: ymlFile contents.
	^ ast
]

{ #category : #accessing }
WEWorkflow2 class >> exampleFolder [
	^ FileLocator imageDirectory / 'pharo-local' / 'iceberg' / 'pavt'
		/ 'workflow-evolution' / 'yml-json-examples'
]

{ #category : #accessing }
WEWorkflow2 class >> forExample: anAST [
	| visitor |
	visitor := WEWorkflowASTVisitor2 new.
	anAST acceptVisitor: visitor.
	^ visitor 
]

{ #category : #accessing }
WEWorkflow2 class >> fromFile: aYamlFileReference [
	| dataIn |
	dataIn:= self fromString: (aYamlFileReference contents).
	^ self new
		file: aYamlFileReference;
		data: dataIn
]

{ #category : #accessing }
WEWorkflow2 class >> fromFilePath: aYamlFilePath [
	^ self fromFile: aYamlFilePath asFileReference
]

{ #category : #accessing }
WEWorkflow2 class >> fromString: aString [
	^ (YAMLParser parse: aString) acceptVisitor: YAML2JSONVisitor new
]

{ #category : #accessing }
WEWorkflow2 >> data: aDictionary [
	super data: aDictionary.
	self name: (data at: 'name' ifAbsent: ['(missing name)'])
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
WEWorkflow2 >> file [
	^ file
]

{ #category : #accessing }
WEWorkflow2 >> file: anObject [
	file := anObject
]

{ #category : #accessing }
WEWorkflow2 >> gtWorkflowNameFor: aView [
	<gtView>
	^ aView forward
		title: 'Name';
		priority: 20;
		object: [ self name asString ]
]

{ #category : #accessing }
WEWorkflow2 >> initialize [
	events:= OrderedCollection new.
	jobs:= OrderedCollection new.
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
