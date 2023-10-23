extends CharacterBody2D

# Stores reference to the UI
@onready var ui: CanvasLayer = get_tree().root.find_child("UI")

# Movement Variables
@export var speed: int = 50

# Signals
signal playerInteracted

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called when input is detected and applies forward force to player based on pressed key
func _handleInput():
	var moveDirection = Input.get_vector("left", "right", "up", "down")
	velocity = moveDirection * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_handleInput()
	move_and_slide()
	
	# Resets the level upon pressing ENTER
	if Input.is_action_just_pressed("enter"):
		get_tree().reload_current_scene()
		
func die():
	get_tree().reload_current_scene()
	
# this is used to check if a collectable is within range of the player
func _on_area_2d_body_entered(body):
	print(body)
	if body.is_in_group("Collectable"):
		get_parent().store(body)
