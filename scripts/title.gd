extends ColorRect

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/level_home.tscn")
