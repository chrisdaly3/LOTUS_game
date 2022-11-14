extends ViewportContainer

func _ready():
	$AnimatedSprite.play("default")

func _on_Timer_timeout():
	$Retry.show(); $ExitToMenu.show()


func _on_ExitToMenu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/Environment/GameMenu.tscn")


func _on_Retry_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/Main.tscn")
