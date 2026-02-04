class_name City
extends Node2D

var city_position: Vector2i
var connected_cities: Array[City] = []
signal user_select_city(city: City)

func _ready() -> void:
	self.global_position = city_position

	var w: float = (%Sprite2D as Sprite2D).texture.get_size().x / 2
	var h: float = (%Sprite2D as Sprite2D).texture.get_size().y / 2
	(%HighlightBox2D as Line2D).points = [
		Vector2(-w, -h),  # top-left
		Vector2(w, -h),   # top-right
		Vector2(w, h),    # bottom-right
		Vector2(-w, h),   # bottom-left
		Vector2(-w, -h)   # back to top-left to close the box
	]
	
	(%HighlightBox2D as Line2D).visible = false
	

func _process(_delta: float) -> void:
	pass
	

func addConnectedCity(city: City) -> void:
	connected_cities.append(city)


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("ui_select"):
		emit_signal("user_select_city", self)
		
func drawBox() -> void:
	(%HighlightBox2D as Line2D).visible = true
