extends RichTextLabel


# kill on anim finish
func _on_animation_player_animation_finished():
	queue_free()
