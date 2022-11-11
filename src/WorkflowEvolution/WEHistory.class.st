Class {
	#name : #WEHistory,
	#superclass : #Object,
	#instVars : [
		'location',
		'repo',
		'commitIndices'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEHistory class >> fromLocation: aFileReference [
	^ self new location: aFileReference
]

{ #category : #accessing }
WEHistory >> allCommits [
	"These are all commiyts, not just those to the workflow file"

	^ self mainBranch commits
]

{ #category : #accessing }
WEHistory >> commitIndices [
	commitIndices
		ifNil: [ commitIndices := OrderedCollection new.
			self allCommits
				withIndexDo: [ :commit :index | 
					(commit ancestorIds notEmpty
						and: [ ((commit changesFromCommit: commit parent) collect: [ :f | f path ])
								includes: self docPath ]) ifTrue: [ commitIndices add: index ] ] ].
	^ commitIndices
]

{ #category : #accessing }
WEHistory >> commitIndices1 [

	^ commitIndices
]

{ #category : #accessing }
WEHistory >> commitIndices: anObject [

	commitIndices := anObject
]

{ #category : #accessing }
WEHistory >> docPath [
	"This is the path to the workflow file in any given repo with github actions"

	^ Path from: '.github/workflows/docs.yml'
]

{ #category : #accessing }
WEHistory >> gtRepoFor: aView [
	"<gtView>"
	^ aView forward
		title: 'Repo';
		priority: 10;
		object: [ self repo ];
		view: #gtLiveFor:
]

{ #category : #accessing }
WEHistory >> gtWorkflowDirFor: aView [
	<gtView>
	^ aView forward
		title: 'Workflows';
		priority: 10;
		object: [ self workflowDir ];
		view: #gtItemsFor:
]

{ #category : #initialization }
WEHistory >> initializeRepo [
	repo := IceRepositoryCreator new
			location: location;
			createRepository
]

{ #category : #accessing }
WEHistory >> location [

	^ location
]

{ #category : #accessing }
WEHistory >> location: aFileReference [
	location := aFileReference.
	self initializeRepo
]

{ #category : #accessing }
WEHistory >> mainBranch [
	"NB: this could be called eithe main or master -- fix this later tp search for one, then the other"

	^ repo localBranches detect: [ :b | b name = 'master' ]
]

{ #category : #accessing }
WEHistory >> repo [

	^ repo
]

{ #category : #accessing }
WEHistory >> repo: anObject [

	repo := anObject
]

{ #category : #accessing }
WEHistory >> storeOn: aStream [
	aStream
		nextPutAll: '(';
		nextPutAll: self class name;
		nextPutAll: ' fromLocation: ';
		nextPutAll: self location storeString;
		nextPutAll: ' ) commitIndices: ';
		nextPutAll: self commitIndices storeString
]

{ #category : #accessing }
WEHistory >> workflowCommits [
	^ self allCommits atAll: self commitIndices
]

{ #category : #accessing }
WEHistory >> workflowDir [
	^ repo repositoryDirectory / '.github' / 'workflows'
]
