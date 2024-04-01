extends HBoxContainer

func unpack(principle:String, value:int):
	var img = Image.new()
	var icon_path = Principles[principle].icon
	img.load(icon_path)
	var img_node = find_child("principle_img")
	img_node.set_texture(ImageTexture.create_from_image(img))
	var number_node = find_child("principle_num")
	number_node.text = str(value)

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
