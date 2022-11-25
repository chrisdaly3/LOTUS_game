extends KinematicBody2D
signal died

export var speed = 95
var velocity = Vector2()
var sonar = preload("res://src/Player_Tools/Sonar2.tscn")

func user_input():
	# accepts user input to move throughout the level
	velocity = Vector2()
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1
	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.stop()

func _process(_delta):
	# user_shout()
	$Aimer.rotation = get_angle_to(get_global_mouse_position())

func _physics_process(_delta):
	user_input()
	velocity = move_and_slide(velocity)
	for s in get_slide_count():
		var coll_info = get_slide_collision(s)
		if "Enemy" in str(coll_info.collider):
			player_killed()

func user_shout():
	if Input.is_action_just_pressed("shout"):
		var sonar_instance = sonar.instance()
		sonar_instance.position = self.global_position
		owner.add_child(sonar_instance)
		

func player_killed():
	emit_signal("died")
	set_physics_process(false)
	set_process(false)
	$AnimatedSprite.play("death")
