extends ColorRect
class_name HistoryButton

var start_or_load = null
var state_machine:StateMachine2 = StateMachine2.new()
var _history_item
var _history_key

func unpack(history_item, history_key):
	print("HISTORY ITEM", history_item)
	var increment_text = get_node("slot_fg/increment_text")
	var interaction_name = get_node("slot_fg/interaction_name")
	var date_text = get_node("slot_fg/date_text")
	#This is to show "how many pages ago" somethign was.
	var page_difference = get_tree().root.get_node("the_glory").pages - history_item.pages_at_recording
	_history_item = history_item
	_history_key = history_key
	interaction_name.text = history_item.display_title
	increment_text.text = "[b]" + str(page_difference) + " Pages ago[/b]"
	date_text.text = history_item.recorded_at
	pass
		

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine.Add("hover_state", HistoryMenuHoverState.new(self, "init hover start args"))
	state_machine.Add("normal", HistoryMenuNormalState.new(self, "init normal start button args"))	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.stateUpdate(delta)
	


func _on_slot_fg_mouse_entered():
	state_machine.Change("hover_state", null)


func _on_slot_fg_mouse_exited():
	state_machine.Change("normal", null)
	pass # Replace with function body.
