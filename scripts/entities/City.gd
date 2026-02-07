class_name City
extends Node2D

var city_position: Vector2i
var connected_cities: Array[City] = []
signal user_select_city(city: City)
@export var people_speed: float = 15.0
var number_people_waiting: int = 1

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
	
	(%PeopleTimer as Timer).start(people_speed)
	
	self.add_to_group("city")
	

func _process(_delta: float) -> void:
	(%PeopleLabel as Label).text = str(number_people_waiting)
	

func addConnectedCity(city: City) -> void:
	connected_cities.append(city)


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("ui_select"):
		emit_signal("user_select_city", self)
		
		
func drawBox(val: bool = true, color: Color = Color.AQUA) -> void:
	(%HighlightBox2D as Line2D).visible = val
	(%HighlightBox2D as Line2D).modulate = color

func _on_people_timer_timeout() -> void:
	number_people_waiting += 1
	(%PeopleLabel as Label).text = str(number_people_waiting)
