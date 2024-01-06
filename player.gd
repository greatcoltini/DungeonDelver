extends Node


var ui

var stats = {
	"health" = 0,
	"energy" = 0,
	"light" = 0
}

var health_indicator
var energy_indicator
var light_indicator

var indicators = {
	"health": health_indicator,
	"energy": energy_indicator,
	"light": light_indicator
}


func initialize():
	ui = get_tree().get_first_node_in_group("UI")
	health_indicator = get_tree().get_first_node_in_group("health")
	energy_indicator = get_tree().get_first_node_in_group("stamina")
	light_indicator = get_tree().get_first_node_in_group("light")
	indicators = {
		"health": health_indicator,
		"energy": energy_indicator,
		"light": light_indicator
	}

func change_property(val, property_name):
	stats[property_name] += val
	print(stats)
	
	var indicator = indicators[property_name]
	indicator.value = stats[property_name]
	
