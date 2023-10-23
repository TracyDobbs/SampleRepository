extends CharacterBody2D

# Movement Variables
@export var speed: int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Player is WEREWOLF!")
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
