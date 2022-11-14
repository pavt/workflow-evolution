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
WESticky >> author [
	^ self stickyCollection first author
]

{ #category : #accessing }
WESticky >> gtWEStickyFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Commits';
		priority: 10;
		items: [ self stickyCollection ];
		column: 'Author' text: [ :each | each author ];
		column: 'Date time' text: [ :each | each datetime asString ];
		column: 'Duration' text: [ :each | (each datetime - each parent datetime) asString ];
		column: 'Duration' text: [ :each | each comment ]
]

{ #category : #accessing }
WESticky >> stickyCollection [

	^ stickyCollection
]

{ #category : #accessing }
WESticky >> stickyCollection: each [
	stickyCollection := each
]
