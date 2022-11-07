Class {
	#name : #WEModelEntity,
	#superclass : #Object,
	#instVars : [
		'data'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEModelEntity >> data: dictionary [ 

	data:= dictionary
]

{ #category : #accessing }
WEModelEntity >> gtJSONFor: aView [
	<gtView>
	^ aView forward
		title: 'JSON data';
		priority: 10;
		object: [ data ];
		view: #gtItemsFor:
]
