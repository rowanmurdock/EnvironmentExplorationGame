extends Node2D

@onready var tilemap = $TileMap
@export var width = 100
@export var height = 50
@export var land_tiles = [ 1, 2, 3, 4, 5, 6]

func generate_base():
	var ocean_tile_id = 0
	for x in range(width):
		for y in range(height):
			tilemap.set_cell(0, Vector2i(x, y), ocean_tile_id, Vector2i(0, 0))


func generate_land_mass(start_pos := Vector2i(width / 2, height / 2), steps := 3000):
	var pos = start_pos
	for i in range(steps):
		var rand_tile = land_tiles[randi() % land_tiles.size()]
		tilemap.set_cell(0, Vector2i(pos.x, pos.y), rand_tile, Vector2i(0, 0))
		tilemap.set_cell(0, Vector2i(pos.x+1, pos.y), rand_tile, Vector2i(0, 0))
		tilemap.set_cell(0, Vector2i(pos.x-1, pos.y), rand_tile, Vector2i(0, 0))
		tilemap.set_cell(0, Vector2i(pos.x, pos.y+1), rand_tile, Vector2i(0, 0))
		tilemap.set_cell(0, Vector2i(pos.x, pos.y-1), rand_tile, Vector2i(0, 0))
		
		var direction = randi() % 4
		match direction:
			0: pos.x += 1   
			1: pos.x -= 1   
			2: pos.y += 1  
			3: pos.y -= 1   

		pos.x = clamp(pos.x, 5, width - 5)
		pos.y = clamp(pos.y, 5, height - 5)



func get_neighboring_tiles_list(pos: Vector2i) -> Array:
	var res = []
	res.append(Vector2i(pos.x+1,pos.y))
	res.append(Vector2i(pos.x-1,pos.y))
	res.append(Vector2i(pos.x,pos.y+1))
	res.append(Vector2i(pos.x,pos.y-1))
	return res
	


func generate_beaches():
	for x in range(width):
		for y in range(height):
			var current = Vector2i(x,y)
			if tilemap.get_cell_source_id(0, current) == 0:
				for tile in get_neighboring_tiles_list(current):
					if tilemap.get_cell_source_id(0, tile) in (land_tiles):
						tilemap.set_cell(0, Vector2i(tile.x, tile.y-1), 8, Vector2i(0, 0))


func _ready():
	randomize()
	generate_base()
	generate_land_mass()
	generate_beaches()
	





