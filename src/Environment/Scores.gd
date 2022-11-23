extends Control
var main_menu = preload("res://src/Environment/GameMenu.tscn")
var score = HighScore.times_data.time
var player = HighScore.times_data.player
var score_placeholder = """[center]%s - %s 
------[/center]"""

func _ready():
	$Scores/ScoreList.bbcode_text = score_placeholder % [str(player),str(score)]
# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("ui_back"):
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(main_menu)
