extends Node2D

onready var tween = $SonarExpand

func _ready():
	tween.interpolate_property($Light2D,"texture_scale", 0, 8, .5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	self.queue_free()
