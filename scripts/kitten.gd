extends "res://scripts/cat.gd"

enum { STATE_SIT, STATE_GOTO, STATE_CARRIED, STATE_EATING, STATE_DROWNING, STATE_DEAD }

const WALK_SPEED = 50
const PROXIMITY = 2.0

var desired = Vector2()

var state
var life
var happy
var hunger

var timer_state
var timer_need

# ---------------------------------------------------------------------------
func _ready():

	state = STATE_SIT
	life = 5
	happy = 5
	hunger = 5

	timer_state = 0
	timer_need = 0

	add_to_group("kitten")
	set_fixed_process(true)
	pass

# ---------------------------------------------------------------------------
func _fixed_process(delta):
	check_state(delta)
	check_need(delta)
	pass

# ---------------------------------------------------------------------------
func _on_area_enter_legs(other):

	print(get_name() + " :: " + other.get_parent().get_name() + " / " + other.get_name())

	if other.is_in_group("hole"):
		velocity = Vector2()
		state = STATE_DROWNING
		get_node("AnimatedSprite").set_animation("drown")
		pass

	pass

# ---------------------------------------------------------------------------
func check_state(delta):

	if state == STATE_DROWNING:
		return

	if state == STATE_SIT:
		timer_state -= delta
		if timer_state < 0:

			state = STATE_GOTO
			desired = Vector2(rand_range(40, 3800), rand_range(100, 1000))

	if state == STATE_GOTO:
		var v = desired - get_pos()
		var l = v.length()

		if l < PROXIMITY:
			velocity = Vector2()
			state = STATE_SIT
			timer_state = rand_range(2.0, 5.0)

		else:
			velocity = v.normalized() * WALK_SPEED * delta
			set_pos(get_pos() + velocity)

	update_animation()

	pass

# ---------------------------------------------------------------------------
func check_need(delta):
	pass
