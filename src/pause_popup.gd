extends Popup

export (bool) var follow_player = true

signal paused
signal unpaused

# warning-ignore:unused_argument
func _input(event):
	if event.is_action_released('pause'):
		if !visible:
			pause()
		else:
			reanudar()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
		print("Windows quit request ignored.")
		pass        
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		# For Android
		#Input.action_press('pause')
		# I can't handle the pouse for now.
		pass

func pause():
	if get_parent().has_method("pause"):
		if get_parent().pause():
			visible = true
			emit_signal("paused")
	if follow_player:
		rect_position = get_parent().get_node("jugador").position


func reanudar():
	visible = false
	if get_parent().has_method("reanudar"):
		get_parent().reanudar()
		emit_signal("unpaused")
	else:
		print("Error in unpause.")

func _on_unpause_pressed():
	reanudar()

func _on_return_menu_pressed():
	get_tree().paused = false
	global.return_menu()

func _on_seleccion_pressed():
	get_tree().paused = false
	global.return_av_menu()
