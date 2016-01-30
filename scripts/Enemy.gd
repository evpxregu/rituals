extends KinematicBody2D

const SPEED = 160
var lastShot = 0
const shootSpeed = 1

func _fixed_process( delta ):
	var motion = Vector2(0,0)
	var heroObject = get_node("../hero")
	if(heroObject != null):
		var newAngle = self.get_pos().angle_to_point(heroObject.get_pos())
		
		lastShot += delta
		if lastShot > shootSpeed:
			lastShot = 0
			var bulletScene = preload("res://bullet.scn")
			var newBullet = bulletScene.instance()
			
			newBullet.set_pos(self.get_pos())
			newBullet.look_at(heroObject.get_pos())
			newBullet.move_local_y(20)
			newBullet.move_local_x(-30)
			# rad2deg
			print(get_rot())
			
			#newBullet.set_motion(self.get_rot())
			get_parent().find_node("EnemyBullets").add_child(newBullet,true)
		
		self.set_rot(newAngle)
		
	motion = move( motion )
	
	var attempts = 4
	
	while(is_colliding() and attempts > 0 ):
		var collidingWith =  get_collider()
		if(collidingWith.get_parent().get_name() == "Bullets"):
			self.queue_free()
			collidingWith.queue_free()
			

		motion = get_collision_normal().slide( motion )
		attempts -= 1
	


func _ready():
	set_fixed_process( true )