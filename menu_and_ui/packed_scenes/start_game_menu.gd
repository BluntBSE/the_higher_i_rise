extends ColorRect
class_name StartGameMenu


var slot_path = "user://"
var filename = "slots.tres"
var file_path = slot_path + filename
var is_open = false
@export var volume_number:RichTextLabel
@export var glory:TheGlory #Singleton for configuration variables

func unpack():
	var slots #SaveSlots or Null
	####
	if !ResourceLoader.exists(file_path):
		print("Writing new slot manager to user://")
		var base_file = SaveSlots.new()
		ResourceSaver.save(base_file, file_path)
		slots = ResourceLoader.load(file_path)
	else:
		slots = ResourceLoader.load(file_path)
	
	var slot_num = 1
	print(slots.saves)
	for save in slots.saves:
		var data = slots.saves[save]
		"""
		@export var active_interaction:Interaction
		@export var aspects:Dictionary
		@export var words:Array
		@export var decision_tree:Dictionary
		"""
		var slot_str = "slot_button_"+str(slot_num)
		var slot_button = get_node(slot_str)
		slot_button.unpack(slot_num, data)
		slot_num += 1
		
			
 	



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_open == true:
		var num = (glory.music_volume + 20) * 5
		var output = "[center]" + str(num) + "[/center]"
		volume_number.text = output
		
	pass
