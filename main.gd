extends Node2D

@onready var camera = $Camera2D
@onready var lightcover = $Camera2D/"light-cover"
@onready var button = $TextureButton
@onready var deck = $UserInterface/deck
@onready var manager = GameManager
@onready var player = Player
@onready var loot_visual = $loot
@onready var ui = $UserInterface
var event

# instances of objects
@onready var visual_loot_gain = preload("res://scenes/visual_loot_gain.tscn")


# variables
var loot = 0
var loot_quota = 0
var hand

# Called when the node enters the scene tree for the first time.
func _ready():
	player.initialize()
	player.change_property(100, "energy")
	player.change_property(100, "health")
	player.change_property(50, 'light')
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
	player.change_property(-25, "light")
	lightcover.modulate = Color(0, 0, 0, (100 - player.stats["light"]) / 100.5)
	camera.get_child(0).play("traverse")
	
	
func enter_new():
	if player.stats["light"] > 0:
		manager.generate_new_room()
		event = get_tree().get_first_node_in_group("eventscene")
		event.button_pressed.connect(Callable(process_options).bind()) # could be issue here
#		hand.visible = true
#		button.visible = true

func process_options(option_picked):
	if event:
		event.queue_free()
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
	
