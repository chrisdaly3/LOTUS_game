extends Node2D
var you_died = preload("res://src/Environment/DeathScreen.tscn")
var enemy = preload("res://src/Characters/Enemy.tscn")
export(int) var enemies = 0
var start_time
var end_time

func _ready():
# warning-ignore:return_value_discarded
	$TileMap.connect("win_con", self, "_on_win_con")
# warning-ignore:return_value_discarded
	$HUD/CountdownDisplay.connect("time_over", self, "_on_CountdownDisplay_time_over")
# warning-ignore:return_value_discarded
	$HUD/SonarCooldown.connect("sonar_ready", self, "_sonar_ready")
	get_player_spawn()
	set_exit()
	for x in enemies:
		spawn_enemies()
	start_time = Time.get_ticks_msec()
	

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
	end_time = Time.get_ticks_msec()
	HighScore.times_data.time = end_time - start_time
	HighScore.save_time()
	player.play("finish")
	yield($Player/AnimatedSprite, "animation_finished")
	get_tree().change_scene("res://src/Environment/Scores.tscn")


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

# Finds global position of created cave procedural generation, and returns random ground tile near top of array. 
# Value is used to spawn player outside of a collision object.
func get_player_spawn():
	var ground_tiles = $TileMap.get_used_cells_by_id(0)
	var spawn_options = []
	for tiles in ground_tiles:
		var left := Vector2(tiles.x-1, tiles.y)
		var up := Vector2(tiles.x, tiles.y-1)
		var right := Vector2(tiles.x+1, tiles.y)
		if left in ground_tiles and right in ground_tiles and up in ground_tiles and tiles.y <= 8:
			spawn_options.append(tiles)
	for i in range(spawn_options.size()):
		spawn_options[i] = $TileMap.to_global($TileMap.map_to_world(spawn_options[i]))
	$Player.global_position = spawn_options[randi() % spawn_options.size()]

func set_exit():
	# Collects all tiles in global coordinates and finds a randomized conditional block to place the level exit
	var roof_tiles : Array = $TileMap.get_used_cells_by_id(1)
	var ground_tiles : Array = $TileMap.get_used_cells_by_id(0)
	var potential_exits := []
	var exit_pos = $TileMap/LevelComplete.position
	for tiles in roof_tiles:
		var left := Vector2(tiles.x-1, tiles.y)
		var up := Vector2(tiles.x, tiles.y-1)
		var right := Vector2(tiles.x+1, tiles.y)
		if left in roof_tiles and right in roof_tiles and up in ground_tiles and tiles.y >= 38:
			potential_exits.append(tiles)
	for i in range(potential_exits.size()):
		potential_exits[i] = $TileMap.to_global($TileMap.map_to_world(potential_exits[i]))
	exit_pos = potential_exits[randi() % potential_exits.size()]
	$TileMap/LevelComplete.position = exit_pos

func spawn_enemies():
	var ground_tiles = $TileMap.get_used_cells_by_id(0)
	var spawn_options = []
	var enemy_instance = enemy.instance()
	for tiles in ground_tiles:
		var left := Vector2(tiles.x-1, tiles.y)
		var up := Vector2(tiles.x, tiles.y-1)
		var right := Vector2(tiles.x+1, tiles.y)
		if left in ground_tiles and right in ground_tiles and up in ground_tiles:
			spawn_options.append(tiles)
	for i in range(spawn_options.size()):
		spawn_options[i] = $TileMap.to_global($TileMap.map_to_world(spawn_options[i]))
	enemy_instance.global_position = spawn_options[randi() % spawn_options.size()]
	add_child(enemy_instance)
