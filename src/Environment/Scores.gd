extends Control
var main_menu = preload("res://src/Environment/GameMenu.tscn")
var score_placeholder = """[center]{player} - {time} 
--------[/center]"""
# custom class needed for array sorting based on internal dictionary vars
class TimeSorter:
	static func sort(a, b):
		if a["time"] < b["time"]:
			return true
		return false

func _ready():
	var text_block = $Scores/ScoreList
	# Sorts the array of dictionaries based on fastest times
	HighScore.player_times.sort_custom(TimeSorter, "sort")
	# Adds each recorded player time to the All-Time Scores list
	for dicts in HighScore.player_times:
		text_block.append_bbcode(score_placeholder.format([["player",dicts["player"]], ["time", dicts["time"]]]))

func _process(_delta):
	if Input.is_action_just_pressed("ui_back"):
# warning-ignore:return_value_discarded
		get_tree().change_scene_to(main_menu)
