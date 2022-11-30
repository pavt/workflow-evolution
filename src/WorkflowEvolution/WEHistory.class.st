Class {
	#name : #WEHistory,
	#superclass : #Object,
	#instVars : [
		'ymlFile',
		'repoPath',
		'repo',
		'ymlFilePath',
		'stickyCommits',
		'stickyGroups',
		'workflowCommits'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEHistory class >> fromRepoPath: aPathString forYML: aFilename [
	^ self new repoPath: aPathString ; 
		   ymlFile: aFilename
]

{ #category : #accessing }
WEHistory class >> fromReposPath: aPathString [ 

| repoPaths histories files |
	repoPaths := aPathString asFileReference children collect: #gtDisplayString .
histories := OrderedCollection new.
repoPaths
	do: [ :repoPath | 
		files := (repoPath asFileReference / '.github' / 'workflows'
				allChildrenMatching: '*.yml') collect: #basename.
		histories
			addAll: (files collect: [ :file | WEHistory fromRepoPath: repoPath forYML: file ]) ].

^histories
]

{ #category : #accessing }
WEHistory >> allCommits [
	"These are all commiyts, not just those to the workflow file"

	^ self branch commits
]

{ #category : #accessing }
WEHistory >> branch [
	^ repo localBranches detect: [ :b | b name = 'main' or: [ b name = 'master' ] ]
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
	authorCommits add: commits last.
	^ commitsByAuthor
]

{ #category : #accessing }
WEHistory >> gtCommitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Commits';
		priority: 30;
		items: [ self workflowCommits ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Author' text: [ :commit | commit commit author ];
		column: 'Timestamp' text: [ :commit | commit commit datetime asString ];
		column: 'Delta'
			text: [ :commit | 
				commit hasPreviousFileCommit
					ifTrue: [ (commit commit datetime - commit previousFileCommit commit datetime) asString ]
					ifFalse: [ 'na' ] ]
]

{ #category : #accessing }
WEHistory >> gtStickyCommitsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Sticky Groups';
		priority: 70;
		items: [ self stickyCommits ];
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Author' text: [ :each | each stickyGroup first commit author ];
		column: 'Start' text: [ :each | each stickyGroup last commit datetime asString ];
		column: 'End' text: [ :each | each stickyGroup first commit datetime asString ];
		column: 'Number of commits' text: [ :each | each stickyGroup size asString ]
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

{ #category : #accessing }
WEHistory >> initializeRepo [
	repo := IceRepositoryCreator new
			location: self location;
			createRepository
]

{ #category : #accessing }
WEHistory >> initializeStickyGroups [
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
			(element commit author ~= nextElement commit author
			 "here we are considering the time diff between 2 commits in the filtering process" 
				"or: [ element datetime - nextElement datetime > self maxStickyDuration ]")
				ifTrue: [ stickyCandidate := OrderedCollection new.
					candidates add: stickyCandidate ] ].
	stickyCandidate add: commits last.
	stickyGroups := (candidates select: [ :each | each size > 1 ])
			collect: [ :each | WEStickyGroup forFileCommit: each ]
]

{ #category : #accessing }
WEHistory >> initializeWorkflowCommits [
	| commitWalk thisCommit lastCommit |
	workflowCommits := OrderedCollection new.
	commitWalk := self branch newCommitWalk.
	commitWalk revwalk
		select: [ :aLGitCommit | aLGitCommit changesFileNamed: self ymlFilePath fullName ]
		thenDo: [ :aLGitCommit | 
			thisCommit := WEFileCommit new
					commit: (commitWalk commitFrom: aLGitCommit);
					file: self ymlFile.
			workflowCommits add: thisCommit.
			lastCommit ifNotNil: [ lastCommit previousFileCommit: thisCommit ].
			lastCommit := thisCommit ]
]

{ #category : #accessing }
WEHistory >> location [
	^ self repoPath asFileReference
]

{ #category : #accessing }
WEHistory >> maxStickyDuration [
	"max duration is 20 minutes"
	^ Duration minutes: 20
]

{ #category : #accessing }
WEHistory >> printOn: aStream [
	 
		
	aStream
		nextPutAll: self className;
		nextPutAll: ' REPO: ';
		nextPutAll: self repoPath  ;
		nextPutAll: ' YML: ';
		nextPutAll: self ymlFile 
		
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
WEHistory >> stickyCommits [
	stickyGroups ifNil: [self initializeStickyGroups].
	^ stickyGroups
]

{ #category : #accessing }
WEHistory >> storeOn: aStream [
	
	aStream
		nextPutAll: self className;
		nextPutAll: ' fromRepoPath: ';
		nextPutAll: self repoPath storeString;
		nextPutAll: ' forYML: ';
		nextPutAll: self ymlFile storeString
		
]

{ #category : #accessing }
WEHistory >> workflowCommits [
	workflowCommits ifNil: [ self initializeWorkflowCommits ].
	^ workflowCommits
]

{ #category : #accessing }
WEHistory >> workflowDir [
	^ repo repositoryDirectory / '.github' / 'workflows'
]

{ #category : #accessing }
WEHistory >> ymlFile [
	^ ymlFile
]

{ #category : #accessing }
WEHistory >> ymlFile: aFilename [
	ymlFile := aFilename
]

{ #category : #accessing }
WEHistory >> ymlFilePath [
	"This is the path to the workflow file in any given repo with github actions"

	^ Path from: '.github/workflows/', self ymlFile
]

{ #category : #accessing }
WEHistory >> ymlFilePath: anObject [

	ymlFilePath := anObject
]
