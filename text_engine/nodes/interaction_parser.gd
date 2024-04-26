extends StatefulControl
class_name InteractionParser

var state_machine: StateMachine2 = StateMachine2.new()
#var _current_text: String = ""
var active_interaction: Interaction = Interaction.new()
var default_interaction_id = "obscure_alley_1"
var default_interaction#Must be loaded in after initialziation



var can_hover = true
var selected_word = null
var selected_slot = null
var hovered_word = null
var hovered_slot = null
var selected_memory = null

func _on_select_memory(memory):
	print("Parser says, on_select_memory fired")
	var word_id = memory.word_id
	selected_memory = word_id
	

	

func updateData(_interaction):
	
	pass



func _init():
	
	#Probably just need an update_interaction state, not text + update text
	state_machine.Add("finished", FinishedTextState.new(self, "arg_to_finished_init"))
	state_machine.Add("load_interaction", LoadInteractionState.new(self, "init load interaction state"))
	state_machine.Add("choose_option", ChooseOptionState.new(self, "init choose option state"))
	state_machine.Add("select_word_from_content", SelectWordFromContentState.new(self, "init choose word from content state"))
	state_machine.Add("swap_word", SwapWordState.new(self, "init swap word state"))
	state_machine.Add("handle_wound", HandleWoundState.new(self, "init handle wound state"))
	state_machine.Add("swap_memory", SwapMemoryState.new(self, "init swap memory state"))
	#state_machine.Add("fade_in", FadeInTextState.new(self, "init fade out text state"))
	#state_machine.Add("fade_out", FadeOutTextState.new(self, "init fade out text state"))
	state_machine.Add("load_option", LoadOptionState.new(self, "init load option state"))
# Called when the node enters the scene tree for the first time.
func _ready():
	default_interaction = TextTools.getInteractionResource(default_interaction_id)
	#state_machine.Change("debug", null)
	state_machine.Change("load_interaction", default_interaction)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.stateUpdate(delta)


func getSlotKey(_word):
	var slots = active_interaction.slots
	for slot in slots:
		if slots[slot] == _word:
			return str(slot)


#Should hovering be its own state? Seems a touch much
func highlight_word_from_content(word):
	if hovered_slot != null	:
		return
	
	if can_hover == false:
		return
	
	var content_node = get_node('interaction_fg/text_content')
	var text = content_node.text
	var interaction_text = active_interaction.text

	var slot_key = getSlotKey(word)
	if slot_key == null:
		return
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
	#var content_node = get_node("interaction_fg/text_content")
	var interaction_text = active_interaction.text
	var slot_key = getSlotKey(word)
	var slot_str = "[b]<" + slot_key + "/>[/b]" #Match the style tags from the highlight function
	var basic_str = "<" + slot_key + "/>"
	var replaced_text = interaction_text.replace(slot_str, basic_str)
	var new_interaction = active_interaction
	new_interaction.text = replaced_text
	hovered_slot = null
	state_machine.Change("load_interaction", new_interaction)
	


func _on_text_content_meta_hover_started(meta): #Aka when the user hovers over a URL
	#Display popup at mouse location
	highlight_word_from_content(meta)



func _on_text_content_meta_hover_ended(meta): #When the user stops hovering over a URL
	#Remove the popup created by the hover method
	remove_highlight_from_word(meta)
	


func _on_options_content_meta_clicked(meta):
	print("Parser attempting to fire options")
	state_machine.Change("choose_option", meta)



func _on_text_content_meta_clicked(meta):
	#Save the first thing clicked to memory. Perhaps a variable called "first_selected"
	#Still determining whether or not this is the place to save the variable, as words can exist in inventory outside of it.
	#Update the effect on the text to indicate it has beeen selected
	
	
	var is_wound = false
	if selected_word == null and selected_memory == null:
		
		#CHECK IF THE WORD IN THE META IS A SLOT OR A WOUND, THEN ACT ACCORDINGLY
		#If the meta == a word in any wound key, process it as a wound.
		if active_interaction.wounds.size() > 0:
			var all_wounds = active_interaction.wounds.keys()
			for wound in all_wounds:
				if active_interaction.wounds[wound].word_id == meta:
					print("Yes verily I do believe this to be a wound")
					is_wound = true
					break
	if is_wound == false:
		#Big title is happening because of the select_word logic I bet.
		print("Select word from content about to fire")			
		state_machine.Change("select_word_from_content", meta)
	if is_wound == true:
		print("Handle wound about to fire")
		state_machine.Change("handle_wound", meta)
	if selected_word != null and selected_memory == null and is_wound == false:
		print("swap word about to fire")
		state_machine.Change("swap_word", meta)
	if selected_word == null and selected_memory != null and is_wound == false:
		print("swap memory about to fire")
		var args = [meta, selected_memory]
		#This listens for clicks in the body of the parser. For clicks on the memory itself, refer to the memory object.
		state_machine.Change("swap_memory", args)
	pass # Replace with function body.
