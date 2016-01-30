extends KinematicBody2D

const SPEED = 160


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
		print("Collision")
		motion = get_collision_normal().slide( motion )
		attempts -= 1

func _ready():
	set_fixed_process( true )