Class {
	#name : #WEJob2,
	#superclass : #WENamedEntity2,
	#instVars : [
		'steps'
	],
	#category : #'WorkflowEvolution-Model2'
}

{ #category : #accessing }
WEJob2 >> data: aDictionary [
	super data: aDictionary.
	self initializeSteps.
]

{ #category : #accessing }
WEJob2 >> gtStepsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Steps';
		priority: 30;
		items: [ self steps ];
		column: 'Step' text: [ :step | step ];
		column: 'with' text: [ :step | step with asString ];
		column: 'uses' text: [ :step | step uses asString ];
		column: 'name' text: [ :step | step name asString ]
]

{ #category : #accessing }
WEJob2 >> initializeSteps [
	steps := (data at: 'steps' ifAbsent: [ Dictionary new ])
			collect: [ :dict | WEStep new data: dict ]
]

{ #category : #accessing }
WEJob2 >> steps [
	^ steps
]
