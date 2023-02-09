Class {
	#name : #WENLP,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#category : #'WorkflowEvolution-NLP'
}

{ #category : #accessing }
WENLP >> bagOfWords: text [
	| a baglist vlist btext siz zarr stext zar vsiz |
	stext := self stopWords: text.
	btext := self vocabBuild: text.
	siz := btext size.
	vlist := stext collect: [ :i | [ :each | each isSeparator ] split: i ].
	vsiz := vlist size.
	baglist := SortedCollection new.
	zarr := OrderedCollection new.
	btext do: [ :b | baglist add: b ].
	vlist
		do: [ :k | 
			zar := baglist deepCopy.
			k do: [ :j | zar add: j ].
			zarr add: zar ].
	a := zarr collect: [ :c | btext collect: [ :e | (c occurrencesOf: e) - 1 ] ].
	^ a
]

{ #category : #accessing }
WENLP >> hammingDistBetween: str and: strr [
	| s1 s2 dist str1 str2 |
	str1 := str asLowercase.
	str2 := strr asLowercase.

	s1 := str1 size.
	s2 := str2 size.
	self assert: s1 equals: s2.
	dist := 0.

	1 to: s1 do: [ :i | (str1 at: i) = (str2 at: i) ifFalse: [ dist := dist + 1 ] ].

	^ dist
]

{ #category : #accessing }
WENLP >> nGramFor: text nSize: n [
	| stword vlist temp arr |
	stword := self stopWords: text.
	vlist := stword collect: [ :i | [ :each | each isSeparator ] split: i ].


	arr := OrderedCollection new.

	vlist
		do: [ :i | 
			temp := OrderedCollection new.
			i
				doWithIndex: [ :j :idx | 
					idx + (n - 1) > i size
						ifFalse: [ temp add: (i copyFrom: idx to: idx + (n - 1)) ] ].
			arr add: temp ].

	^ arr
]

{ #category : #accessing }
WENLP >> stopWords: text [
	| st ftext prtext rtext |
	st := Array
			withAll: #('i' 'me' 'my' 'myself' 'we' 'our' 'ours' 'ourselves' 'you' 'you''re' 'you''ve' 'you''ll' 'you''d' 'your' 'yours' 'yourself' 'yourselves' 'he' 'hey' 'him' 'his' 'himself' 'she' 'she''s' 'her' 'hers' 'herself' 'it' 'it''s' 'its' 'itself' 'they' 'them' 'their' 'theirs' 'themselves' 'what' 'which' 'who' 'whom' 'this' 'that' 'that''ll' 'these' 'those' 'am' 'is' 'are' 'was' 'were' 'be' 'been' 'being' 'have' 'has' 'had' 'having' 'do' 'does' 'did' 'doing' 'a' 'an' 'the' 'and' 'but' 'if' 'or' 'because' 'as' 'until' 'while' 'of' 'at' 'by' 'for' 'with' 'about' 'between' 'into' 'through' 'during' 'before' 'after' 'to' 'from' 'up' 'down' 'in' 'out' 'on' 'off' 'over' 'under' 'again' 'further' 'then' 'once' 'here' 'there' 'when' 'where' 'why' 'how' 'all' 'any' 'both' 'each' 'few' 'more' 'most' 'other' 'some' 'such' 'nor' 'only' 'own' 'same' 'so' 'than' 'too' 'very' 's' 't' 'can' 'will' 'just' 'should' 'should''ve' 'now' 'd' 'll' 'm' 'o' 're' 've' 'y' 'ain' 'aren' 'aren''t' 'couldn' 'couldn''t' 'didn' 'didn''t' 'doesn' 'doesn''t' 'hadn' 'hadn''t' 'hasn' 'hasn''t' 'haven' 'haven''t' 'isn' 'isn''t' 'ma' 'mightn' 'mightn''t' 'mustn' 'mustn''t' 'needn' 'needn''t' 'shan' 'shan''t' 'shouldn' 'shouldn''t' 'wasn' 'wasn''t' 'weren' 'weren''t' 'won' 'won''t' 'wouldn' 'wouldn''t' '.' ',').
	prtext := text collect: [ :i | i asLowercase ].
	rtext := prtext collect: [ :j | [ :each | each isSeparator ] split: j ].
	ftext := rtext collect: [ :k | k reject: [ :each | st includes: each ] ].
	^ ftext
		collect: [ :l | String streamContents: [ :stream | l asStringOn: stream delimiter: ' ' ] ]
]

{ #category : #accessing }
WENLP >> tfIdf: text [
	| idf tfidf cnts ttext stext tf vlist vocab cnt t |
	stext := self stopWords: text.
	vocab := self vocabBuild: text.
	vlist := stext collect: [ :i | [ :each | each isSeparator ] split: i ].
	ttext := self bagOfWords: text.
	tf := OrderedCollection new.
	vlist
		doWithIndex: [ :i :idx | ttext doWithIndex: [ :j :idb | idb == idx ifTrue: [ tf add: j / i size ] ] ].
	cnt := OrderedCollection new.
	vocab do: [ :i | vlist do: [ :j | (j includes: i) ifTrue: [ cnt add: i ] ] ].	"2.303"
	cnts := vocab collect: [ :i | cnt occurrencesOf: i ].
	idf := OrderedCollection new.
	vocab doWithIndex: [ :j :idx | idf add: (text size / (cnts at: idx)) ln ].
	tfidf := OrderedCollection new.
	tf
		do: [ :j | 
			t := OrderedCollection new.
			idf doWithIndex: [ :i :idx | t add: (j at: idx) * i ].
			tfidf add: t ].
	^ tfidf
]

{ #category : #accessing }
WENLP >> vocabBuild: text [
	| stword vlist aset |
	stword := self stopWords: text.
	vlist := stword collect: [ :i | [ :each | each isSeparator ] split: i ].
	aset := Set new.
	vlist do: [ :j | j collect: [ :k | aset add: k ] ].
	^ aset sorted
]
