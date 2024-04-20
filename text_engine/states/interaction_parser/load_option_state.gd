extends EmptyState
class_name LoadOptionState

##TODO: ???##Distinct from LoadInteractionState as this has a fade_in process.
 
'''
class_name EmptyState

	func stateUpdate(dt):
		pass
	func stateHandleInput():
		pass
	func stateEnter(args):
		pass
	func stateExit():
		pass
		
'''
#Args that get passed in through the state machine.  Here, an interaction.
var _args#: Interaction
var _reference#: Node2D #usually passed as 'self'
var state_machine#: LoadInteractionState #state machine attached to the reference passed in

#Variables set by the interaction
var _base_bg_color: Color = Color(1.0, 1.0, 1.0, 1.0)
var _text: String
var _slots: Dictionary = {"slot_1": "#ID69"}
var _options: Array
var _title: String

#For manipulating alpha
var title_node
var content_node
var options_node
var portrait_node_0
var portrait_node_1
var a #alpha, for fading
var t = 0.0 #Used for controlling animations
var original_color

func parsePortraits(interaction: Interaction):
	if !interaction:
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
			var img = Image.new()
			img.load(res.portrait)
			var portrait_node = _reference.get_node('interaction_fg/portrait_controller/'+output_name)
			portrait_node.visible = true
			var img_node = portrait_node.get_node('img')
			img_node.set_texture(ImageTexture.create_from_image(img))
			var text_node = portrait_node.get_node('text_bg/label')
			text_node.text = "[center]" + res.display_name + "[/center]"

		
func parseOptions2(interaction: Interaction):
	if !interaction:
		push_error("null interaction in parseOptions")
		return null 
	#Clear options before updating them
	var output_container = _reference.find_child("options_container")
	for child in output_container.get_children():
		child.queue_free()
	for option in interaction.options:
		var _conditions_met = false
		if option.has("conditions_word"):
			var specific_word_array = [] #array of bools. All true == all specific words met
			var specific_word_condition = option.conditions_word
			var specific_word_slots = specific_word_condition.keys()
			for slot in specific_word_slots:
			
				if specific_word_condition[slot]:
					if _reference.active_interaction.slots[slot] == specific_word_condition[slot].specific_id:
						specific_word_array.append(true)
					else:
						specific_word_array.append(false)
						
				if specific_word_array.has(false):	
					#Load hint version if there is an unmet condition
					var option_node = load("res://text_engine/packed_scenes/single_option.tscn").instantiate()
					var content = '[hint="'
					content += option.hint_tooltip
					content += '"]'
					content += option.hint
					content += "[/hint]"
					option_node.unpack(content, _reference) #Load content into the option node
					output_container.add_child(option_node) #Assign to organizer on screen
				if !specific_word_array.has(false):
					#Else, load real version
					var option_node = load("res://text_engine/packed_scenes/single_option.tscn").instantiate()
					var content = '[url="'
					content += option.links_to
					content += '"]'
					content += option.text
					content += '[/url]'
					option_node.unpack(content, _reference)
					output_container.add_child(option_node)	
				#No conditions? Load normally
				if !option.has("conditions_word"):
					_conditions_met = true
			
			
func parseInteraction(interaction: Interaction):
	#Store
	if interaction:
		var output_title = _reference.get_node("interaction_fg/text_title")
		var output_node = _reference.get_node('interaction_fg/text_content')
		var output_bg = _reference.get_node('interaction_bg')
		_base_bg_color = interaction.base_bg_color
		_text = interaction.text
		_slots = interaction.slots
		_options = interaction.options
		_title = interaction.display_title
	
		#Apply - This may be moved to its own state at some point.
		var output_text = TextTools.parseText(_text, interaction)
		output_node.text = output_text
		#Optional intercept point for title manipulation, but probably not necessary.
		output_title.text = "[u][b]"+_title+"[/b][/u]"
		#output_node.append_text(output_text) #Append is recommended for rapid drawing, but not appropriate here.
		output_bg.color = _base_bg_color
		_reference.active_interaction = interaction #this may or may not be redundant. I think it might be useful if we can recycle this to use modified interactions from choose_option, which is why I've done it.
		
		

func stateEnter(args: Interaction):
	t = 0.0
	a = 0.0 #Start invisible, become visible
	_args = args
	title_node = _reference.get_node("interaction_fg/text_title")
	content_node = _reference.get_node("interaction_fg/text_content")
	options_node = _reference.get_node("interaction_fg/options_organizer")
	portrait_node_0 = _reference.get_node("interaction_fg/portrait_controller/portrait_0")
	portrait_node_1 = _reference.get_node("Interaction_fg/portrait_controller/portrait_1")
	
func stateExit():

	

		#Switch state/return
	return null


func stateUpdate(dt):
	t = t + dt
	#TODO: Somehow need to clear any selected words, etc.
	_reference.can_hover = false
	_reference.selected_word = null
	_reference.hovered_word = null
	_reference.hovered_slot = null
	parsePortraits(_args)
	parseInteraction(_args)
	parseOptions2(_args)
	#Fade in

	title_node.modulate = title_node.modulate.lerp(Color(1.0,1.0,1.0,1.0), t)
	content_node.modulate = content_node.modulate.lerp(Color(1.0,1.0,1.0,1.0), t)
	options_node.modulate = options_node.modulate.lerp(Color(1.0,1.0,1.0,1.0), t)
	portrait_node_0.modulate = portrait_node_0.modulate.lerp(Color(1.0,1.0,1.0,1.0), t)
	
	if t < .2:
		return

		
	_reference.state_machine.Change("finished", null)
	
	#If text is done updating, we should do state_machine.Change("finished")

func _init(reference, args): #usually self, {args}. Here, an interaction
	_reference = reference
	_args = args
	state_machine = _reference.state_machine
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
