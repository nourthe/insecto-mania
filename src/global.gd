extends Node

# warning-ignore:unused_class_variable
var version = "0.2"

# warning-ignore:unused_class_variable
var super_high_score = 0
# warning-ignore:unused_class_variable
var super_last_score = 0


var current_scene = null



func _ready():
	update_scene()

func update_scene():
	var root = get_tree().get_root()
	var new_scene = root.get_child(root.get_child_count() - 1)
	current_scene = new_scene

func reload_current_scene():
	if get_tree().reload_current_scene() != 0:
		print("Error")
	yield(get_tree(), "tree_changed")
	update_scene()


func change_scene_to(scene):
	call_deferred("_deferred_change_scene_to", scene)
	
func _deferred_change_scene_to(scene):
	if get_tree().change_scene_to(scene) != 0:
		print("global: Error trying to change scene to a packed scene.")
	update_scene()


func to_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	update_scene()
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)

func return_menu():
	to_scene("res://escenas/menu.tscn")
func return_av_menu():
	to_scene("res://escenas/menu_aventura.tscn")