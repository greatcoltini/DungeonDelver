extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	self.modulate = Color(1, 1, 1, 0.9) # Replace with function body.


func _on_mouse_exited():
	self.modulate = Color(1, 1, 1, 1) # Replace with function body.


func _on_pressed():
	get_parent().traverse_room() # Replace with function body.
