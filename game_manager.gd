extends Node

# event instance
var event_instance = preload("res://scenes/event_scene.tscn")

var level;
var risk = 0
var cards = []
var deck;

var current_event

const events = ["loot"]
const monster_events = ["skeleton"]

var event_deck = []



# room event generation
func generate_new_room():
	# if we have some level of risk, let's create chance for monsters
	if risk >= 0:
		event_deck.append(monster_events.pick_random())
	else:
		event_deck.append(events.pick_random())
	
	current_event = event_deck.pick_random()
	load_event(current_event)
	
	
# function that loads the event and the json, applies the stuff
func load_event(event):
	var cur_event_instance = event_instance.instantiate()
	
	var json = JSON.new()
	var json_string = "res://data/events/" + event + "-event.json"
	var parse_res = json.parse(json_string)
	var data = json.get_data()
	
	print(parse_res)
