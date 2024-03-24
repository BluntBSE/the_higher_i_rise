extends Resource
class_name Interaction #Interactive Word



@export var base_bg_color: Color
@export var display_title: String
@export_multiline var text: String
@export var slots: Dictionary = {"slot_1": "#ID69"}
@export var options: Array
@export var wounds: Dictionary = {}
@export var portraits: Array = [] #array of character_ids

"""SLOTS
{
	"slot_1": "adj_smug",
	"slot_2": "adj_dead",
	und so weiter
}
"""

"""
OPTIONS:
{
	"conditions_word":{
		"slot_1":{"specific_id":"adj_smug"} #There could be other conditions
		"slot_2":{"aspects": {"grail":2, "greeting":1}}
		}
	"conditions_aspect": {"grail":2}
	"functions":[['print_string,['strings','to','print']]], #Function/arg pairs
	"hint": "Hint string",
	"hint_tooltip": "Tooltip string",
	"id"" "interaction_id_1",
	"links_to":"interaction_id_2",
	"text": "text_string"
}
	
"""

"""
WOUNDS
{
	"wound_1":{"word_id": "noun-wound", "wound_link": "interaction_id"}
}

"""

"""PORTRAITS
#String IDS that match resources stored in res://content/catalogs/characters/
["bechet","arun_peel"]
"""
