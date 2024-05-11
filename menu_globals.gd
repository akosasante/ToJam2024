extends Node

# Remaining capacity for this menu order
# This starts at a number, let's say 9 for now
# and changes depending on what's being ordered
# later it will also be affected by the number of already ordered, but not-yet-eaten dishes on the table
static var MAX_CAPACITY : int = 9

var remaining_capacity: int = MAX_CAPACITY

signal remaining_capacity_changed

var foods_on_table := {}

var foods_image_dict = {}

signal food_on_table_updated

func update_food_on_table(foods_being_ordered: Dictionary):
	for ordered_dish in foods_being_ordered:
		var ordered_amount : int = foods_being_ordered[ordered_dish]
		var amount_on_table = foods_on_table.get(ordered_dish, 0)
		
		foods_on_table[ordered_dish] = amount_on_table + ordered_amount
	
	# After we've added all the foods from the menu to the table
	reset_remaining_capacity()
	
	food_on_table_updated.emit()

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
	if node is Food:
		result.push_back(node)
	for child in node.get_children():
		findAllFoods(child, result)