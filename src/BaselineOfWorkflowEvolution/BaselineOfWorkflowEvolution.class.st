Class {
	#name : #BaselineOfWorkflowEvolution,
	#superclass : #BaselineOf,
	#category : #BaselineOfWorkflowEvolution
}

{ #category : #accessing }
BaselineOfWorkflowEvolution class >> loadLepiter [
	| currentProperties |
	currentProperties := LeDatabasesRegistry defaultLogicalDatabase properties.
	currentProperties
		addRegisteredDirectory: FileLocator imageDirectory / 'pharo-local' / 'iceberg' / 'pavt'
				/ 'workflow-evolution' / 'lepiter'.
	LeDatabasesRegistry default defaultLogicalDatabase reload
]

{ #category : #accessing }
BaselineOfWorkflowEvolution >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'WorkflowEvolution' ]
]
