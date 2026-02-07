extends Node2D

func _ready() -> void:
	pass

func _on_exit_button_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get_tree().quit()


func _on_start_game_button_pressed() -> void:
	SceneSwitcher.switch_scene("uid://gnhb0bmfwp5c")


func _on_credits_button_pressed() -> void:
	SceneSwitcher.switch_scene("uid://vwcwry2ct878")


func _on_check_button_pressed() -> void:
	_toggle_fullscreen()

func _toggle_fullscreen() -> void:
	var is_fullscreen: bool = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
