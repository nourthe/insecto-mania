extends Popup

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#func _process(delta):
		
func _input(event):
	if Input.is_action_pressed('pause'):
		visible = !visible
		get_tree().paused = visible