extends Node2D

var image_list: Array[String] = ["uid://bv43g3rcv4jwj", "uid://ceq4p6wt3xybu"]
var image_index: int = 0

func _ready() -> void:
	(%ImageTimer as Timer).start()

func _on_exit_button_pressed() -> void:
	AudioManager.playUIClick()
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get_tree().quit()


func _on_start_game_button_pressed() -> void:
	AudioManager.playUIClick()
	SceneSwitcher.switch_scene("uid://gnhb0bmfwp5c")


func _on_credits_button_pressed() -> void:
	AudioManager.playUIClick()
	SceneSwitcher.switch_scene("uid://vwcwry2ct878")


func _on_check_button_pressed() -> void:
	AudioManager.playUISwitch()
	_toggle_fullscreen()

func _toggle_fullscreen() -> void:
	var is_fullscreen: bool = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _show_next_image() -> void:
	var tex_rect: TextureRect = %MenuTextureRect
	var next_index: int = (image_index + 1) % image_list.size()
	# Fade out
	var tween: Tween = create_tween()
	tween.tween_property(tex_rect, "modulate:a", 0.0, 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(func() -> void:
		tex_rect.texture = load(image_list[next_index])
	)
	tween.tween_property(tex_rect, "modulate:a", 1.0, 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

	image_index = next_index


func _on_image_timer_timeout() -> void:
	_show_next_image()
	(%ImageTimer as Timer).start()
