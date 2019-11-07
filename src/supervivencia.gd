extends "motor.gd"

# Duracion de cada etapa en segundos
export var DURACION_ETAPA = 6
export(float, 0, 1) var PROBABILIDAD_INSECTICIDA = 0.35
export(float, 0, 1) var PROBABILIDAD_CORAZON = 0.35

var etapa

func _ready():
	jugador.puntos = 0
	etapa = 1
	randomize()

func _process(delta):
	actualizarTextos()
	jugador.puntos += delta
	actualizarEtapa()
	if jugador.VIDAS < 1 :
		gameOver()

func actualizarTextos():
	$textos/puntos.set_text("Puntaje: " + String(jugador.get_puntos()))
	$textos/vidas.set_text("Vidas: " + String(jugador.VIDAS))
	$textos/disparos.set_text("Disparos: " + String(jugador.disparos))

func actualizarEtapa():
	if jugador.puntos >= etapa*DURACION_ETAPA :
		addRandObject("insecto", Rect2(jugador.position - Vector2(100,100), Vector2(200, 200)))
		etapa += 1
		var rand
		rand = rand_range(0,100)
		if rand < PROBABILIDAD_INSECTICIDA*100 :
			addRandObject("insecticida", Rect2(jugador.position - Vector2(100,100), Vector2(200, 200)))
		rand = rand_range(0,100)
		if rand < PROBABILIDAD_CORAZON*100 :
			addRandObject("corazon", Rect2(jugador.position - Vector2(100,100), Vector2(200, 200)))
