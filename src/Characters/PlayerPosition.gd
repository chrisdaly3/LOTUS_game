extends Label
# REMOVE THIS IN PRODUCTION CODE -- FOR DEBUG PURPOSES
func _process(delta):
	text = str(owner.global_position)
