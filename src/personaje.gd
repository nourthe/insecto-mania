extends KinematicBody2D

export (int) var speed = 200

var TIEMPO_INMUNIDAD = 3.5
var DELAY_DISPARO = 0.2
export var VIDAS = 15
export var DISPAROS_POR_INSECTICIDA = 6

var velocity = Vector2()

var acelerado = Vector2(0,0)

var inmune
var delay_disparo

var vivo = true
var puntos = 0
var disparos = 0

signal sin_balas
signal mori

func _ready():
	inmune = $inmune
	delay_disparo = $delay_disparo
	inmune.set_wait_time(TIEMPO_INMUNIDAD)
	delay_disparo.set_wait_time(DELAY_DISPARO)
	inmune.start()
	set_inmunidad_shader(true)


func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('pj_right'):
        velocity.x += 1
    if Input.is_action_pressed('pj_left'):
        velocity.x -= 1
    if Input.is_action_pressed('pj_down'):
        velocity.y += 1
    if Input.is_action_pressed('pj_up'):
        velocity.y -= 1
    velocity = velocity.normalized() * speed
func _input(event):
	if Input.is_action_pressed("pj_shoot"):
		disparar()
func _physics_process(delta):
	if vivo:
		var collision
		if acelerado.length()<0.2:
			get_input()
			collision = move_and_collide(velocity * delta)
		else:
			collision = move_and_collide(acelerado*delta*400)
			acelerado*=0.9
		if collision:
			if collision.collider.is_in_group("insecticida"):
				var resultado = get_parent().remover_objeto(collision.collider)
				if resultado:
					disparos += DISPAROS_POR_INSECTICIDA
				$disparo.show()
	if inmune.is_stopped():
		set_inmunidad_shader(false)
	if velocity != Vector2.ZERO:
		$disparo.rotation = velocity.angle()

func hit(direccion):
	acelerado = -direccion
	if(inmune.is_stopped()):
		inmune.start()
		set_inmunidad_shader(true)
		VIDAS -= 1
	if VIDAS>0:
		randomize()
		$pain.pitch_scale = rand_range(0.91,1.03)
		$pain.play()
	else:
		emit_signal("mori")
		morir()

func morir():
	vivo = false
	#emit_signal("mori")

func disparar():
	if disparos > 0 and delay_disparo.is_stopped():
		delay_disparo.start()
		$disparo.disparar()
		disparos -= 1
		if disparos == 0:
			$disparo.hide()
			emit_signal("sin_balas")
func get_puntos():
	return floor(puntos)
	
func set_inmunidad_shader(inmunidad):
	$textura.get_material().set_shader_param("inmune", inmunidad)
	$cola.get_material().set_shader_param("inmune", inmunidad)
