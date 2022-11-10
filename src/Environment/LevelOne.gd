extends TileMap
signal win_con

# Called when the node enters the scene tree for the first time.
func _ready():
	$LevelComplete.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if "Player" in str(body):
		print("you won, nice!")
		body.set_process(false)
		body.set_physics_process(false)
		emit_signal("win_con")
