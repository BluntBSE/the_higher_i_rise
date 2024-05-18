extends Node
class_name TextTools

static func getResourceFromDirectory(directory: String, file_name: String) -> String:
	#TODO: The problem is DirAccess here?
	
	var dir = DirAccess.open(directory)
	var file_path = ""

	if dir:
		dir.list_dir_begin()
		var current_file = dir.get_next()

		while current_file != "":
			if dir.current_is_dir():
				var next_dir = directory + "/" + current_file
				file_path = getResourceFromDirectory(next_dir, file_name)
				if file_path != "":
					break  # Found the file, no need to continue
			else:
				var name_only = current_file.split(".")[0]
				if name_only == file_name:
					file_path = directory + "/" + current_file
					#Check and see if it ends in .remap
					#TODO: Maybe this is terrible?
					#Should I preload ALL my content in advance? That seems bad, but
					#This also feels hacky.
					if file_path.ends_with(".remap"):
						file_path = file_path.replace(".remap","")
					if file_path.ends_with(".import"):
						file_path = file_path.replace(".import","")
		
					break  # Found the file, no need to continue

			current_file = dir.get_next()


	return file_path


static func getSlotKey(word, reference): #reference usually points to the interaction parser node
	var slots = reference.active_interaction.slots
	for slot in slots:
		if slots[slot] == word:
			return str(slot)

	
static func getInteractionResource(id: String):
	var story_dir = "res://content/stories"
	var file = getResourceFromDirectory(story_dir, id)
	var resource = load(file) #Duplicate()?
	return resource
	

static func getWordResource(id: String):
	var catalog_dir = "res://content/catalogs/IWords/"
	var file = getResourceFromDirectory(catalog_dir, id)
	var word = IWord.new() #Is this part really necessary? This creates a logical node equivalent that we add to the tree.
	#I think there was a good reason for creating these nodes, but now I can't recall it.
	#TODO: Consider loading all this from resource. That'll require changes elsewhere.
	var resource = load(file)
	if !resource:
		push_error("No resource found!")
		return null
	word.id = resource.id
	word.text = resource.text
	word.bbcode = resource.bbcode
	word.part_speech = resource.part_speech
	word.aspects = resource.aspects
	word.principles = resource.principles
	word.description = resource.description
	word.indef_article = resource.indef_article
	word.def_article = resource.def_article
	return word
	

static func determineGreatestPrinciple(principles:Dictionary):
	var greatest_val = 0
	var greatest_principle = "none"
	for principle in principles.keys():
		if principles[principle] > greatest_val:
			greatest_val = principles[principle]
			greatest_principle = str(principle)
	return greatest_principle
	
static func sortPrinciples(principles:Dictionary):
	var keys = principles.keys()
	var comparator = func _compare_values(a, b):
		if principles[a] >= principles[b]:
			return true
		else:
			return false

	keys.sort_custom(comparator)
	return keys
			
	
	
static func applyWound(wound: IWord):
	var new_word = IWord.new()
	new_word = wound #New instance allows us to pass it to the apply styling function with no issues. I hope.
	var text = ""
	text += "[shake rate=40.0 level=30 connected=1]"
	text += wound.text
	text += "[/shake]"
	new_word.text = text
	return new_word
		

static func applyStyling(word: IWord): #"Styling" is a misnomer since this also determines the URL link. Better name?
	var principles = (word.principles)
	#Get all principle integers
	#Find out which is the greatest.
	#Apply the correct color.
	var text = ""
	var principle_string = str(principles)
	var greatest_principle = determineGreatestPrinciple(principles)
	#Consider putting hover stuff in here. Currently it's not. Not sure if it's better outside or in.
	
	

	
	
	text += "[hint="+principle_string+"]"
	#text += "[u]"
	text += "[url=" + word.id + "]"
	
	if greatest_principle != "none":
		#text += "[font_size=32]"
		text += "[outline_size=4]"
		text += "[outline_color=" + "black" + "]"
		text += "[color=" + Principles[greatest_principle].color + "]"
		text += word.text
		text += "[/color]"
		text += "[/outline_color]"
		text += "[/outline_size]"
		#text += "[/font_size]"
		
	text += "[/url]"
	#text += "[/u]"
	text += "[/hint]"
		
	return text





static func parseText(input_string: String, interaction: Interaction):
	#Wherever this function encounters a flag like <slot_1>, it will replace it with the word that corresponds to that slot.
	#This word is stored in the _slots dictionary of the interaction, and is retrieved by the "slot_1", "slot_2", etc. keys.
	#This function will also handle any other flags that we might want to use in the future.
	#For example, we might want to use a flag like <player_name> to refer to the player's name, or /n for a newline.

	var text = input_string
	#First, we'll replace the slots
	if interaction.slots.has("slot_1"):
		for slot in interaction.slots:
			var word = getWordResource(interaction.slots[slot])
			if !word:
				push_error("No word found!")
				return "WORD NOT FOUND"
			var word_str = applyStyling(word)
			#Here is where we would add anything to modify it to be a sentence, such as capitalization.
			if text.contains("<" + slot + "/ia>"):
				var ia_replace = "<" + slot + "/ia>"
				print(ia_replace)
				text = text.replace(ia_replace, word.indef_article)
			if text.contains("<" + slot + "/ia>"):
				var ia_replace = "<" + slot + "/da>"
				print(ia_replace)
				text = text.replace(ia_replace, word.def_article)
			text = text.replace("<" + slot + "/>", word_str)
		
	#SPEECH, THE SWORD
	if interaction.get("wounds").is_empty() == false:
		for wound in interaction.wounds:
			var wound_word = getWordResource(interaction.wounds[wound].word_id)
			if !wound_word:
				print("No wound found!")
			var wound_IWord = applyWound(wound_word)
			var word_text = applyStyling(wound_IWord)
			#Currently I like wounds more without the underlines	
			text = text.replace( "<" + wound + "/>", word_text)
	
	
		


	return text
