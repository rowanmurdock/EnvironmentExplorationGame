extends Node2D

@onready var tilemap = $TileMap

func _ready():
	print("in ready")
	print("running")
	randomize()  
	var width = 50
	var height = 30
	var tile_ids = [1, 2, 3, 4, 5, 6, 7]


	for x in range(width):
		for y in range(height):
			var rand_tile = tile_ids[randi() % tile_ids.size()]
			tilemap.set_cell(0, Vector2i(x, y), rand_tile, Vector2i(0, 0))



