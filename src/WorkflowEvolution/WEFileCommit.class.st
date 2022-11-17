Class {
	#name : #WEFileCommit,
	#superclass : #Object,
	#instVars : [
		'file',
		'commit'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEFileCommit >> commit [

	^ commit
]

{ #category : #accessing }
WEFileCommit >> commit: aCommit [
	commit := aCommit
]

{ #category : #accessing }
WEFileCommit >> diff [
	"We have to search through the IceNode diff tree to find the node for our file."
	| diff theNode  currentNode treesToSearch |
	theNode := nil.
	diff := IceDiff from: self commit to: self commit parent.
	treesToSearch := {diff tree} asOrderedCollection.
	[ theNode isNil and: [ treesToSearch notEmpty ] ]
		whileTrue: [ currentNode := treesToSearch removeFirst.
			currentNode isEmpty
				ifTrue: [ currentNode path basename = self file ifTrue: [ theNode := currentNode ] ]
				ifFalse: [ treesToSearch addAll: currentNode children ] ].
	"What to do if we don't find the node?"
	^ theNode
]

{ #category : #accessing }
WEFileCommit >> file [

	^ file
]

{ #category : #accessing }
WEFileCommit >> file: aFilename [
	file := aFilename
]

{ #category : #accessing }
WEFileCommit >> gtChangesFor: aView [
	<gtView>
	^ aView forward
		title: 'Changes';
		priority: 20;
		object: [ self commit ];
		view: #gtChangesFor:
]

{ #category : #accessing }
WEFileCommit >> gtDetailsFor: aView [
	<gtView>
	^ aView forward
		title: 'Details';
		priority: 10;
		object: [ self commit ];
		view: #gtDetailsFor:
]

{ #category : #accessing }
WEFileCommit >> gtDiffFor: aView [
	<gtView>
	^ aView forward
		title: 'Diff';
		priority: 30;
		object: [ self diff ];
		view: #gtViewDiffFor:
]

{ #category : #accessing }
WEFileCommit >> gtViewTwoPanesDiffFor: aView [
	<gtView>
	^ aView forward
		title: 'Diff (two panes)';
		priority: 40;
		object: [ self diff ];
		view: #gtViewTwoPanesDiffFor:
]