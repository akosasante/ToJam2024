extends Node

# Remaining capacity for this menu order
# This starts at a number, let's say 9 for now
# and changes depending on what's being ordered
# later it will also be affected by the number of already ordered, but not-yet-eaten dishes on the table
static var MAX_CAPACITY : int = 9

var remaining_capacity: int = MAX_CAPACITY

var food_items = {
	"CaliforniaRoll": load("res://resources/CaliforniaRoll.tres") as Food,
	"Edamame": load("res://resources/Edmame.tres") as Food,
	"MisoSoup": load("res://resources/MisoSoup.tres") as Food,
	"Pufferfish": load("res://resources/PufferFish.tres") as Food,
	"SalmonNigiri": load("res://resources/SalmonNigiri.tres") as Food,
	"SalmonSashimi": load("res://resources/SalmonSashimi.tres") as Food,
	"ShrimpTempura": load("res://resources/ShrimpTempura.tres") as Food,
	"SpicySalmonRoll": load("res://resources/SpicySalmonRoll.tres") as Food,
	"TamagoSushi": load("res://resources/TamagoSushi.tres") as Food
}

var foods_on_table = {}

# TODO: This is just an example so that we can test the EndScreen
# Should end up being an array of Food obbjects or dictionaries with [{ food: FoodObject, amount_eaten: number}] 
var foods_eaten: Array[Dictionary] = [{"name": "TamagoSushi", "value": 20, "amount_eaten": 5}, {"name": "Miso Soup", "value": 5, "amount_eaten": 1}]

signal remaining_capacity_changed
signal food_on_table_updated

func update_food_on_table(foods_being_ordered: Dictionary):
	for ordered_dish in foods_being_ordered:
		var ordered_amount : int = foods_being_ordered[ordered_dish]
		var amount_on_table = foods_on_table.get(ordered_dish, 0)
		
		foods_on_table[ordered_dish] = amount_on_table + ordered_amount
	
	# After we've added all the foods from the menu to the table
	reset_remaining_capacity()
	
	food_on_table_updated.emit()
	
func remove_food_from_table(food_name : String):
	if (foods_on_table.has(food_name)):
		foods_on_table[food_name] -= 1
		
		var amount = foods_on_table[food_name]
		if (amount <= 0):
			foods_on_table.erase(food_name)
		
	reset_remaining_capacity()
	
func remaining_capacity_change(value: int):
	remaining_capacity += value
	remaining_capacity_changed.emit()

# We adjust remaining capacity when using the ipad menu
# but if the player cancels out of it, we don't want their un-entered order to count against their remaining capacity
# so we can use this function to recalculate the capacity based on the current food in the table
func reset_remaining_capacity():
	var food_amounts: Array = foods_on_table.values()
	remaining_capacity = MAX_CAPACITY - food_amounts.reduce(func(accum, number): return accum + number, 0)
	remaining_capacity_changed.emit()
	
	if remaining_capacity > MAX_CAPACITY:
		push_warning("Unexpected: somehow remaining capacity (%d) is greater than max capacity (%d). Program will continue but weird things may happen" % [remaining_capacity, MAX_CAPACITY])

func findAllFoods(node: Node, result : Array) -> void:
	if node is FoodButton:
		result.push_back(node)
	for child in node.get_children():
		findAllFoods(child, result)
		
		
func reset_all():
	foods_on_table = {}
	reset_remaining_capacity()
