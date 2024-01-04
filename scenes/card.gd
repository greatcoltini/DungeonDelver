extends Node2D

var card_name
var card_hand = []
var prior_z_index = []

@onready var anim = $AnimationPlayer
@onready var btn = $TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_texture(text):
	$TextureButton.texture_normal = load("res://assets/cards/" + text + ".png")
	card_name = text


func _on_texture_button_mouse_entered():
	card_hand = get_tree().get_nodes_in_group("card")
	
	for i in card_hand.size():
		prior_z_index.append(card_hand[i].z_index)
		card_hand[i].scale = Vector2(0.9, 0.9)
		
	self.scale = Vector2(1.2, 1.2)
	self.z_index = 5


func _on_texture_button_mouse_exited():
	card_hand = get_tree().get_nodes_in_group("card")
	
	for i in card_hand.size():
		card_hand[i].z_index = prior_z_index[i]
		card_hand[i].scale = Vector2(1.0, 1.0)


func _on_texture_button_pressed():
	anim.play("use")


func _on_animation_player_animation_finished(anim_name):
	DeckScript.play_card(self) # Replace with function body.
