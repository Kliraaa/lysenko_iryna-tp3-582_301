extends CanvasLayer

var health = 3
var hearts_list = []

func _ready():
	var hearts_parent = $HBoxContainer
	for child in hearts_parent.get_children():
		hearts_list.append(child)

	update_hearts(health)

func update_hearts(value):
	health = value
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health
