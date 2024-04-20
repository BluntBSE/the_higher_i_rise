extends ColorRect

var _parser #This is set whenever this node is unpacked. It is used to connect local signals to the functions in the parser.
func unpack(content:String, parser:Control):
	var output_node:RichTextLabel = get_node("option_content")
	output_node.text = content
	_parser = parser
	#output_node.meta_clicked.connect(fuck)
	#Register this items "meta_clicked" event to the parent.
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



#Idk why I couldn't connect these directly...TODO: Fix it! Make this a proper "connect" in the unpack function >:(
func _on_option_content_meta_clicked(meta):
	_parser._on_options_content_meta_clicked(meta)
	pass # Replace with function body.
