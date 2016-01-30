extends Node2D

const SPEED = 220
const shootSpeed = 3
var shootBack = true
var lastShot = 0;


func _process(delta):
	var heroObject = get_parent().find_node("hero")
	var newAngle = self.get_pos().angle_to_point(heroObject.get_pos())
	var bullet = get_parent().find_node("bullet");
	
	#print(delta)
	lastShot += delta
	if lastShot > shootSpeed:
		lastShot = 0
		var bulletScene = preload("res://bullet.scn")
		var newBullet = bulletScene.instance()
		
		newBullet.set_pos(self.get_pos())
		newBullet.look_at(heroObject.get_pos())
		newBullet.move_local_y(30)
		newBullet.move_local_x(-10)
		# rad2deg
		print(get_rot())
		
		#newBullet.set_motion(self.get_rot())
		get_parent().add_child(newBullet)
	
	
	
	self.set_rot(newAngle)

func _ready():
	set_process(true)