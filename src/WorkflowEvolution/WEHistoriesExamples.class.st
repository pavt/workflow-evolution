Class {
	#name : #WEHistoriesExamples,
	#superclass : #Object,
	#category : #'WorkflowEvolution-Examples'
}

{ #category : #accessing }
WEHistoriesExamples >> historiesExample [
	<gtExample>
	| histories |
	
	histories := WEHistories fromReposPath: '../repositories'.
	self assert: (histories histories size) equals: 307.
	
	^ histories
]
