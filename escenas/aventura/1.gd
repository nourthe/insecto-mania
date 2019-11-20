extends Base

func _ready():
	TAMANO_PANTALLA_X = 2000
	TAMANO_PANTALLA_Y = 1200
	tapizar()
	for i in range(30):
		addInsecto(i*30,100)
	pass

# warning-ignore:unused_argument
func _process(delta):
	if jugador.VIDAS < 1:
		jugador.morir()
		perdido()

func _on_exit_body_entered(body):
	if body == $jugador:
		completado()
