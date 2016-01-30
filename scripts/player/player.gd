extends KinematicBody2D

const SPEED = 160

#Current weapon
var weapon = "null"
var cam
var InsideColorRoom = true

func _fixed_process( delta ) :
	var motion = Vector2()
	
	
	if(Input.is_action_pressed("move_up")):
		motion += Vector2( 0, -1 )
	if(Input.is_action_pressed("move_down")):
		motion += Vector2( 0, 1 )
	if(Input.is_action_pressed("move_left")):
		motion += Vector2( -1, 0 )
	if(Input.is_action_pressed("move_right")):
		motion += Vector2( 1, 0 )
	
	motion = motion.normalized() * SPEED * delta
	motion = move( motion )
	
	var attempts = 4
	
	while(is_colliding() and attempts > 0 ):
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
	InsideColorRoom = true

func _on_Room_exit(body):
	InsideColorRoom = false

func WeaponEquipped():
	print(weapon + " weapon equipped")
	