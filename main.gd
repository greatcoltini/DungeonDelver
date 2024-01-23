extends Node2D

@onready var camera = $Camera2D
@onready var lightcover = $Camera2D/"light-cover"
@onready var continueButton = $ContinueButton
@onready var deck = $UserInterface/deck
@onready var manager = GameManager
@onready var player = Player
@onready var loot_visual = $loot
@onready var ui = $UserInterface
@onready var torch = $AnimatedSprite2D

@onready var returnButton = $ReturnButton

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
	continueButton.visible = false
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
	# we get here if we do not have the opportunity to continue
	else:
		continueButton.visible = true
		continueButton.anim.play("disable")
		continueButton.disabled = true
		continueButton.tooltip_text = "You have no light remaining, you cannot continue."
		
		# disable the torch as well
		torch.play("drain")
		torch.get_child(0).queue_free()
		
		# play animation for return home button
		returnButton.visible = true
		returnButton.anim.play("spawn")
		

func process_options(option_picked):
	if event:
		event.queue_free()
		hand.visible = true
		continueButton.visible = true

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "traverse":
		enter_new()
		
		
func burgle_loot():
	var temp_loot = randi_range(5, 10)
	loot += temp_loot
	var lt = visual_loot_gain.instantiate()
	lt.text = "+" + str(temp_loot) + "!"
	add_child(lt)
	


func _on_return_button_pressed():
	pass # Replace with function body.
