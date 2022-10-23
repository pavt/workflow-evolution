Class {
	#name : #Workflow,
	#superclass : #Object,
	#instVars : [
		'directory',
		'filename',
		'ast'
	],
	#category : #WorkflowEvolution
}

{ #category : #accessing }
Workflow class >> in: directory named: filename [
	| workflow |
	workflow := Workflow new.
	workflow directory: directory.
	workflow filename: filename.
	^ workflow
]

{ #category : #accessing }
Workflow >> ast [
	ast
		ifNil: [ | jsonFile |
			self assert: [ self directory notNil ].

			self assert: [ self filename notNil ].

			jsonFile := self directory / (self filename , '.json').
			ast := JSONParser parse: jsonFile contents ].

	^ ast
]

{ #category : #accessing }
Workflow >> directory [

	^ directory.
]

{ #category : #accessing }
Workflow >> directory: aDirectory [
	directory := aDirectory
]

{ #category : #accessing }
Workflow >> events [

^ ((self ast members  detect: [: n | n name value = '"on"' ]) value members ) collect: [:each | each name value allButFirst allButLast] 
]

{ #category : #accessing }
Workflow >> filename [
	^ filename
]

{ #category : #accessing }
Workflow >> filename: aFilename [
	filename := aFilename
]

{ #category : #accessing }
Workflow >> name [
	^ (self ast members detect: [ :node | node name value = '"name"' ]) value value
		value allButFirst allButLast
]
