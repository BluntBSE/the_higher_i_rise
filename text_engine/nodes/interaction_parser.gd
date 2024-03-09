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
	
	print("Interaction parser fired _ready")
	var moo =  {}.keys()
	active_interaction = load("res://dialogue/chapter_test/test_interaction.tres") #Replace this 
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
		else:
			print("No slot found for: " + str(_word))

func highlight_word_from_content(word):
	#Seemed like a bit much to make its own state, so...	
	var content_node = get_node('interaction_parser/text_content')
	var text = content_node.text
	



	pass


func _on_text_content_meta_hover_started(meta): #Aka when the user hovers over a URL
	#Display popup at mouse location
	print("Entered hover")
	print(meta)
	highlight_word_from_content(meta)
	pass # Replace with function body.


func _on_text_content_meta_hover_ended(meta): #When the user stops hovering over a URL
	#Remove the popup created by the hover method
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
