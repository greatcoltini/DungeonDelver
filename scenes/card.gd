extends Node2D

const NAME = "card-stumb"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_texture(text):
	$TextureButton.texture_normal = load("res://assets/cards/" + text + ".png")
