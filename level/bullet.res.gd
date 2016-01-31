extends KinematicBody2D

const SPEED = 10
var Origin

func _fixed_process(delta):
	var direction = Vector2(cos(get_rot()), -sin(get_rot()))
	move(direction * SPEED)
	if(is_colliding() && get_collider().get_name().find("Bullet") == -1):
		self.queue_free()

func _ready():
	set_fixed_process(true)
	Origin = get_pos()