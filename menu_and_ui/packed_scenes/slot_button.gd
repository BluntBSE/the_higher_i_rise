extends ColorRect
class_name SlotButton

var start_or_load = null
var state_machine:StateMachine2 = StateMachine2.new()
var slot_number
var save_file:SaveFile

func unpack(slot_num, save): #SaveFile or NUll
	slot_number = slot_num
	var slot_node = get_node("slot_fg/slot_text")
	var scene_node = get_node("slot_fg/active_scene_text")
	var delete_button = get_node("slot_fg/delete")
	slot_node.text = "[b]SLOT " + str(slot_num) +":[/b]"
	if save == null:
		scene_node.text = "Start new game"	
		start_or_load = "start"
		delete_button.visible = false
	else:
		var key = "slot_"+str(slot_num)
		scene_node.text = save.active_interaction.display_title
		save_file = save
		start_or_load = "load"
		delete_button.args = [slot_number]
		print("Delete args:")
		print(delete_button.args)
		

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.Add("hover_state", StartMenuHoverState.new(self, "init hover start args"))
	state_machine.Add("normal", StartMenuNormalState.new(self, "init normal start button args"))	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.stateUpdate(delta)
	


func _on_slot_fg_mouse_entered():
	state_machine.Change("hover_state", null)


func _on_slot_fg_mouse_exited():
	state_machine.Change("normal", null)
	pass # Replace with function body.
