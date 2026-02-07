extends Node2D

func _ready() -> void:
	pass

func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_start_game_button_pressed() -> void:
	SceneSwitcher.switch_scene("uid://gnhb0bmfwp5c")


func _on_credits_button_pressed() -> void:
	SceneSwitcher.switch_scene("uid://vwcwry2ct878")
