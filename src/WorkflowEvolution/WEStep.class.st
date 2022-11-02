Class {
	#name : #WEStep,
	#superclass : #WEModelEntity,
	#instVars : [
		'properties'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEStep >> addProperties: aproperties [ 
    
    properties := Dictionary new.
    
]

{ #category : #accessing }
WEStep >> initialize [
	properties := Dictionary new.
]

{ #category : #accessing }
WEStep >> properties [

	^ properties
]

{ #category : #accessing }
WEStep >> properties: anObject [

	properties := anObject
]

{ #category : #accessing }
WEStep >> step [

	|step|
	step:= WEStep new.
	step properties: self properties.
	^ step
]
