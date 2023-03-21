Extension { #name : #GtHome }

{ #category : #'*WorkflowEvolution' }
GtHome >> workflowEvolutionSection [
	<gtHomeSection>
	^ GtHomeStartPageSection new 
		title: 'Workflow Evolution';
		description: 'The Workflow Evolution project';
		databaseName: 'pavt/workflow-evolution/lepiter';
		startPageName: 'Overview of the Workflow Evolution Project';
		priority: 8
]
