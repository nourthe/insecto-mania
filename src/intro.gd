extends Node

func _ready():
	get_node("intro").play("mueve_bola")
	pass

func _input(event):
	if event is InputEventKey:
		finalizar()
	elif event is InputEventMouseButton:
		finalizar()
		
func on_intro_end(anim_name):
	finalizar()
	
func finalizar():
	get_tree().change_scene("res://escenas/menu.tscn")
