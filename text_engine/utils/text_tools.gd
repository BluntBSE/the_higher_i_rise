extends Node
class_name TextTools

static func getResourceFromDirectory(directory: String, file_name: String) -> String:
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

	#Why did I do this? Probably to intercept it if I want...
	#var output_interaction = Interaction.new()
	var resource = load(file)
	#Why the fuck did I do this? It's an opportunity to modify interactions at their point of loading...but that's not a good idea
	#if resource:
		#output_interaction.base_bg_color = resource.base_bg_color
		#output_interaction.text = resource.text
		#output_interaction.slots = resource.slots
		#output_interaction.options = resource.options
		#return output_interaction
	return resource
	print("Invalid interaction id! Or something more sinister")

static func getWordResource(id: String):
	var catalog_dir = "res://content/catalogs/IWords/"
	var file = getResourceFromDirectory(catalog_dir, id)
	var word = IWord.new()
	var resource = load(file)
	if !resource:
		print("No resource found!")
		return null
	word.id = resource.id
	word.text = resource.text
	word.bbcode = resource.bbcode
	word.part_speech = resource.part_speech
	word.aspects = resource.aspects
	word.principles = resource.principles
	return word
	print("Invalid word id!")

static func determineGreatestPrinciple(principles:Dictionary):
	var greatest_val = 0
	var greatest_principle = "none"
	for principle in principles.keys():
		if principles[principle] > greatest_val:
			greatest_val = principles[principle]
			greatest_principle = str(principle)
	return greatest_principle
	
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
		text += "[font_size=32]"
		text += "[outline_size=4]"
		text += "[outline_color=" + "black" + "]"
		text += "[color=" + Principles[greatest_principle].color + "]"
		text += word.text
		text += "[/color]"
		text += "[/outline_color]"
		text += "[/outline_size]"
		text += "[/font_size]"
		
	text += "[/url]"
	#text += "[/u]"
	text += "[/hint]"
		
	return text

static func getWordFromSlot(interaction: Interaction, slot: String):
	#This function will take a slot, like "slot_1", and return the word that is stored in the _slots dictionary of the interaction.
	#This word is stored in the _slots dictionary of the interaction, and is retrieved by the "slot_1", "slot_2", etc. keys.
	pass



static func parseText(input_string: String, interaction: Interaction):
	#Wherever this function encounters a flag like <slot_1>, it will replace it with the word that corresponds to that slot.
	#This word is stored in the _slots dictionary of the interaction, and is retrieved by the "slot_1", "slot_2", etc. keys.
	#This function will also handle any other flags that we might want to use in the future.
	#For example, we might want to use a flag like <player_name> to refer to the player's name, or /n for a newline.

	var text = input_string
	#First, we'll replace the slots

	for slot in interaction.slots:
		var word = getWordResource(interaction.slots[slot])
		
		if !word:
			print("No word found!")
			return "WORD NOT FOUND"
		word = applyStyling(word)
		#Here is where we would add anything to modify it to be a sentence, such as capitalization.
		text = text.replace("<" + slot + "/>", word)
		
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
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
