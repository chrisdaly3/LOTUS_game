extends Control
var main_menu = preload("res://src/Environment/GameMenu.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_back"):
		get_tree().change_scene_to(main_menu)
