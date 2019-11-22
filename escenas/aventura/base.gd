extends Motor
class_name Base
export (PackedScene) var next_scene
var startTimer = Timer.new()
var logrado = false

func _ready():
	$animacion.stop(false)
	
	connect_buttons()
	start_cuenta_atras()
	set_presentacion("Evita los insectos y encuentra la salida")
	pause()

func set_presentacion(presentacion):
	$presentacion/cc/Label.set_text(presentacion)
	$presentacion.show()
	
func start_cuenta_atras():
	add_child(startTimer)
	startTimer.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	startTimer.connect("timeout", self, "start")
	startTimer.wait_time = 3.0
	startTimer.one_shot = true
	startTimer.start()
	
func connect_buttons():
	var error = 0
	error += $logrado_popup/cc/gc/siguiente.connect("pressed", self, "on_siguiente")
	error += $logrado_popup/cc/gc/return.connect("pressed", self, "on_return")
	error += $perdido_popup/cc/gc/reintentar.connect("pressed", self, "on_reintentar")
	error += $perdido_popup/cc/gc/return.connect("pressed", self, "on_return")
	if not error == 0:
		print("Error connecting buttons.")

func start():
	$presentacion.hide()
	reanudar()

func completado():
	logrado = true
	remover_objeto($jugador)
	$logrado_popup.rect_position = get_node("jugador").position
	$logrado_popup.show()

func perdido():
	$perdido_popup.rect_position = get_node("jugador").position
	$perdido_popup.show()

func on_siguiente():
	global.change_scene_to(next_scene)
	
func on_reintentar():
	global.reload_current_scene()

func on_return():
	global.to_scene("res://escenas/menu_aventura.tscn")

func _on_exit_body_entered(body):
	if body == $jugador:
		$animacion.play('logrado')
		yield($animacion, "animation_finished")
		completado()

# Override
func pause():
	if not logrado:
		get_tree().paused = true
		return true
	else:
		return false

func _on_popup_paused():
	startTimer.paused = true

func _on_popup_unpaused():
	if startTimer.time_left != 0:
		get_tree().paused = true
		startTimer.paused = false
