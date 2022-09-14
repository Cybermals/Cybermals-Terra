tool
extends Control

signal generate_world_bounds


func _ready():
	#Connect terrain menu signal
	get_node("MenuButton").get_popup().connect("item_pressed", self, "_on_MenuButton_item_pressed")
	
	
func _on_MenuButton_item_pressed(ID):
	#Generate world bounds?
	if ID == 0:
		emit_signal("generate_world_bounds")
	
	
func enable_terrain_tools(enable):
	#Enbable?
	var popup = get_node("MenuButton").get_popup()
	
	if enable:
		popup.set_item_disabled(0, false)
		
	else:
		popup.set_item_disabled(0, true)
