extends Area2D

var disparando = false

func _ready():
	pass
func disparar():
	var nuevo = duplicate()
	get_parent().add_child(nuevo)
	nuevo.disparando = true

func _process(delta):
	if disparando:
		position += Vector2(50,0).rotated(rotation)
		if global_position.x > 1200 or global_position.x < -100:
			queue_free()
		if global_position.y > 700 or global_position.y < -100:
			queue_free()
	else:
		var dif = (1 - get_parent().get_node("delay_disparo").time_left * 2.63)
		modulate.g = dif
		modulate.b = dif

func _on_disparo_body_entered(body):
	if disparando:
		if body is preload("res://src/insecto.gd"):
			var arr = get_parent().get_parent().objetos
			if arr.find(body):
				arr.erase(body)
				body.queue_free()
	else:
		print("La bala la toco pero esta desactivada.")
