extends Node
class_name ImgTools

static func parsePortraits(_reference, interaction: Interaction):
	if !interaction:
		print("null interaction in parsePortraits")
		return null 
	#Hide all existing portrait nodes.
	var portrait_0 = _reference.get_node('interaction_fg/portrait_controller/portrait_0')
	var portrait_1 = _reference.get_node('interaction_fg/portrait_controller/portrait_1')
	portrait_0.visible = false
	portrait_1.visible = false
	
		
	if interaction.portraits.size() > 0: 
		for index in interaction.portraits.size():
			var output_name = "portrait_" + str(index) #e.g: find "portrait_1"
			var portrait_name = interaction.portraits[index]
			portrait_name = portrait_name
			var respath = TextTools.getResourceFromDirectory('res://content/catalogs/characters/', portrait_name)
			var res = load(respath)
			print(res)
			print(res.portrait)
			print(res.display_name)
			#var img = Image.new()
			#img.load(res.portrait)
			var portrait_node = _reference.get_node('interaction_fg/portrait_controller/'+output_name)
			portrait_node.visible = true
			var img_node = portrait_node.get_node('img')
			img_node.set_texture(load(res.portrait))
			var text_node = portrait_node.get_node('text_bg/label')
			text_node.text = "[center]" + res.display_name + "[/center]"		

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
