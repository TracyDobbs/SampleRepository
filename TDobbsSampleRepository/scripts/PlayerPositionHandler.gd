extends Node2D

# Tile information
@onready var tileMap: TileMap = $TileMap
var tileData: TileData
var layer: int = 0

# Player information
@onready var playerHandler: Node2D = $PlayerHandler
var isPlayerInMoonlight: bool
signal playerEnteredMoonlight # This signal is sent out when a player is detected in a moonlight tile
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tilePlayerPosition: Vector2i = tileMap.local_to_map(playerHandler.get_global_player_position())
	tileData = tileMap.get_cell_tile_data(layer, tilePlayerPosition)
		
	# Ensures that code dependent on the presence of tile data does not run if tile data is null
	if (tileData):
#		print("Found tile data!")	
#		print(tileData)
		isPlayerInMoonlight = tileData.get_custom_data("moonlight")
	
	# Runs if the player is detected in moonlight tile
	if (isPlayerInMoonlight):
#		print("player detected in moonlight tile")
		playerEnteredMoonlight.emit()
