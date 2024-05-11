extends Node

# Remaining capacity for this menu order
# This starts at a number, let's say 9 for now
# and changes depending on what's being ordered
# later it will also be affected by the number of already ordered, but not-yet-eaten dishes on the table
var remaining_capacity: int = 9
var foods_on_table := []
signal remaining_capacity_changed


func remaining_capacity_change(value: int):
	remaining_capacity += value
	remaining_capacity_changed.emit()
