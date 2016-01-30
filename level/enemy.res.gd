extends Node2D

const SPEED = 220
var shootBack = true

func _process(delta):
	var heroObject = get_parent().find_node("hero")
	var newAngle = self.get_pos().angle_to_point( heroObject.get_pos())
	self.set_rot(newAngle)

func _ready():
	set_process(true)