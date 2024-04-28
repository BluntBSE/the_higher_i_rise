extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#func _notification(what):
#if what == NOTIIFCATION_WM_CLOSE_REQUEST:
#get_tree.quit()
func _on_button_down():
	#If you don't propagate a notification, you can't do stuff on quit like save, confirm, etc. 
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
	pass # Replace with function body.
