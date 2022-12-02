Class {
	#name : #WEHistories,
	#superclass : #Object,
	#instVars : [
		'histories',
		'initializedHistories',
		'processes',
		'mutex'
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
WEHistories >> gtInitializedHistoriesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Initialized Histories';
		priority: 30;
		items: [ self initializedHistories ];
		column: 'Repo' text: [ :each | each repoPath ];
		column: 'YML file' text: [ :each | each ymlFile ]
]

{ #category : #accessing }
WEHistories >> gtWorkflowHistoriesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Workflow Histories';
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

{ #category : #computation }
WEHistories >> historyTasks [
	^ self histories collect: [ :each | [ each initializeWorkflowCommitsNicely ] ]
]

{ #category : #accessing }
WEHistories >> initialize [
	mutex := Semaphore forMutualExclusion.
	self histories: OrderedCollection new.
	self initializedHistories: OrderedCollection new asValueHolder
]

{ #category : #accessing }
WEHistories >> initializedHistories [

	^ initializedHistories
]

{ #category : #accessing }
WEHistories >> initializedHistories: anObject [

	initializedHistories := anObject
]

{ #category : #computation }
WEHistories >> killHistoryTasks [
	processes do: #terminate
]

{ #category : #computation }
WEHistories >> spawnHistoryTasks [
	processes := OrderedCollection new.
	self historyTasks
		do: [ :task | 
			processes
				add: [ mutex critical: [ self initializedHistories addLast: task value ] ] fork ]
]
