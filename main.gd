extends Node2D

@onready var camera = $Camera2D
@onready var button = $TextureButton
@onready var deck = $UserInterface/deck
@onready var manager = GameManager
@onready var loot_visual = $loot

# instances of objects
@onready var visual_loot_gain = preload("res://scenes/visual_loot_gain.tscn")


# variables
var loot = 0
var loot_quota = 0
var hand

# Called when the node enters the scene tree for the first time.
func _ready():
	DeckScript.initialize()
	hand = get_tree().get_first_node_in_group("hand")
	generate_loot_quota()
	
func _process(delta):
	loot_visual.text = str(loot) + "/" + str(loot_quota)

# generate quota
func generate_loot_quota():
	loot_quota = randi_range(200, 500)	
	
func traverse_room():
	button.visible = false
	hand.visible = false;
	camera.get_child(0).play("traverse")
	manager.generate_new_room()
	
func enter_new():
	hand.visible = true
	button.visible = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "traverse":
		enter_new()
		
func burgle_loot():
	var temp_loot = randi_range(5, 10)
	loot += temp_loot
	var lt = visual_loot_gain.instantiate()
	lt.text = "+" + str(temp_loot) + "!"
	add_child(lt)
	
