extends CanvasLayer

# Variables
# UI Components
# Dialogue
@export var dialogueComponent: ColorRect
@export var dialogueLabel: Label

# Death screen
@export var deathScreenComponent: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_mode(false) # Disable the dialogue component on ready
	death_screen_mode(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# When called, the visibility of the dialogue component is toggled
func dialogue_mode(toggle):
	dialogueComponent.visible = toggle
			
# This function can set the content of the dialogue label
func dialogue_text(text: String):
	dialogueLabel.text = text
	
func death_screen_mode(toggle):
	deathScreenComponent.visible = toggle
