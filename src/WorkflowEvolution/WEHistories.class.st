Class {
	#name : #WEHistories,
	#superclass : #Object,
	#instVars : [
		'histories'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #'instance creation' }
WEHistories class >> from: aHistoryCollection [
	^ self new
		histories: aHistoryCollection;
		yourself
]

{ #category : #accessing }
WEHistories >> gtHistoriesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Histories';
		priority: 20;
		items: [ self histories ];
		column: 'Repo' text: [ :each | each repoPath ];
		column: 'YML file' text: [ :each | each ymlFile ]
]

{ #category : #accessing }
WEHistories >> histories [
	^ histories
]

{ #category : #initialization }
WEHistories >> histories: aHistoryCollection [
	histories := aHistoryCollection
]
