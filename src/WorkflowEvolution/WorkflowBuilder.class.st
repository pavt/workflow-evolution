Class {
	#name : #WorkflowBuilder,
	#superclass : #Object,
	#instVars : [
		'directory',
		'filename',
		'ast'
	],
	#category : #'WorkflowEvolution-Builder'
}

{ #category : #accessing }
WorkflowBuilder class >> in: directory named: filename [
	| workflow |
	workflow := WorkflowBuilder new.
	workflow directory: directory.
	workflow filename: filename.
	^ workflow
]

{ #category : #accessing }
WorkflowBuilder >> ast [
	ast
		ifNil: [ | jsonFile |
			self assert: [ self directory notNil ].

			self assert: [ self filename notNil ].

			jsonFile := self directory / (self filename , '.json').
			ast := JSONParser parse: jsonFile contents ].

	^ ast
]

{ #category : #accessing }
WorkflowBuilder >> directory [

	^ directory.
]

{ #category : #accessing }
WorkflowBuilder >> directory: aDirectory [
	directory := aDirectory
]

{ #category : #accessing }
WorkflowBuilder >> events [
	| eventAST events |
	eventAST := self ast members detect: [ :n | n name value = '"on"' ].
	events := OrderedCollection new.
	events addAll: eventAST.
	^ events
]

{ #category : #accessing }
WorkflowBuilder >> filename [
	^ filename
]

{ #category : #accessing }
WorkflowBuilder >> filename: aFilename [
	filename := aFilename
]

{ #category : #accessing }
WorkflowBuilder >> jobs [
	| jobAST jobs |
	jobAST := (self ast members detect: [ :n | n name value = '"jobs"' ]) value
			members.
	jobs := OrderedCollection new.
	jobs addAll: jobAST.
	^ jobs
]

{ #category : #accessing }
WorkflowBuilder >> name [
	^ (self ast members detect: [ :node | node name value = '"name"' ]) value value
		value allButFirst allButLast
]

{ #category : #accessing }
WorkflowBuilder >> workflow [
	| workflow |
	workflow := OldWEWorkflow new.
	workflow name: self name.
	workflow jobs: self jobs.
	

	^ workflow
]
