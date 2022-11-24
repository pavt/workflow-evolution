Class {
	#name : #OldWEHistory,
	#superclass : #Object,
	#instVars : [
		'repo',
		'commitIndices',
		'repoPath',
		'ymlFile',
		'stickyGroups'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
OldWEHistory class >> fromLocation: aFileReference [
	^ self new location: aFileReference
]

{ #category : #accessing }
OldWEHistory class >> fromRepoPath: aPathString forYML: aFilename [
	^ self new repoPath: aPathString ; 
		   ymlFile: aFilename
	
	
]

{ #category : #accessing }
OldWEHistory >> allCommits [
	"These are all commiyts, not just those to the workflow file"

	^ self branch commits
]

{ #category : #accessing }
OldWEHistory >> branch [
	"NB: this could be called eithe main or master -- fix this later tp search for one, then the other"

	^ repo localBranches detect: [ :b | b name = 'main' or: [b name = 'master']]
	

]

{ #category : #accessing }
OldWEHistory >> commitIndices [
	"Lazily compute indices of the commits we want if needed"
	commitIndices
		ifNil: [ commitIndices := OrderedCollection new.
			self allCommits
				withIndexDo: [ :commit :index | 
					(commit ancestorIds notEmpty
						and: [ ((commit changesFromCommit: commit parent) collect: [ :f | f path ])
								includes: self ymlFilePath ]) ifTrue: [ commitIndices add: index ] ] ].
	^ commitIndices
]

{ #category : #accessing }
OldWEHistory >> commitIndices: anObject [

	commitIndices := anObject
]

{ #category : #accessing }
OldWEHistory >> commitsByAuthor [
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
	authorCommits add: commits last.
	^ commitsByAuthor
]

{ #category : #accessing }
OldWEHistory >> gtCommitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Commits';
		priority: 30;
		items: [ self workflowCommits ];
		column: 'Author' text: [ :commit | commit author ];
		column: 'Timestamp' text: [ :commit | commit datetime asString ];
		column: 'Delta'
			text: [ :commit | (commit datetime - commit parent datetime) asString ]
		"column: 'Sticky'
			text: [ :commit | 
				| delta |
				delta := commit datetime - commit parent datetime.
				(commit author = commit parent author
					and: [ delta < self maxStickyDuration ])
					ifTrue: [ 'yes' ]
					ifFalse: [ '' ] ]"
]

{ #category : #accessing }
OldWEHistory >> gtStickyCommitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Sticky Commits';
		priority: 40;
		items: [ self stickyCommits ];
		column: 'Author' text: [ :each | each stickyGroup first commit author ];
		column: 'Start' text: [ :each | each stickyGroup last commit datetime asString ];
		column: 'End' text: [ :each | each stickyGroup first commit datetime asString ];
		column: 'Number of commits' text: [ :each | each stickyGroup size asString ]
]

{ #category : #accessing }
OldWEHistory >> gtWorkflowDirFor: aView [
	<gtView>
	^ aView forward
		title: 'Workflows';
		priority: 10;
		object: [ self workflowDir ];
		view: #gtItemsFor:
]

{ #category : #initialization }
OldWEHistory >> initializeRepo [
	repo := IceRepositoryCreator new
			location: self location;
			createRepository
]

{ #category : #accessing }
OldWEHistory >> initializeStickyGroups [
	| stickyCandidate previousAuthor commits candidates |
	previousAuthor := ''.
	candidates := OrderedCollection new.
	stickyCandidate := OrderedCollection new.
	candidates add: stickyCandidate.
	commits := self workflowCommits.
	commits allButLast
		withIndexDo: [ :element :index | 
			| nextElement |
			stickyCandidate add: element.
			nextElement := commits at: index + 1.
			(element author ~= nextElement author
			 "here we are not considering the time diff between 2 commits in the filtering process" 
				"or: [ element datetime - nextElement datetime > self maxStickyDuration ]")
				ifTrue: [ stickyCandidate := OrderedCollection new.
					candidates add: stickyCandidate ] ].
	stickyCandidate add: commits last.
	stickyGroups := (candidates select: [ :each | each size > 1 ])
			collect: [ :each | WEStickyGroup forCommit: each forYML: self ymlFile ]
]

{ #category : #accessing }
OldWEHistory >> location [

	^ self repoPath asFileReference
]

{ #category : #accessing }
OldWEHistory >> maxStickyDuration [
	^ Duration minutes: 30
]

{ #category : #accessing }
OldWEHistory >> repo [

	^ repo
]

{ #category : #accessing }
OldWEHistory >> repo: anObject [

	repo := anObject
]

{ #category : #accessing }
OldWEHistory >> repoPath [

	^ repoPath
]

{ #category : #accessing }
OldWEHistory >> repoPath: aPathString [
	repoPath := aPathString.
	self initializeRepo
]

{ #category : #accessing }
OldWEHistory >> stickyCommits [
	stickyGroups ifNil: [self initializeStickyGroups].
	^ stickyGroups
]

{ #category : #accessing }
OldWEHistory >> storeOn: aStream [
	aStream
		nextPutAll: '(';
		nextPutAll: self class name;
		nextPutAll: ' fromRepoPath: ';
		nextPutAll: self repoPath storeString;
		nextPutAll: ' forYML: ';
		nextPutAll: self ymlFile storeString;
		nextPutAll: ' ) commitIndices: ';
		nextPutAll: self commitIndices storeString
]

{ #category : #accessing }
OldWEHistory >> workflowCommits [
	^ self allCommits atAll: self commitIndices
]

{ #category : #accessing }
OldWEHistory >> workflowDir [
	^ repo repositoryDirectory / '.github' / 'workflows'
]

{ #category : #accessing }
OldWEHistory >> ymlFile [

	^ ymlFile
]

{ #category : #accessing }
OldWEHistory >> ymlFile: aFilename [
	ymlFile := aFilename
]

{ #category : #accessing }
OldWEHistory >> ymlFilePath [
	"This is the path to the workflow file in any given repo with github actions"

	^ Path from: '.github/workflows/', self ymlFile
]
