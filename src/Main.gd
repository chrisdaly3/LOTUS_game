extends Node2D
var you_died = preload("res://src/Environment/DeathScreen.tscn")

func _ready():
# warning-ignore:return_value_discarded
	$TileMap.connect("win_con", self, "_on_win_con")
# warning-ignore:return_value_discarded
	$HUD/CountdownDisplay.connect("time_over", self, "_on_CountdownDisplay_time_over")
# warning-ignore:return_value_discarded
	$HUD/SonarCooldown.connect("sonar_ready", self, "_sonar_ready")

func _process(_delta):
	_sonar_ready()

func _on_Player_died():
	var timer = $HUD/CountdownDisplay/GameTimer
	timer.stop()
	yield($Player/AnimatedSprite, "animation_finished")
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(you_died)

func _on_win_con():
	var player = $Player/AnimatedSprite
	var timer = $HUD/CountdownDisplay/GameTimer
	timer.stop()
	player.play("finish")


func _on_CountdownDisplay_time_over():
	$Player.set_physics_process(false)
	$Player.set_process(false)
	$Player/AnimatedSprite.play("death")
	yield($Player/AnimatedSprite, "animation_finished")
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(you_died)

func _sonar_ready():
	var cooldown = $HUD/SonarCooldown/ProgressBar
	if cooldown.value < 3 and Input.is_action_just_pressed("shout"):
		pass
	if cooldown.value == 3 and Input.is_action_just_pressed("shout"):
		$Player.user_shout()
		cooldown.value = 0
