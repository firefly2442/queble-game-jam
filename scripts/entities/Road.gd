class_name Road
extends Node2D

var road_segments: int
var road_width: float = 26.0
var points: PackedVector2Array
var segment_colors: Array[Color]
var snow_amount: Array[float]
var start_city: City
var end_city: City

func _ready() -> void:
	pass

func init(city_one: City, city_two: City) -> void:
	start_city = city_one
	end_city = city_two
	
	var distance_between: float = start_city.city_position.distance_to(end_city.city_position)
	road_segments= ceili(distance_between / 16) # rounds up so no zeros
	
	for i in range(0, road_segments):
		segment_colors.append(Color.BLACK)
	
	var dir: Vector2 = end_city.city_position - start_city.city_position
	var step: Vector2 = dir / float(road_segments)
	
	for i in range(road_segments + 1):  # include start and end
		points.append(start_city.city_position as Vector2 + (step * i))
	
	# initialize snow levels for each road segment
	for i in range(road_segments):
		snow_amount.append(0.0)
	
func _process(delta: float) -> void:
	for i in range(road_segments):
		snow_amount[i] = min(snow_amount[i] + delta / GameState.snow_speed, 1.0)
	for i in range(0, segment_colors.size()):
		segment_colors[i] = Color.BLACK.lerp(Color.WHITE, snow_amount[i])
	queue_redraw()
	

func _draw() -> void:
	# draw the road edge first
	for i in range(points.size() - 1):
		draw_line(
			points[i],
			points[i + 1],
			Color.RED,
			road_width + 4
		)
	
	# then draw the road with snow over top of it
	for i in range(points.size() - 1):
		draw_line(
			points[i],
			points[i + 1],
			segment_colors[i],
			road_width
		)
	

func setSnowAmount(segment: int, amount: float) -> void:
	snow_amount[segment] = amount
