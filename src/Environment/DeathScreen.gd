extends ViewportContainer

func _ready():
	$AnimatedSprite.play("default")

func _on_Timer_timeout():
	$Retry.show(); $ExitToMenu.show()


func _on_ExitToMenu_pressed():
	pass # Replace with function body.


func _on_Retry_pressed():
	get_tree().change_scene("res://src/Main.tscn")
