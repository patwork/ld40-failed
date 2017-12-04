extends Camera2D

onready var player = get_tree().get_root().get_node("world/father")
onready var background = get_tree().get_root().get_node("world/background")

# ---------------------------------------------------------------------------
func _ready():
	randomize()
	set_process(true)
	pass

# ---------------------------------------------------------------------------
func _process(delta):

	var player_pos = player.get_pos()
	var camera_pos = get_pos()
	var center = get_viewport_rect().size.x / 2
	var min_left = 0
	var max_right = background.get_rect().size.x - center * 2

	if (camera_pos.x + center != player_pos.x):
		var len = abs(camera_pos.x + center - player_pos.x)
		var sig = sign(camera_pos.x + center - player_pos.x)
		camera_pos.x = clamp(camera_pos.x - (len * sig / 2) * delta, min_left, max_right)
		set_pos(camera_pos)

	pass