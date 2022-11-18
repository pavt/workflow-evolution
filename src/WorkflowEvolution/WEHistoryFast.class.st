Class {
	#name : #WEHistoryFast,
	#superclass : #Object,
	#instVars : [
		'ymlFile',
		'repoPath',
		'repo'
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
WEHistoryFast >> initializeRepo [
	repo := IceRepositoryCreator new
			location: self location;
			createRepository
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
WEHistoryFast >> ymlFile [
	^ ymlFile
]

{ #category : #accessing }
WEHistoryFast >> ymlFile: aFilename [
	ymlFile := aFilename
]
