extends Resource
class_name Interaction #Interactive Word



@export var base_bg_color: Color
@export var display_title: String
@export_multiline var text: String
@export var slots: Dictionary = {"slot_1": "#ID69"}
@export var options: Array

"""
Example
{
	"demo.interaction":
		{
		
		"base_bg_color": "#FFFFFF",
		"text": "<slot_1/> world. This is an example of text to be parsed. Here's an example of it continuing on with a linebreak.",
		"slots": {
			"slot_1": "noun_hello"
		},
		"options": [
			{
				"id": "demo.interaction.opt1",
				"links_to": "demo.interaction.2",
				"effect": "add_winter_function",
				"effect_value": 1,
				"conditions_slot": {
					"slot_1": [
						"noun_hello"
					]
				}
			},
			{
				"id": "demo.interaction.opt2",
				"links_to": "demo.interaction.3",
				"effect": "add_winter_function",
				"effect_value": 1,
				"conditions_aspect": {
					"lantern":1
				}
			}
		]
		
		
	}
}

"""
