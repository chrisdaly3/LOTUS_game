extends Node2D
var you_died = preload("res://src/Environment/DeathScreen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap.connect("win_con", self, "_on_win_con")
	

func _on_Player_died():
	get_tree().change_scene_to(you_died)

func _on_win_con():
	var player = $Player/AnimatedSprite
	player.play("finish")
