Class {
	#name : #WEHistory,
	#superclass : #Object,
	#instVars : [
		'repo',
		'commitIndices',
		'repoPath'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEHistory class >> fromLocation: aFileReference [
	^ self new location: aFileReference
]

{ #category : #accessing }
WEHistory class >> fromRepoPath: aPathString [
	^ self new repoPath: aPathString
]

{ #category : #accessing }
WEHistory >> allCommits [
	"These are all commiyts, not just those to the workflow file"

	^ self mainBranch commits
]

{ #category : #accessing }
WEHistory >> commitIndices [
	"Lazily compute indices of the commits we want if needed"
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
WEHistory >> commitIndices: anObject [

	commitIndices := anObject
]

{ #category : #accessing }
WEHistory >> commitsByAuthor [
	| commitsByAuthor authorCommits previousAuthor commits |
	previousAuthor := ''.
	commitsByAuthor := OrderedCollection new.
	authorCommits := OrderedCollection new.
	commitsByAuthor add: authorCommits.
	commits := self workflowCommits.
	commits allButLast
		withIndexDo: [ :element :index | 
			authorCommits add: element.
			element author = (commits at: index + 1) author
				ifFalse: [ authorCommits := OrderedCollection new.
					commitsByAuthor add: authorCommits ] ].
	authorCommits add: element.
	^ commitsByAuthor
]

{ #category : #accessing }
WEHistory >> docPath [
	"This is the path to the workflow file in any given repo with github actions"

	^ Path from: '.github/workflows/docs.yml'
]

{ #category : #accessing }
WEHistory >> gtCommitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Commits';
		priority: 30;
		items: [ self workflowCommits ];
		column: 'Author' text: [ :commit | commit author ];
		column: 'Timestamp' text: [ :commit | commit datetime asString ];
		column: 'Delta'
			text: [ :commit | (commit datetime - commit parent datetime) asString ];
		column: 'Sticky'
			text: [ :commit | 
				| delta |
				delta := commit datetime - commit parent datetime.
				(commit author = commit parent author
					and: [ delta < self maxStickyDuration ])
					ifTrue: [ 'yes' ]
					ifFalse: [ '' ] ]
]

{ #category : #accessing }
WEHistory >> gtRawCommitsFor: aView [
	"<gtView>"
	^ aView forward
		title: 'Raw Commits';
		priority: 20;
		object: [ self workflowCommits ];
		view: #gtItemsFor:
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
			location: self location;
			createRepository
]

{ #category : #accessing }
WEHistory >> location [

	^ self repoPath asFileReference
]

{ #category : #accessing }
WEHistory >> mainBranch [
	"NB: this could be called eithe main or master -- fix this later tp search for one, then the other"

	^ repo localBranches detect: [ :b | b name = 'master' ]
]

{ #category : #accessing }
WEHistory >> maxStickyDuration [
	^ Duration minutes: 3
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
WEHistory >> repoPath [

	^ repoPath
]

{ #category : #accessing }
WEHistory >> repoPath: aPathString [
	repoPath := aPathString.
	self initializeRepo
]

{ #category : #accessing }
WEHistory >> storeOn: aStream [
	aStream
		nextPutAll: '(';
		nextPutAll: self class name;
		nextPutAll: ' fromRepoPath: ';
		nextPutAll: self repoPath storeString;
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
