Class {
	#name : #OldWEJob,
	#superclass : #OldWEModelEntity,
	#instVars : [
		'steps',
		'runner',
		'name'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
OldWEJob >> addRunner: aRunner [
	self runner add: aRunner
]

{ #category : #accessing }
OldWEJob >> addStep: aStep [
	self steps add: aStep
]

{ #category : #accessing }
OldWEJob >> gtStepsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Steps';
		priority: 40;
		items: [ self steps ];
		column: 'Steps' text: [ :step | step   ]
]

{ #category : #accessing }
OldWEJob >> initialize [
	steps := OrderedCollection new
]

{ #category : #accessing }
OldWEJob >> job [

	|job|
	job:= OldWEJob new.
	job name: self name.
	^ job
]

{ #category : #accessing }
OldWEJob >> name [

	^ name
]

{ #category : #accessing }
OldWEJob >> name: anObject [

	name := anObject
]

{ #category : #accessing }
OldWEJob >> runner [

	^ runner
]

{ #category : #accessing }
OldWEJob >> runner: aString [

	runner := aString
]

{ #category : #accessing }
OldWEJob >> steps [

	^ steps
]

{ #category : #accessing }
OldWEJob >> steps: anObject [

	steps := anObject
]
