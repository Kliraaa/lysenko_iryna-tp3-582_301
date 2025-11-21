extends CanvasLayer

var hearts_list = []

func _ready():
	var hearts_parent = $HBoxContainer
	for child in hearts_parent.get_children():
		hearts_list.append(child)
		
func update_hearts(health):
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health
