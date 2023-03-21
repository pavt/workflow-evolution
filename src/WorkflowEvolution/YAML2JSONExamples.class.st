Class {
	#name : #YAML2JSONExamples,
	#superclass : #Object,
	#category : #'WorkflowEvolution-YAML'
}

{ #category : #constant }
YAML2JSONExamples >> builderClass [
	^ YAML2JSON
]

{ #category : #example }
YAML2JSONExamples >> gtoolkitYaml [
	"Generate JSON for the gtoolkit.yaml file."

	<gtExample>
	| json |
	json := self jsonFor: (FileLocator imageDirectory / 'gtoolkit.yaml') contents.
	self assert: (json keys includes: 'verbose').
	^ json
]

{ #category : #processing }
YAML2JSONExamples >> jsonFor: aYamlString [
	^ self builderClass jsonFor: aYamlString
]
