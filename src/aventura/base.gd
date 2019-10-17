extends "res://src/motor.gd"

var startTimer = Timer.new()

func _ready():
	connect_buttons()
	start_cuenta_atras()
	set_presentacion("Evita los insectos y encuentra la salida")
	get_tree().set_pause(true)

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
	$logrado_popup/cc/gc/siguiente.connect("pressed", self, "on_siguiente")
	$logrado_popup/cc/gc/return.connect("pressed", self, "on_return")
	$perdido_popup/cc/gc/reintentar.connect("pressed", self, "on_reintentar")
	$perdido_popup/cc/gc/return.connect("pressed", self, "on_return")
func start():
	$presentacion.hide()
	get_tree().paused = false
	
func completado():
	$animacion.play('logrado')
	$logrado_popup.rect_position = get_node("jugador").position
	$logrado_popup.show()

func perdido():
	$perdido_popup.rect_position = get_node("jugador").position
	$perdido_popup.show()

func on_siguiente():
	get_tree().change_scene("res://escenas/menu_aventura.tscn")
func on_reintentar():
	get_tree().reload_current_scene()
func on_return():
	get_tree().change_scene("res://escenas/menu_aventura.tscn")