extends Node2D

const SPEED = 80
var rotat
var motion = Vector2(0,1)

func _process(delta):
	
	move_local_y(delta * SPEED)

func _ready():
	set_process(true)


func set_motion(newMotion):
	motion = newMotion
	