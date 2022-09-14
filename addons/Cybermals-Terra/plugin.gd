tool
extends EditorPlugin

var TerrainMenu = preload("res://addons/Cybermals-Terra/TerrainMenu.tscn")

var _obj
var terrain_menu


func _enter_tree():
	#Add UI components
	terrain_menu = TerrainMenu.instance()
	add_control_to_container(CONTAINER_SPATIAL_EDITOR_MENU, terrain_menu)
	terrain_menu.connect("generate_world_bounds", self, "_on_TerrainMenu_generate_world_bounds")
	
	
func _exit_tree():
	#Remove UI components
	terrain_menu.queue_free()
	
	
func handles(obj):
	#Terrain mesh?
	if obj.is_type("MeshInstance") and obj.get_name() == "Terrain":
		terrain_menu.enable_terrain_tools(true)
		return true
		
	terrain_menu.enable_terrain_tools(false)
	return false


func edit(obj):
	_obj = obj


func _on_TerrainMenu_generate_world_bounds():
	#Add static body to parent node of terrain
	var body = StaticBody.new()
	body.set_name("Bounds")
	_obj.get_parent().add_child(body)
	body.set_owner(_obj.get_parent())
	
	var shape1 = BoxShape.new()
	shape1.set_extents(Vector3(1, 500, _obj.get_scale().z))
	var shape2 = BoxShape.new()
	shape2.set_extents(Vector3(_obj.get_scale().x, 500, 1))
	
	var col_shape1 = CollisionShape.new()
	col_shape1.set_name("LeftWall")
	col_shape1.set_shape(shape1)
	col_shape1.set_translation(Vector3(-_obj.get_scale().x, 0, 0))
	body.add_child(col_shape1)
	col_shape1.set_owner(_obj.get_parent())
	
	var col_shape2 = CollisionShape.new()
	col_shape2.set_name("RightWall")
	col_shape2.set_shape(shape1)
	col_shape2.set_translation(Vector3(_obj.get_scale().x, 0, 0))
	body.add_child(col_shape2)
	col_shape2.set_owner(_obj.get_parent())
	
	var col_shape3 = CollisionShape.new()
	col_shape3.set_name("FrontWall")
	col_shape3.set_shape(shape2)
	col_shape3.set_translation(Vector3(0, 0, _obj.get_scale().z))
	body.add_child(col_shape3)
	col_shape3.set_owner(_obj.get_parent())
	
	var col_shape4 = CollisionShape.new()
	col_shape4.set_name("RearWall")
	col_shape4.set_shape(shape2)
	col_shape4.set_translation(Vector3(0, 0, -_obj.get_scale().z))
	body.add_child(col_shape4)
	col_shape4.set_owner(_obj.get_parent())
