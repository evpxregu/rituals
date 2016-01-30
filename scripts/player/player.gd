extends KinematicBody2D

const SPEED = 800

#Current weapon
var weapon = "null"
var cam
var InsideColorRoom = true

func _fixed_process( delta ):
	var motion = Vector2()
	if(is_colliding()):
		print("RICK IS DOM")
	
	if(Input.is_action_pressed("move_up")):
		motion += Vector2( 0, -1 )
	if(Input.is_action_pressed("move_down")):
		motion += Vector2( 0, 1 )
	if(Input.is_action_pressed("move_left")):
		motion += Vector2( -1, 0 )
	if(Input.is_action_pressed("move_right")):
		motion += Vector2( 1, 0 )
	if(Input.is_action_pressed("shoot")):
		var dirToShoot = get_rot()
		
		#shootDirection.
		var bulletScene = preload("res://bullet.scn")
		var newBullet = bulletScene.instance()
		
		newBullet.set_pos(self.get_pos())
		newBullet.set_rot(dirToShoot)
		newBullet.move_local_y(45)
		newBullet.move_local_x(-20)
		get_parent().find_node("Bullets").add_child(newBullet)
		
	rotate(-Input.get_joy_axis(0,JOY_ANALOG_1_X) / 20)
	
	
	motion = motion.normalized() * SPEED * delta
	motion = move( motion )
	
	var attempts = 4
	
	while(is_colliding() and attempts > 0 ):
		var collidingWith =  get_collider()
		#if(collidingWith.get_parent().get_name() == "EnemyBullets"):
		#	self.queue_free()
		#	collidingWith.queue_free()
			
		

		motion = get_collision_normal().slide( motion )
		attempts -= 1
	
	#HACKING CAMERA ZOOM
	var CamZoom = cam.get_zoom()
	if(InsideColorRoom):
		if(CamZoom.x > 1):
			cam.set_zoom(CamZoom - Vector2(0.05,0.05))
	else:
		if(CamZoom.x < 3):
			cam.set_zoom(CamZoom + Vector2(0.05,0.05))

func _ready():
	set_fixed_process( true )

	get_node("../GreenWeap").connect("body_enter",self,"_on_Green_body_enter")
	get_node("../BlueWeap").connect("body_enter",self,"_on_Blue_body_enter")
	get_node("../BrownWeap").connect("body_enter",self,"_on_Brown_body_enter")
	get_node("../ColorRoom").connect("body_enter",self,"_on_Room_enter")
	get_node("../ColorRoom").connect("body_exit",self,"_on_Room_exit")
	
	cam = get_node("Camera2D")
	
func _on_Green_body_enter(body):
	weapon = "Green"
	WeaponEquipped()
		
func _on_Blue_body_enter(body):
	weapon = "Blue"
	WeaponEquipped()
		
func _on_Brown_body_enter(body):
	weapon = "Brown"
	WeaponEquipped()

func _on_Room_enter(body):
	if(body.get_name() != "hero"):
		return
	InsideColorRoom = true

func _on_Room_exit(body):
	if(body.get_name() != "hero"):
		return
	InsideColorRoom = false

func WeaponEquipped():
	print(weapon + " weapon equipped")