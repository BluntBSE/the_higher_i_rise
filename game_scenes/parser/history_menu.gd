extends Control


func unpack():
	var scrollc:ScrollContainer = get_node("history_rect/scroll_container")
	var container = get_node("history_rect/scroll_container/button_container")
	var total_height = 0
	#for button in container.get_children():
		#print("Found a child")
		#total_height += button.size.y
		#print("Child size is ", button.size.y)
	scrollc.set_deferred("scroll_vertical", scrollc.get_v_scroll_bar().max_value)
# Called when the node enters the scene tree for the first time.
func _ready():
	#var container = find_child("scrolL_container")
	#container.set_deferred(container.scroll_vertical, 100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
