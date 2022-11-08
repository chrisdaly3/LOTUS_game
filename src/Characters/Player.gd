extends KinematicBody2D

var speed = 95
var velocity = Vector2()
var sonar = preload("res://src/Player_Tools/Sonar.tscn")
var screensize = get_viewport_rect().size

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

func _process(delta):
	user_shout()
	$Aimer.rotation = get_angle_to(get_global_mouse_position())

func _physics_process(delta):
	user_input()
	velocity = move_and_slide(velocity)

func user_shout():
	if Input.is_action_just_pressed("shout"):
		var sonar_instance = sonar.instance()
		sonar_instance.start($Aimer.global_position, $Aimer.rotation)
		owner.add_child(sonar_instance)
