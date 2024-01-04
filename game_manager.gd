extends Node



var level;
var risk = 0
var cards = []
var deck;

var current_event

const events = ["Loot"]
const monster_events = ["Skeleton"]

var event_deck = []



# room event generation
func generate_new_room():
	# if we have some level of risk, let's create chance for monsters
	if risk >= 1:
		event_deck.append(monster_events.pick_random())
	else:
		event_deck.append(events.pick_random())
	
	current_event = event_deck.pick_random()
	
