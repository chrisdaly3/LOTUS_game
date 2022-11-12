extends Control

export (int) var seconds = 1
var dsec = 0
signal time_over

func _process(_delta):
	if seconds > 0 and dsec <= 0:
		seconds -= 1
		dsec = 10
	if seconds >= 10:
		$Seconds.set_text(str(seconds))
	elif seconds < 10:
		$Seconds.set_text("0" + str(seconds))
	if dsec >= 10:
		$Deciseconds.set_text(str(dsec))
	elif dsec < 10:
		$Deciseconds.set_text("0" + str(dsec))
	
	if seconds < 10:
		$Seconds.add_color_override("default_color", Color(.81,.33,.33,1))
		$Deciseconds.add_color_override("default_color", Color(.81,.33,.33,1))
	
	if seconds < 5:
		$Seconds.add_color_override("default_color", Color(1,0,0,1))
		$Deciseconds.add_color_override("default_color", Color(1,0,0,1))
	
	if seconds == 0 and dsec == 0:
		emit_signal("time_over")
		queue_free()
		

func _on_GameTimer_timeout():
	dsec -= 1
