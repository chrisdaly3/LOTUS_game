tool
extends Node

# Stores the user time data as a dictionary
var times_data = {
	"time": 0,
	"player": "PLAYER"
}

# writes the data to local files in JSON format
func save_time():
	var save_file = File.new()
	save_file.open("user://times.save", File.WRITE)
	save_file.store_line(to_json(times_data))
	save_file.close()

# Checks for the existence of a save file, and if it doesn't exist it gets created.
func load_time():
	var save_file = File.new()
	if not save_file.file_exists("user://times.save"):
		save_time()
		return
	save_file.open("user://times.save", File.READ)
	var data = parse_json(save_file.get_as_text())
	
	times_data.time = data.time
	times_data.player = data.player
