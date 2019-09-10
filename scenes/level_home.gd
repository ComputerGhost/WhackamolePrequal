extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_player_bullet_hit(tilemap, position):
	if tilemap.name == "overlay_tiles" or tilemap.name == "flowers":
		breakTile(tilemap, position)
	
func breakTile(tilemap, position):
	position = tilemap.world_to_map(position)
	
	var index = tilemap.get_cell_autotile_coord(position.x, position.y)
	if index.y == 4 and index.x == 6:
		pass
	elif index.y == 5 and (index.x == 0 or index.x == 2 or index.x == 4 or index.x == 6):
		pass
	elif index.y == 6 and index.x == 0:
		pass
	else:
		return
	
	index.x += 1
	tilemap.set_cell(position.x, position.y, 0, false, false, false, index)

