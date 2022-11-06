extends Area2D

var speed = 95
var screen_size

# sends var to inspector for use:
export(PackedScene) var echo

# gets size of screen, and hides character until ready for use.
func _ready():
	screen_size = get_viewport_rect().size
	# hide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO #set player's starting movement vector
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1
	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.stop()
		
	# update player position with animations	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#flip character image depending on direction (left or right)
	$AnimatedSprite.flip_h = velocity.x < 0
	
	if Input.is_action_just_pressed("shout"):
		shout()
	
func shout():
	var e = echo.instance()
	owner.add_child(e)
	e.transform = global_transform
