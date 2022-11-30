Class {
	#name : #OldWEModelEntity,
	#superclass : #Object,
	#instVars : [
		'ast'
	],
	#category : #'WorkflowEvolution-Obsolete'
}

{ #category : #accessing }
OldWEModelEntity >> ast [

	^ ast
]

{ #category : #accessing }
OldWEModelEntity >> ast: anObject [

	ast := anObject
]

{ #category : #accessing }
OldWEModelEntity >> gtExploreFor: aView [
	<gtView>
	
	 ^ (self ast gtExploreFor: aView) title: 'JSON'
	 
]
