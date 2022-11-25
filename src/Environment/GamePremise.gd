extends Control

var main_menu = preload("res://src/Environment/GameMenu.tscn")

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("ui_back"):
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(main_menu)
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://src/Environment/Tutorial.tscn")
