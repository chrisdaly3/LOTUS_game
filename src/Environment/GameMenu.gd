extends Control

func _ready():
	$AnimatedSprite.play("TitleScroll")
	HighScore.load_time()
	if AudioPlayer.get_node("Soundtrack").is_playing():
		AudioPlayer.get_node("Soundtrack").stop()
	AudioPlayer.get_node("Bells").play()


func _on_BeginButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/Environment/UserName.tscn")


func _on_TutorialButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/Environment/GamePremise.tscn")

func _on_ScoresButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/Environment/Scores.tscn")
