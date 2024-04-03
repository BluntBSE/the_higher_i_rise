extends EmptyState
class_name LoadOptionState

##T##Distinct from LoadInteractionState as this has a fade_in process.
 
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

		
		

func parseOptions(interaction: Interaction):
	#What to do when null interaction arrives?
	if !interaction:
		return null #Probably should do an EmptyInteraction class
	
	var output_node = _reference.get_node('interaction_fg/options_content')
	var output_text = ""
	var index = 0
	if len(interaction.options) > 0:
		#get the state of the parsers slots & player aspects
		#TODO: player aspects
		for option:Dictionary in interaction.options:
			#Check the relevant slot in 
			var conditions_met = false
			#if the option has word conditions of any type....
	
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
					if index > 0:
						output_text = output_text+"[p]"
					output_text += '[hint="'
					output_text += option.hint_tooltip
					output_text += '"]'
					output_text += option.hint
					output_text += "[/hint]"
							
					pass
				
				if !specific_word_array.has(false):
				#Index 0 is to make sure we don't put a paragraph tag on the first one
					if index > 0:
						output_text = output_text+"[p]"
					output_text += '[url="'
					output_text += option.links_to
					output_text += '"]'
					output_text += option.text
					output_text += '[/url]'
			
			#If the option has no word or (TODO), aspect conditions, simply print the option
			if !option.has("conditions_word"):
				conditions_met = true
				if index > 0:
					output_text = output_text+"[p]"
				output_text += '[url="'
				output_text += option.links_to
				output_text += '"]'
				output_text += option.text
				output_text += '[/url]'
				

	output_node.text = output_text

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
		output_title.text = "[u]"+_title+"[/u]"
		#output_node.append_text(output_text) #Append is recommended for rapid drawing, but not appropriate here.
		output_bg.color = _base_bg_color
		_reference.active_interaction = interaction #this may or may not be redundant. I think it might be useful if we can recycle this to use modified interactions from choose_option, which is why I've done it.
		
		

func stateEnter(args: Interaction):
	a = 0.0 #Start invisible, become visible
	_args = args
	title_node = _reference.get_node("interaction_fg/text_title")
	content_node = _reference.get_node("interaction_fg/text_content")
	options_node = _reference.get_node("interaction_fg/options_content")
	portrait_node_0 = _reference.get_node("interaction_fg/portrait_controller/portrait_0")
	portrait_node_1 = _reference.get_node("Interaction_fg/portrait_controller/portrait_1")
	
func stateExit():

	

		#Switch state/return
	return null

func stateUpdate(dt):
	#TODO: Somehow need to clear any selected words, etc.
	_reference.can_hover = false
	_reference.selected_word = null
	_reference.hovered_word = null
	_reference.hovered_slot = null
	parsePortraits(_args)
	parseInteraction(_args)
	parseOptions(_args)
	#Fade in
	if !(is_equal_approx(a, 1.0)):
		a = lerp(a, 1.0, .1) #TODO: Add smoothstep
		title_node.modulate.a = a
		content_node.modulate.a = a
		options_node.modulate.a = a
		portrait_node_0.modulate.a = a
		portrait_node_0.modulate.a = a
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
func _process(delta):
	pass
