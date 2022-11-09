extends KinematicBody2D


var speed = 70
var velocity = Vector2()
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var random_direction = rng.randf_range(-2*PI, 2*PI)
	velocity = Vector2(speed,0).rotated(random_direction)
	add_to_group("Enemy")

func _physics_process(delta):
	var hit = move_and_collide(velocity * delta)
	if hit:
		handle_collision(hit)
		if "Player" in str(hit.collider):
			print("ok now what")
			queue_free()

func handle_collision(hit : KinematicCollision2D):
	velocity = velocity.bounce(hit.normal)
	rotation = velocity.angle()
