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
	^ (self ast members detect: [ :n | n name value = '"on"' ]) value members
		collect: [ :each | each name value allButFirst allButLast ]
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
	| jobAST jobs job|
	jobAST := self ast members detect: [ :n | n name value = '"jobs"' ].
	jobs:= OrderedCollection new.
	job:= WEJob new.
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
	workflow := Workflow new.
	workflow name: self name.
	workflow jobs: self jobs.

	^ workflow
]
