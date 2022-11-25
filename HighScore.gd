tool
extends Node

# Stores the user time data as a dictionary
var player_times :Array = []
var times_data = {
	"time": 0,
	"player": "PLAYER"
}

# Writes user times to local file for persistent leaderboard.
func save_time():
	var save_file = File.new()
	if save_file.file_exists("user://times.save") and str(player_times[0]) == "{player:PLAYER, time:0}":
		player_times.clear()
	player_times.append(times_data)
	save_file.open("user://times.save", File.WRITE)
	save_file.store_var(player_times)
	save_file.close()

# Checks for the existence of a save file, and pulls player scores if it exists.
func load_time():
	var save_file = File.new()
	if not save_file.file_exists("user://times.save"):
		return
	save_file.open("user://times.save", File.READ)
	player_times = save_file.get_var()
	save_file.close()
