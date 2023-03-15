Class {
	#name : #WEDataset,
	#superclass : #Object,
	#category : #'WorkflowEvolution-Data'
}

{ #category : #accessing }
WEDataset class >> fromHistories: aCollectionOfHistories [
	| data histories |
	histories := aCollectionOfHistories. 
	data := (histories histories
			collect: [ :each | 
				| repoPath |
				repoPath := each repoPath.
				each workflowCommits
					collect: [ :each2 | 
						{repoPath.
							each2 commit id.
							each2 commit comment} ] ]) flatten.
	^ data
]

{ #category : #accessing }
WEDataset >> gtDatasetFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Commits data';
		priority: 20;
		items: [ self histories ];
		column: 'Repo' text: [ :each | each repoPath ]
		"column: 'YML file' text: [ :each | each ymlFile ];
		column: 'Size' text: [ :each | each workflowCommits size ]"
]

{ #category : #accessing }
WEDataset >> histories [
	^ histories
]
