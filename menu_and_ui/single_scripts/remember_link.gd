extends RichTextLabel

#Do we both with a state machine here? 
#This is a provisional element so I'd rather not.
#0879b7be
#Replace with state machine if truly necessary.
var hovered = false
var base_color: Color = Color("#0879b7be")
var highlight_color: Color = Color("#ffffff")


func open_remember_window():
	var main = get_tree().root.get_node("the_glory/main")
	main.state_machine.Change("history_open", null)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hovered == true:
		if Input.is_action_just_released("left_click"):
			open_remember_window()




func _on_mouse_entered():
	modulate = highlight_color
	hovered = true



func _on_mouse_exited():
	modulate = base_color
	hovered = false

