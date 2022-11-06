extends KinematicBody2D

var speed = 70

var velocity = Vector2(speed,0)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		handle_collision(collision)
		$SonarTimer.start()

func handle_collision(collision : KinematicCollision2D):
	velocity = velocity.bounce(collision.normal)
	rotation = velocity.angle()

func _on_SonarTimer_timeout():
	queue_free()
