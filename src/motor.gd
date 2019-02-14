extends Node

var TAMANO_PANTALLA_X = 1024
var TAMANO_PANTALLA_Y = 600
var MARGEN_INSECTOS = 100

var objetos
var jugador

func _ready():
	leerObjetos()
	
func tapizar():
	$fondo/tapiz.rect_size.x = TAMANO_PANTALLA_X
	$fondo/tapiz.rect_size.y = TAMANO_PANTALLA_Y
	
func leerObjetos():
	objetos = get_children()
func remover_objeto(obj):
	if objetos.find(obj) == -1 :
		return false
	else:
		objetos.erase(obj)
		obj.queue_free()
		return true

func _process(delta):
	for objeto in objetos:
		if objeto.get_class() == "KinematicBody2D":
			comprobarPosicion(objeto)
		if objeto.get_class() == "StaticBody2D":
			objeto.scale = objeto.scale*(1-delta*0.25)
			if objeto.scale.x < 0.2:
				remover_objeto(objeto)
	

func comprobarPosicion(obj):
	if obj.position.x >TAMANO_PANTALLA_X:
		obj.position.x = 0
	elif obj.position.x < 0:
		obj.position.x = TAMANO_PANTALLA_X
	elif obj.position.y > TAMANO_PANTALLA_Y:
		obj.position.y = 0
	elif obj.position.y < 0:
		obj.position.y = TAMANO_PANTALLA_Y
		
#Añade el objecto [objectString] en la posición (posX,posY)
func addObject(objectString, posX, posY):
	var obj
	match objectString:
		"insecto":
			obj = preload("res://objects/insecto.tscn").instance()
		"insecticida":
			obj = preload("res://objects/insecticida.tscn").instance()
	obj.position.x = posX
	obj.position.y = posY
	add_child(obj)
	leerObjetos()
	
#Añade un insecto en la posicion (posX,posY)
func addInsecto(posX, posY):
	addObject("insecto", posX, posY)
	
#Añade un insecticida en la posición (posX,posY)
func addInsecticida(posX, posY):
	addObject("insecticida", posX, posY)
	
#Añade un insecto en una posicion aleatoria
func addRandObject(objectString):
	var mi = MARGEN_INSECTOS
	randomize()
	var x = rand_range(mi,TAMANO_PANTALLA_X-mi)
	var y = rand_range(mi,TAMANO_PANTALLA_Y-mi)	
	addObject(objectString, x, y)

func reanudar():
	get_node("pause_popup").hide()
	get_tree().paused = false

func gameOver():
	global.super_last_score = jugador.get_puntos()
	get_tree().change_scene("res://escenas/game_over.tscn")
