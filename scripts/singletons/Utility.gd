extends Node


func generate_positions(count: int, min_distance: float, start_bounds: Vector2i, end_bounds: Vector2i) -> Array[Vector2i]:
	var positions: Array[Vector2i] = []
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.randomize()
	
	var attempts: int = 0
	var max_attempts: int = 200  # avoid infinite loops
	
	while positions.size() < count and attempts < max_attempts:
		attempts += 1
		var candidate: Vector2i = Vector2i(
			rng.randi_range(start_bounds.x, end_bounds.x),
			rng.randi_range(start_bounds.y, end_bounds.y)
		)
		
		var too_close: bool = false
		for pos: Vector2i in positions:
			if pos.distance_to(candidate) < min_distance:
				too_close = true
				break
				
		if not too_close:
			positions.append(candidate)
	
	return positions

func segments_intersect(a1: Vector2, a2: Vector2, b1: Vector2, b2: Vector2) -> bool:
	if (a1 == b1 or a1 == b2) or (a2 == b1 or a2 == b2):
		return false
	# 2D line segment intersection
	var s1: Vector2 = a2 - a1
	var s2: Vector2 = b2 - b1
	var s: float = (-s1.y * (a1.x - b1.x) + s1.x * (a1.y - b1.y)) / (-s2.x * s1.y + s1.x * s2.y)
	var t: float = ( s2.x * (a1.y - b1.y) - s2.y * (a1.x - b1.x)) / (-s2.x * s1.y + s1.x * s2.y)
	return s >= 0 and s <= 1 and t >= 0 and t <= 1
