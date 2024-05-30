extends PanelContainer

var actions: Array[Action] = []

@onready var menu_options = $MarginContainer/MenuOptions


func on_close():
	# clean up children
	self.visible = false
	for child in menu_options.get_children():
		menu_options.remove_child(child)
		child.queue_free()
		
	
func on_open(territory: Territory):
	# Put the name of the territory at the top
	# display an icon/crest
	# Draw some representation of the level of the territory (small fort vs bustling city)
	# shade the background based on if it's player owned or an enemy (or maybe based on the npc theme)
	# ...
	# populate menu action options
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
