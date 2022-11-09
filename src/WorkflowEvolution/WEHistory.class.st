Class {
	#name : #WEHistory,
	#superclass : #Object,
	#instVars : [
		'location',
		'repo'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEHistory class >> fromLocation: aFileReference [
	^ self new location: aFileReference
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
WEHistory >> repo [

	^ repo
]

{ #category : #accessing }
WEHistory >> repo: anObject [

	repo := anObject
]

{ #category : #accessing }
WEHistory >> workflowDir [
	^ repo repositoryDirectory / '.github' / 'workflows'
]
