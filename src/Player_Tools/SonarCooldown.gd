extends Control
signal sonar_ready

func _on_CooldownTimer_timeout():
	$ProgressBar.value+=.5

func _process(_delta):
	if $ProgressBar.value == 3:
		emit_signal("sonar_ready")
