extends Node2D

signal button_pressed(opt);




func option_pressed(opt):
	emit_signal("button_pressed", opt)
