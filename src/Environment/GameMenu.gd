extends Control

func _ready():
	$AnimatedSprite.play("TitleScroll")


func _on_BeginButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/Main.tscn")


func _on_TutorialButton_pressed():
	get_tree().change_scene("res://src/Environment/Tutorial.tscn")

func _on_ScoresButton_pressed():
	#get_tree().change_scene()
	pass
