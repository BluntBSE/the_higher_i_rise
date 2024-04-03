class_name AnimationTools


static func smoothstep(x):
	return ((x) * (x) * (3 - 2 * (x)))
	
static func scale_in_place(cnode:Control, scale, rate, t):
	#To make this appear "in place", I must record the current position, then move to the left/right
	#By half of the X gained by the scale-up (left if positive, right if negative)
	var initial_position:Vector2 = cnode.position
	var target_x_position = initial_position.x + (cnode.size.x - (cnode.size.x * scale))
	#cnode.scale=Vector2(1,1)
	#cnode.scale = Vector2(scale, scale)
	cnode.position = cnode.position.lerp(Vector2(target_x_position, cnode.position.y), t*rate)
	cnode.scale = cnode.scale.lerp(Vector2(scale,scale), t*rate)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
