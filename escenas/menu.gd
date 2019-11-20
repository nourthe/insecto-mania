extends Node


func _ready():
	$version.text = "Version: " + global.version

func on_salir():
	get_tree().quit()

func on_super():
	global.to_scene("res://escenas/supervivencia.tscn")

func _on_aventura():
	global.to_scene("res://escenas/menu_aventura.tscn")

func _on_como():
	$MarginContainer/como_popup.show()

func _on_como_hide():
	$MarginContainer/como_popup.hide()
