extends Node
class_name IWord
#Why do I have both a resource and a logical node equivalent?



var id: String = "default_word"
var text: String = "default_word"
var bbcode: String
var part_speech: String
var description: String = "default description"
var aspects: Array
var principles: Dictionary
var indef_article: String
var def_article: String
var plural: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
