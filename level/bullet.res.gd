extends KinematicBody2D

const SPEED = 1000
var Origin

func _fixed_process(delta):
	move_local_y(delta * SPEED)
	if(abs(self.get_pos().distance_to(Origin)) > 5000):
		self.queue_free()
	if(is_colliding()):
		print(123)
		self.queue_free()

func _ready():
	set_fixed_process(true)
	Origin = get_pos()