extends Control

onready var main_game = preload("res://src/Main.tscn")

# When user enters their initials, it sets the save state data needed for high score recording.
func _on_TextEdit_text_entered(_new_text):
	HighScore.times_data.player = $TextEdit.text
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(main_game)
