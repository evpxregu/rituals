extends KinematicBody2D

const speed = 200

func _ready():
	set_fixed_process(true)
	

func _fixed_process(delta):
	
	var direction = Vector2(0,0)
	if ( Input.is_action_pressed("ui_up") ):
		direction += Vector2(0,-1)
	if ( Input.is_action_pressed("ui_down") ):
		direction += Vector2(0,1)
	if ( Input.is_action_pressed("ui_left") ):
		direction += Vector2(-1,0)
	if ( Input.is_action_pressed("ui_right") ):
		direction += Vector2(1,0)
		
	move( direction * speed * delta)
	if is_colliding():
		#print("Collision with ",get_collider())
		var n = get_collision_normal()
		direction = n.slide( direction )
		move(direction*speed*delta)

func _on_Area2D_body_enter( body ):
	print("Entered Area2D with body ", body)
func _on_Area2D_body_exit( body ):
	print("Exited Area2D with body ", body)