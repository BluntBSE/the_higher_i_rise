extends ColorRect
class_name HistoryRect
#{"aspect_dict": aspect_dict, "mem_array": mem_array, "pages_at_recording": _reference.get_tree().root.get_node("the_glory").pages, "recorded_at": recorded_at}s


func unpack(history): #Maybe rename to refresh
	var button_container = get_node("scroll_container/button_container")
	print("HISTORY AGAIN", history)
	for n in button_container.get_children():
		n.queue_free()	

	for item in history: #Sorting this every single time you open this is gonna be inefficient..
		#OPTIONS: We can either order here, or save the history as an index unto itself...
		#But is that always the same as N pages ago?
		var history_button:HistoryButton = load("res://menu_and_ui/packed_scenes/history_button.tscn").instantiate()
		button_container.add_child(history_button)
		history_button.unpack(item) #data, key


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
