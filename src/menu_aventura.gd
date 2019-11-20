extends Control

func _ready():
	pass


func _on_menu_pressed():
	global.return_menu()


func _on_1():
	global.to_scene("res://escenas/aventura/1.tscn")


func _on_2():
	global.to_scene("res://escenas/aventura/2.tscn")


func _on_3_pressed():
	global.to_scene("res://escenas/aventura/3.tscn")
