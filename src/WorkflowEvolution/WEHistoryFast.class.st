Class {
	#name : #WEHistoryFast,
	#superclass : #Object,
	#instVars : [
		'ymlFile',
		'repoPath',
		'repo',
		'ymlFilePath',
		'stickyCommits',
		'stickyGroups'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEHistoryFast class >> fromRepoPath: aPathString forYML: aFilename [
	^ self new repoPath: aPathString ; 
		   ymlFile: aFilename
]

{ #category : #accessing }
WEHistoryFast >> allCommits [
	"These are all commiyts, not just those to the workflow file"

	^ self branch commits
]

{ #category : #accessing }
WEHistoryFast >> branch [
	^ repo localBranches detect: [ :b | b name = 'main' or: [ b name = 'master' ] ]
]

{ #category : #accessing }
WEHistoryFast >> commitsByAuthor [
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
WEHistoryFast >> gtCommitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Commits';
		priority: 30;
		items: [ self workflowCommits ];
		column: 'Author' text: [ :commit | commit author ];
		column: 'Timestamp' text: [ :commit | commit datetime asString ]
		"column: 'Delta'
			text: [ :commit | (commit datetime - commit parent datetime) asString ]"
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
WEHistoryFast >> gtStickyCommitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Sticky Groups';
		priority: 40;
		items: [ self stickyCommits ];
		column: 'Author' text: [ :each | each stickyGroup first commit author ];
		column: 'Start' text: [ :each | each stickyGroup last commit datetime asString ];
		column: 'End' text: [ :each | each stickyGroup first commit datetime asString ];
		column: 'Number of commits' text: [ :each | each stickyGroup size asString ]
]

{ #category : #accessing }
WEHistoryFast >> gtWorkflowDirFor: aView [
	<gtView>
	^ aView forward
		title: 'Workflows';
		priority: 10;
		object: [ self workflowDir ];
		view: #gtItemsFor:
]

{ #category : #accessing }
WEHistoryFast >> initializeRepo [
	repo := IceRepositoryCreator new
			location: self location;
			createRepository
]

{ #category : #accessing }
WEHistoryFast >> initializeStickyGroups [
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
WEHistoryFast >> location [
	^ self repoPath asFileReference
]

{ #category : #accessing }
WEHistoryFast >> repoPath [
	^ repoPath
]

{ #category : #accessing }
WEHistoryFast >> repoPath: aPathString [
	repoPath := aPathString.
	self initializeRepo
]

{ #category : #accessing }
WEHistoryFast >> stickyCommits [
	stickyGroups ifNil: [self initializeStickyGroups].
	^ stickyGroups
]

{ #category : #accessing }
WEHistoryFast >> workflowCommits [
	| workflowCommits commitWalk |
	workflowCommits := OrderedCollection new.

	commitWalk := self branch newCommitWalk.
	commitWalk revwalk
		select: [ :aLGitCommit | aLGitCommit changesFileNamed: self ymlFilePath fullName ]
		thenDo: [ :aLGitCommit | workflowCommits add: (commitWalk commitFrom: aLGitCommit) ].
		
	^ workflowCommits
]

{ #category : #accessing }
WEHistoryFast >> workflowDir [
	^ repo repositoryDirectory / '.github' / 'workflows'
]

{ #category : #accessing }
WEHistoryFast >> ymlFile [
	^ ymlFile
]

{ #category : #accessing }
WEHistoryFast >> ymlFile: aFilename [
	ymlFile := aFilename
]

{ #category : #accessing }
WEHistoryFast >> ymlFilePath [
	"This is the path to the workflow file in any given repo with github actions"

	^ Path from: '.github/workflows/', self ymlFile
]

{ #category : #accessing }
WEHistoryFast >> ymlFilePath: anObject [

	ymlFilePath := anObject
]
