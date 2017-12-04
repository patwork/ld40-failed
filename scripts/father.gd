extends "res://scripts/cat.gd"

const WALK_MIN_SPEED = 10
const WALK_MAX_SPEED = 200
const WALK_FORCE = 600
const STOP_FORCE = 1200

# ---------------------------------------------------------------------------
func _ready():
	set_fixed_process(true)
	add_to_group("father")
	pass

# ---------------------------------------------------------------------------
func _fixed_process(delta):

	var force = Vector2()
	var stop = true

	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var walk_up = Input.is_action_pressed("move_up")
	var walk_down = Input.is_action_pressed("move_down")

	if (walk_left):
		if (velocity.x <= WALK_MIN_SPEED and velocity.x >= - WALK_MAX_SPEED):
			force.x -= WALK_FORCE
			stop = false
	elif (walk_right):
		if (velocity.x >= -WALK_MIN_SPEED and velocity.x <= WALK_MAX_SPEED):
			force.x += WALK_FORCE
			stop = false

	if (walk_up):
		if (velocity.y <= WALK_MIN_SPEED and velocity.y >= - WALK_MAX_SPEED):
			force.y -= WALK_FORCE
			stop = false
	elif (walk_down):
		if (velocity.y >= -WALK_MIN_SPEED and velocity.y <= WALK_MAX_SPEED):
			force.y += WALK_FORCE
			stop = false

	if (stop):
		var hsign = sign(velocity.x)
		var hlen = abs(velocity.x)
		var vsign = sign(velocity.y)
		var vlen = abs(velocity.y)

		hlen -= STOP_FORCE * delta
		if (hlen < 0):
			velocity.x = 0
		else:
			velocity.x = hlen * hsign

		vlen -= STOP_FORCE * delta
		if (vlen < 0):
			velocity.y = 0
		else:
			velocity.y = vlen * vsign

	velocity += force * delta
	set_pos(get_pos() + velocity * delta)

	update_animation()

	pass

# ---------------------------------------------------------------------------
func _on_area_enter_whole(other):
	print(get_name() + " :: " + other.get_parent().get_name() + " / " + other.get_name())
	pass
