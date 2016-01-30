extends Node2D

const SPEED = 220

func _process(delta):
	var motion = Vector2()
	var pos = get_pos()
	pos += motion*delta*SPEED
	
	set_pos(pos)
	

func _ready():
	set_process(true)