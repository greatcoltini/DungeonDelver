extends Node2D

@onready var camera = $Camera2D
@onready var button = $TextureButton

var hand

# Called when the node enters the scene tree for the first time.
func _ready():
	DeckScript.initialize()
	hand = get_tree().get_first_node_in_group("hand")
	
	
func traverse_room():
	button.visible = false
	hand.visible = false;
	camera.get_child(0).play("traverse")
	
func enter_new():
	hand.visible = true
	button.visible = true
	
