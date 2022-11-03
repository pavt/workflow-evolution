Class {
	#name : #WEStep,
	#superclass : #WEModelEntity,
	#instVars : [
		'properties'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEStep >> addProperties: propertiess [
    
    self properties add: propertiess
    
]

{ #category : #accessing }
WEStep >> initialize [
	properties := Dictionary new.
]

{ #category : #accessing }
WEStep >> properties [
	properties := Dictionary new.
	self step ast members
		do: [ :propAST | properties at: propAST name value withoutQuoting put: propAST value value value ].

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

{ #category : #accessing }
WEStep >> step: anObject [

	step := anObject
]
