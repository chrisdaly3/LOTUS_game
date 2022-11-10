extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", owner, "_on_body_entered")
