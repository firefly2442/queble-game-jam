class_name Dragon
extends Node2D

var starting_city: City ## the city the dragon is starting from
var ending_city: City ## the city the dragon is moving towards
var road: Road ## the road the dragon is on
@export var speed: float = 40
var segment_index: int = 0
var segment_t: float = 0.0
var increasing_segment_index: bool = true

func _ready() -> void:
	self.global_position = starting_city.city_position

func hasMoreSegments() -> bool:
	return (increasing_segment_index and segment_index < road.points.size() - 1) \
		or (not increasing_segment_index and segment_index > 0)

func _process(delta: float) -> void:
	if not ending_city:
		ending_city = starting_city.connected_cities.pick_random()
	
	if not road:
		road = Utility.getRoadFromCities(starting_city, ending_city)
		if road.start_city == starting_city:
			segment_index = 0
			increasing_segment_index = true
		else:
			segment_index = road.road_segments-1
			increasing_segment_index = false

	if not starting_city or not ending_city or not road:
		return
	
	var distance_left: float = speed * delta
	
	# we reach the destination
	if ending_city.city_position == Vector2i(self.global_position):
		starting_city = ending_city
		ending_city = starting_city.connected_cities.pick_random()
		road = null
		return
	
	var dir: int = 1 if increasing_segment_index else -1
	
	while distance_left > 0 and hasMoreSegments():
		road.setSnowAmount(segment_index, 0.0)
		
		var from: Vector2 = road.points[segment_index]
		var to: Vector2 = road.points[segment_index + dir]
		var segment_length := from.distance_to(to)

		var remaining: float = segment_length - segment_t

		if distance_left < remaining:
			segment_t += distance_left
			global_position = from.lerp(to, segment_t / segment_length)
			distance_left = 0
		else:
			distance_left -= remaining
			segment_index += dir
			segment_t = 0.0
			global_position = to
