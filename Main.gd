extends Node2D

@onready var tilemap = $TerrainMap
@export var width = 1000
@export var height = 500
@export var land_tiles = [ 1, 2, 3, 4, 5, 6]

func generate_base():
	var ocean_tile_id = 0
	for x in range(width):
		for y in range(height):
			tilemap.set_cell(0, Vector2i(x, y), ocean_tile_id, Vector2i(0, 0))


func get_starting_pos() -> Vector2i:
	for x in range(width):
		for y in range(height):
			var current = Vector2i(x, y)
			if tilemap.get_cell_source_id(0, current) in land_tiles:
				return current
	return Vector2i(width/2, height/2)

func generate_land_mass(start_pos := Vector2i(width / 2, height / 2), steps := 5000):
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
	
func get_width() -> int:
	return width
	


func generate_beaches():
	var beach_positions = []
	for x in range(width):
		for y in range(height):
			var current = Vector2i(x, y)
			var rand_beach = randi() % 5
			if tilemap.get_cell_source_id(0, current) == 0:
				for neighbor in get_neighboring_tiles_list(current):
					if tilemap.get_cell_source_id(0, neighbor) in land_tiles:
						beach_positions.append(current)
						break
	for pos in beach_positions:
		tilemap.set_cell(0, pos, 8, Vector2i(0, 0))


func _ready():
	randomize()
	generate_base()
	generate_land_mass()
	generate_beaches()
	





