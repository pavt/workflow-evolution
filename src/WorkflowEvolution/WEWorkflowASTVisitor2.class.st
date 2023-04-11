Class {
	#name : #WEWorkflowASTVisitor2,
	#superclass : #YAMLParseNodeVisitor,
	#instVars : [
		'workflow',
		'eventsAST',
		'jobsAST'
	],
	#category : #'WorkflowEvolution-Model2'
}

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitFile: aFile [
	| result |
	result := aFile documents collect: [ :each | each acceptVisitor: self ].
	^ result size = 1 ifTrue: [ result first ] ifFalse: [ result asArray ]
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitList: aList [
	^ (aList items collect: [ :each | each acceptVisitor: self ]) asArray
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitListItem: aListItem [
	^ aListItem value acceptVisitor: self
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitMapping: aMapping [
	"In YAML mappings may have nil values. nil keys should not happen, but the YAMParser sometimes produces them."

	| key value |
	key := aMapping key
			ifNil: [ 'key' , 1000 atRandom asString ]
			ifNotNil: [ aMapping key acceptVisitor: self ].
	value := aMapping value
			ifNil: [ 'nil' ]
			ifNotNil: [ aMapping value acceptVisitor: self ].
	^ key -> value
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitMappingList: aMappingList [
	^ (aMappingList mappings collect: [ :each | each acceptVisitor: self ])
		asDictionary
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitNumber: aNumber [
	"TO DO: asNumber?"

	^ aNumber value value
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitSmaCCError: aSmaCCError [
	^ self visitSmaCCParseNode: aSmaCCError
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitSmaCCParseNode: aSmaCCParseNode [
	self acceptNodes: aSmaCCParseNode sortedChildren.
	^ aSmaCCParseNode
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> visitString: aString [
	^ aString parts first value
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> workflow [
	^ workflow
]

{ #category : #accessing }
WEWorkflowASTVisitor2 >> workflow: anObject [
	workflow := anObject
]
