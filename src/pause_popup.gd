extends Popup

func _input(event):
	if Input.is_action_pressed('pause'):
		visible = !visible
		get_tree().paused = visible
		rect_position = get_parent().get_node("jugador").position

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

func reanudar():
	if get_parent().has_method("reanudar"):
		get_parent().reanudar()

func _on_unpause_pressed():
	reanudar()


func _on_return_menu_pressed():
	reanudar()
	global.return_menu()


func _on_seleccion_pressed():
	reanudar()
	global.return_av_menu()
