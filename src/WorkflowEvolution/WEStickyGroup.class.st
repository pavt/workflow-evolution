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
WEStickyGroup class >> forFileCommit: aFileCommitCollection [
	^ self new
		stickyGroup: aFileCommitCollection;
		ymlFile: aFileCommitCollection first file
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
		items: [ self stickyGroup reversed ];
		
		column: 'Index' 
			text: [ :eachItem :eachIndex | 
				eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Author' text: [ :each | each commit author ] width: 100;
		
		column: 'Date time' text: [ :each | each commit datetime asString ];
		column: 'Duration'
			text: [ :each | 
				each hasPreviousFileCommit
					ifTrue: [ ( each commit datetime - each previousFileCommit commit datetime ) abs asString ]
					ifFalse: [ 'na' ] ] width: 90;
		column: 'Comment' text: [ :each | each commit comment ];
		column: 'Category' text: [:each | each category ] width: 300
		
		
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
