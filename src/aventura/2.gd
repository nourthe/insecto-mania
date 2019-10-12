extends "res://src/aventura/base.gd"

func _ready():
	addInsecticida(100, 200)
	addInsecticida(100, 350)
	addInsecticida(100, 500)
	presentacion = "Elimina a todos los insectos."
	for i in range(0, 3):
		for j in range(0,2):
			addInsecto(600 + i*40, 200 + j*60)
	
func _on_jugador_sin_balas():
	perdido()


func _on_base_objetos_updated():
	for objeto in objetos:
		if objeto is preload("res://src/insecto.gd"):
			print(objeto)
			return 0
	completado()


func _on_jugador_mori():
	perdido()
