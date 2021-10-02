extends TileSet

export(Dictionary) var damageTiles: Dictionary

func _init() -> void:
	print_debug("hello")

func is_damage_tile(tile: Vector2) -> bool:
	return damageTiles.has(tile)
