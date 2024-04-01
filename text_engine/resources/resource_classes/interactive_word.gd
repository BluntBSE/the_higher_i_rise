extends Resource




@export var id: String = "default_word"
@export var text: String = "default_word"
@export var bbcode: String
@export var part_speech: String
@export var description: String
@export var aspects: Array
@export var principles: Dictionary


"""
{"words":
	[
		{
			"id": "noun_hello",
			"word": "Hello",
			"part_speech": "interjection",
			"aspects": [],
			"principles": {"lantern": 1}
		}
	]
}
"""
