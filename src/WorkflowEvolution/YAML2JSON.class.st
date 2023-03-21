"
I build workflows from GitHub action YAML files.
I rely on the installation of `yq`, a tool that can manipulate YAMl files and generate JSON.

See the [yq github repo](https://github.com/mikefarah/yq) and the [yq documentation](https://mikefarah.gitbook.io/yq/).
"
Class {
	#name : #YAML2JSON,
	#superclass : #Object,
	#category : #'WorkflowEvolution-YAML'
}

{ #category : #processing }
YAML2JSON class >> jsonFor: aYamlString [
	| process |
	"Isn't valid on Windows"
	OSPlatform current isWindows ifTrue: [ ^ self ].

	process := GtSubprocessWithInMemoryOutput command: 'yq' arguments: {'-o=json'}.
	process runAndSignal.

	process stdinStream
		nextPutAll: aYamlString;
		close.

	process wait.

	^ STON fromString: process stdout
]

{ #category : #processing }
YAML2JSON class >> jsonForFile: aYamlFile [
	^ self jsonFor: aYamlFile contents
]
