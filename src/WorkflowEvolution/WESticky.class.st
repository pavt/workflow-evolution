Class {
	#name : #WESticky,
	#superclass : #Object,
	#instVars : [
		'stickyCollection'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WESticky class >> for: each [
	^ self new stickyCollection: each
]

{ #category : #accessing }
WESticky >> stickyCollection: each [
	stickyCollection := each
]
