extends Area2D

onready var water_lb = get_node("water-lb")
onready var water_rt = get_node("water-rt")

# ---------------------------------------------------------------------------
func _ready():

	var ellipse = ellipse(780, 842, 220, 70)
	var shape = water_lb.get_shape()
	shape.set_points(ellipse)
	water_lb.set_shape(shape)

	ellipse = ellipse(3080, 470, 220, 70)
	shape = water_rt.get_shape()
	shape.set_points(ellipse)
	water_rt.set_shape(shape)

	add_to_group("hole")

	pass

# ---------------------------------------------------------------------------
func ellipse(x, y, r1, r2):
	var points = Vector2Array()
	var point = Vector2()
	var r

	for r in range(0, 360, 30):
		point.x = x + sin(deg2rad(r)) * r1
		point.y = y + cos(deg2rad(r)) * r2
		points.append(point)

	return points
