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

		#dir.list_dir_end()

	return file_path

	
static func getInteractionResource(id: String):
	var story_dir = "res://content/stories"
	var file = getResourceFromDirectory(story_dir, id)
	var output_interaction = Interaction.new()
	var resource = load(file)
	
	if resource:
		output_interaction.base_bg_color = resource.base_bg_color
		output_interaction.text = resource.text
		output_interaction.slots = resource.slots
		output_interaction.options = resource.options
		return output_interaction
	print("Invalid interaction id! Or something more sinister")

static func getWordResource(id: String):
	var catalog_dir = "res://content/catalogs/IWords/"
	var file = getResourceFromDirectory(catalog_dir, id)
	var word = IWord.new()
	
	var resource = load(file)
	word.id = resource.id
	word.text = resource.text
	word.bbcode = resource.bbcode
	word.part_speech = resource.part_speech
	word.aspects = resource.aspects
	word.principles = resource.principles
	return word
	print("Invalid word id!")


static func applyStyling(word: IWord):
	pass

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
		#Here is where we would add anything to modify it to be a sentence...
		
		text = text.replace("<" + slot + "/>", word.text)

	return text
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
