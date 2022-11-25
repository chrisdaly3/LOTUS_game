tool
extends Node

# Stores the user time data as a dictionary
var player_times :Array = []
var times_data = {
	"time": 0,
	"player": "PLAYER"
}

# writes the data to local files in JSON format
func save_time():
	player_times.append(times_data)
	var save_file = File.new()
	save_file.open("user://times.save", File.WRITE)
	save_file.store_var(player_times)
	save_file.close()

# Checks for the existence of a save file, and creates one if not already created.
# Loads list of player times for scores page
func load_time():
	var save_file = File.new()
	if not save_file.file_exists("user://times.save"):
		save_time()
		return
	save_file.open("user://times.save", File.READ)
	player_times = save_file.get_var()
	save_file.close()