# Called when the node enters the scene tree for the first time.

static func parseOptions(_reference, interaction: Interaction):
	var glory = _reference.get_tree().root.get_node("the_glory")
	if !interaction:
		push_error("null interaction in parseOptions")
		return null 
	#Clear options before updating them
	var output_container = _reference.find_child("options_container")
	for child in output_container.get_children():
		child.queue_free()
		
	#TODO: We repeat ourselves a lot in this section. Fix this.
	for option in interaction.options:
		
		if option.has("requires_unvisited"):
			if option.has("unvisited_link"):
				var _unvisited_interaction = option.unvisited_link
				if glory.the_history.has(option.unvisited_link):
					continue 
			if option.has("unvisited_links"):
				var any_visited = false
				for link in option.unvisited_links:
					if glory.the_history.has(link):
						
						any_visited = true
				if any_visited == true:
					continue
					
			else:
				pass
				
		
		#var conditions_met = false
		if option.has("conditions_aspect"):
			var specific_aspect_array = [] #Tracks how many conditions are met. Only render choices if all indices true.
			var specific_aspect_conditions = option.conditions_aspect #{"aspect": 2}
			var player_aspects = _reference.get_tree().root.find_child("aspects_panel", true, false).aspect_dict
			for aspect in specific_aspect_conditions:
				if player_aspects.has(aspect):
					if player_aspects[aspect] >= specific_aspect_conditions[aspect]:
						specific_aspect_array.append(true)
				else:
					specific_aspect_array.append(false)
			
	
			if specific_aspect_array.has(false):	
				#Load hint version if there is an unmet condition
				var option_node = load("res://text_engine/packed_scenes/single_option.tscn").instantiate()
				var content = '[hint="'
				content += option.hint_tooltip
				content += '"]'
				content += TextEffects.locked_option.open
				content += option.hint
				content += TextEffects.locked_option.close
				content += "[/hint]"
				option_node.unpack(content, _reference) #Load content into the option node
				option_node.find_child("option_bullet").color.a = 0.5
				output_container.add_child(option_node) #Assign to organizer on screen
				
			if !specific_aspect_array.has(false):
				#Else, load real version
				var option_node = load("res://text_engine/packed_scenes/single_option.tscn").instantiate()
				var content = '[url="'
				content += option.links_to
				content += '"]'
				content += option.text
				content += '[/url]'
				option_node.unpack(content, _reference)
				output_container.add_child(option_node)	
				#No conditions? Load normally
			
			
			
		
		if option.has("conditions_word"):
			var specific_word_array = [] #array of bools. All true == all specific words met
			var specific_word_condition = option.conditions_word
			var specific_word_slots = specific_word_condition.keys()
			for slot in specific_word_slots:
			
				if specific_word_condition[slot]:
					if _reference.active_interaction.slots[slot] == specific_word_condition[slot].specific_id:
						specific_word_array.append(true)
					else:
						specific_word_array.append(false)
					
			if specific_word_array.has(false):	
				#Load hint version if there is an unmet condition
				var option_node = load("res://text_engine/packed_scenes/single_option.tscn").instantiate()
				var content = '[hint="'
				content += option.hint_tooltip
				content += '"]'
				content += TextEffects.locked_option.open
				content += option.hint
				content += TextEffects.locked_option.close
				content += "[/hint]"
				option_node.unpack(content, _reference) #Load content into the option node
				option_node.find_child("option_bullet").color.a = 0.5
				output_container.add_child(option_node) #Assign to organizer on screen
			if !specific_word_array.has(false):
				#Else, load real version
				var option_node = load("res://text_engine/packed_scenes/single_option.tscn").instantiate()
				var content = '[url="'
				content += option.links_to
				content += '"]'
				content += option.text
				content += '[/url]'
				option_node.unpack(content, _reference)
				output_container.add_child(option_node)	
				#No conditions? Load normally
		if !option.has("conditions_word") && !option.has("conditions_aspect"):
				var option_node = load("res://text_engine/packed_scenes/single_option.tscn").instantiate()
				var content = '[url="'
				content += option.links_to
				content += '"]'
				content += option.text
				content += '[/url]'
				option_node.unpack(content, _reference)
				output_container.add_child(option_node)	
		#conditions_met = true

static func executeFunctions(_reference, functions:Array):
	#Functions arrive in the form of: [ ["function_id", [arg_1, arg_2_, arg_3], ["function_id_2", [args...] ]
	for function_pair in functions:
		var function_id = function_pair[0]
		var function_args = function_pair[1]
		var _engine_functions = EngineFunctions.new() 
		#I must make the _engine_functions node a child of the _reference (interaction parser)
		_reference.add_child(_engine_functions)
		if !(function_id in _engine_functions):
			print("Engine functions does not have function: " + function_id)
			_engine_functions.queue_free()
		else:
		#You cannot use .callv() on a static class, so must make an instance.
			print("Made it to the engineFunctions")
			_engine_functions.callv(function_id, function_args)
			#Do I need to delete that _engine_functions? Queue_free does that. Might as well.
			_engine_functions.queue_free()		

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
