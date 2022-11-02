Class {
	#name : #WEModelEntity,
	#superclass : #Object,
	#instVars : [
		'ast'
	],
	#category : #'WorkflowEvolution-Model'
}

{ #category : #accessing }
WEModelEntity >> ast [

	^ ast
]

{ #category : #accessing }
WEModelEntity >> ast: anObject [

	ast := anObject
]

{ #category : #accessing }
WEModelEntity >> gtExploreFor: aView [
	<gtView>
	
	 ^ (self ast gtExploreFor: aView) title: 'JSON'
	 
]
