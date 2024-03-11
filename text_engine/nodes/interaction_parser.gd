extends StatefulControl
class_name InteractionParser


'''
Example:
	
{
	"interactions": [
		{
			"id": "demo.interaction",
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

			]
		}
	]
}

<slot_1/> world. This is an example of text to be parsed. Here's an example of it continuing on with a linebreak.

'''
var state_machine: StateMachine = StateMachine.new()
var _current_text: String = ""
var active_interaction: Interaction = Interaction.new()
var default_interaction_id = "test_interaction" 
var default_interaction = TextTools.getInteractionResource(default_interaction_id)

var selected_word = null
var selected_slot = null
var hovered_word = null
var hovered_slot = null





func updateData(interaction):
	
	pass



func _init():
	#Probably just need an update_interaction state, not text + update text
	state_machine.Add("finished", FinishedTextState.new(self, "arg_to_finished_init"))
	state_machine.Add("load_interaction", LoadInteractionState.new(self, "hello"))
	state_machine.Add("choose_option", ChooseOptionState.new(self, "init choose option state"))
	state_machine.Add("select_word_from_content", SelectWordFromContentState.new(self, "init choose word from content state"))
	state_machine.Add("swap_word", SwapWordState.new(self, "init swap word state"))
	#state_machine.Add("update_interaction", UpdateTextState.new(self,"arg_to_uinteraction_init"))
	#state_machine.Add("update_text", UpdateTextState.new(self, "arg_to_update_init")) 

# Called when the node enters the scene tree for the first time.
func _ready():

	var moo =  {}.keys()
	active_interaction = load("res://content/stories/01_robbing_the_sisterhood/test_interaction.tres") #Replace this 
	state_machine.Change("load_interaction", default_interaction)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.stateUpdate(delta)
	pass

func getSlotKey(_word):
	var slots = active_interaction.slots
	for slot in slots:
		if slots[slot] == _word:
			return str(slot)


#Should hovering be its own state? Seems a touch much
func highlight_word_from_content(word):

	if hovered_slot != null	:

		return
	
	var content_node = get_node('text_content')
	var text = content_node.text
	#Compare the echoed meta to the stored slots.
	#Wrap <slot_1> or whatever in [b] [/b] tags.
	var interaction_text = active_interaction.text

	var slot_key = getSlotKey(word)
	if slot_key == selected_slot:
		return
	var slot_str = "<" + slot_key + "/>" #We're replacing the actual string  '<slot_1/>'.
	var styled_slot = TextEffects.hover.open + slot_str + TextEffects.hover.close #Need to save hover and selection to variables tbh
	var replaced_text = interaction_text.replace(slot_str, styled_slot)
	var new_interaction = active_interaction #Not sure if this is in place or a copy
	new_interaction.text = replaced_text
	hovered_slot = slot_key
	state_machine.Change("load_interaction", new_interaction)
	
func remove_highlight_from_word(word):
	if hovered_slot == null:
		return
	var content_node = get_node("text_content")
	var interaction_text = active_interaction.text
	var slot_key = getSlotKey(word)
	var slot_str = "[b]<" + slot_key + "/>[/b]" #Match the style tags from the highlight function
	var basic_str = "<" + slot_key + "/>"
	var replaced_text = interaction_text.replace(slot_str, basic_str)
	var new_interaction = active_interaction
	new_interaction.text = replaced_text
	hovered_slot = null
	state_machine.Change("load_interaction", new_interaction)
	
	pass
	



	pass


func _on_text_content_meta_hover_started(meta): #Aka when the user hovers over a URL
	#Display popup at mouse location
	highlight_word_from_content(meta)
	pass # Replace with function body.


func _on_text_content_meta_hover_ended(meta): #When the user stops hovering over a URL
	#Remove the popup created by the hover method
	#if selected_slot == null:
	remove_highlight_from_word(meta)
	
	pass # Replace with function body.


func _on_options_content_meta_clicked(meta):
	#get interaction by ID
	var interaction_to_load = TextTools.getInteractionResource(meta)
	state_machine.Change("choose_option", interaction_to_load)
	#change state
	pass # Replace with function body.


func _on_text_content_meta_clicked(meta):
	#Meta should equal the ID&filename of the word being sought.
	#Save the first thing clicked to memory. Perhaps a variable called "first_selected"
	#Still determining whether or not this is the place to save the variable, as words can exist in inventory outside of it.
	#Update the effect on the text to indicate it has beeen selected
	if selected_word == null:
		state_machine.Change("select_word_from_content", meta)
	else:
		state_machine.Change("swap_word", meta)
		pass
	pass # Replace with function body.
