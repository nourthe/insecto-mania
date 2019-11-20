extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$puntaje.text = "Puntuación: " + String(global.super_last_score)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_menu_pressed():
	global.to_scene("res://escenas/menu.tscn")


func _on_volver_pressed():
	global.to_scene("res://escenas/supervivencia.tscn")
