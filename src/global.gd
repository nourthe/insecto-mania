extends Node

# warning-ignore:unused_class_variable
var version = "0.2"

var super_high_score = 0
var super_last_score = 0

func _ready():
	pass
func return_menu():
	print(get_tree().change_scene("res://escenas/menu.tscn"))
func return_av_menu():
	get_tree().change_scene("res://escenas/menu_aventura.tscn")