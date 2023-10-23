extends Node2D

# Inventory
var inventory: Array[StaticBody2D]

# State Variables
var currentState: String = ""
var astronomer = preload("res://scenes/players/astronomer.tscn")
var werewolf = preload("res://scenes/players/werewolf.tscn")
var canInteract: bool

# Player variables
var player: CharacterBody2D
var spawnPos: Vector2
var timer: Timer

# Signals
signal playerInteracted

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnPos = $Spawnpoint.position	
	timer = $Timer
	canInteract = true
	_astronomer()

# This function calls when the interact button, in this case "e", is pressed


# Called when the conditions are met for the player to transform to astronomer
func _astronomer():
	if (currentState == "werewolf"):
		spawnPos = player.position
		remove_child(player)
		
	player = astronomer.instantiate()
	player.position = spawnPos
	add_child(player) # The player is instantiated into the scene
	currentState = "astronomer"
	#print(currentState)

# Called when the conditions are met for the player to transform to werewolf
func _werewolf():
	# When the player transforms, they will transform right where they are and their other form will be removed from the scene
	if (currentState == "astronomer"):
		spawnPos = player.position
		remove_child(player)
		
	player = werewolf.instantiate()
	player.position = spawnPos 
	add_child(player) # The player is instantiated into the scene
	currentState = "werewolf"
	#print(currentState)
	timer.start() # Begins the timer until the player is transformed back to human

# Transforms the player back to their human state
func _on_timer_timeout():
	_astronomer()
	
# Returns the current player position
func get_global_player_position():
	return player.get_global_position()

# When the signal in PlayerPositionHandler is triggered, this function is called.
# Therefore, the function is called when the player is on a moonlight tile
func _on_general_mechanics_player_entered_moonlight():
	print("Body has entered moonlight!")
	if (currentState == "astronomer"):
		#print("Transformation!")
		_werewolf()
		return
		
	#print("No transformation...")
	
func get_player():
	return player
	
func store(body):
	if ((body != null) && (inventory.has(body) == false)):
		inventory.append(body)
		body.queue_free()
		print("added " + body.to_string() + " to inventory")
	


