Class {
	#name : #WEModelEntity,
	#superclass : #Object,
	#instVars : [
		'data',
		'name'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEModelEntity >> data: dictionary [ 

	data:= dictionary ifNil: [Dictionary new]
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

{ #category : #accessing }
WEModelEntity >> name [

	^ name
]

{ #category : #accessing }
WEModelEntity >> name: aString [

	name:= aString
]

{ #category : #accessing }
WEModelEntity >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '(', self name,')'
]
