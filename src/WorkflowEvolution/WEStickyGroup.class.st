Class {
	#name : #WEStickyGroup,
	#superclass : #Object,
	#instVars : [
		'stickyGroup',
		'ymlFile'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEStickyGroup class >> forCommit: anIceCommitCollection forYML: aFilename [
	^ self new
		stickyGroup: (anIceCommitCollection
				collect: [ :commit | 
					WEFileCommit new
						commit: commit;
						file: aFilename ]);
		ymlFile: aFilename
]

{ #category : #accessing }
WEStickyGroup >> author [
	^ self stickyGroup first commit author
]

{ #category : #accessing }
WEStickyGroup >> gtWEStickyFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Commits';
		priority: 10;
		items: [ self stickyGroup ];
		column: 'Author' text: [ :each | each commit author ];
		column: 'Date time' text: [ :each | each commit datetime asString ];
		column: 'Duration' text: [ :each | (each commit datetime - each commit parent datetime) asString ];
		column: 'Comment' text: [ :each | each commit comment ]
]

{ #category : #accessing }
WEStickyGroup >> size [
	^ self stickyGroup size
]

{ #category : #accessing }
WEStickyGroup >> stickyGroup [

	^ stickyGroup
]

{ #category : #accessing }
WEStickyGroup >> stickyGroup: each [
	stickyGroup := each
]

{ #category : #accessing }
WEStickyGroup >> ymlFile [

	^ ymlFile
]

{ #category : #accessing }
WEStickyGroup >> ymlFile: aFilename [
	ymlFile := aFilename
]
