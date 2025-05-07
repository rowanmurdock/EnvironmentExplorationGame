extends Node2D

@onready var tilemap = $TileMap


func _ready():
	randomize()  
	var width = 1000
	var height = 500
	var tile_ids = [1, 2, 3, 4, 5, 6, 7]
	var ocean_tile_id = 0
	var border_tile_ids = [0, 8]
	var border_width = 7

	for x in range(width):
		for y in range(height):
			var is_ocean = (
				x < border_width or x >= width - border_width or
				y < border_width or y >= height - border_width
			)
			var is_border = ((x <= 993 and x > 990) or (x >= 7 and x < 10) or (y <= 493 and y > 490) or (y >= 7 and y < 10))

			if is_ocean:
				tilemap.set_cell(0, Vector2i(x, y), ocean_tile_id, Vector2i(0, 0))
			elif is_border:
				var rand_tile = border_tile_ids[randi() % border_tile_ids.size()]
				tilemap.set_cell(0, Vector2i(x, y), rand_tile, Vector2i(0, 0))
			else:
				var rand_tile = tile_ids[randi() % tile_ids.size()]
				tilemap.set_cell(0, Vector2i(x, y), rand_tile, Vector2i(0, 0))
				




