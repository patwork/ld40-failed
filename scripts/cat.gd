extends Node2D

onready var cat_sprite = get_node("AnimatedSprite")
onready var collision_whole = get_node("collision-whole")
onready var collision_legs = get_node("collision-legs")

var looking_right = false
var standing = true
var velocity = Vector2()

# ---------------------------------------------------------------------------
func _ready():

	# fix collision
	# https://github.com/godotengine/godot/issues/8103
	var collision
	collision_whole.clear_shapes()
	collision = collision_whole.get_node("CollisionShape2D")
	collision_whole.add_shape(collision.get_shape(), collision.get_transform())
	collision_legs.clear_shapes()
	collision = collision_legs.get_node("CollisionShape2D")
	collision_legs.add_shape(collision.get_shape(), collision.get_transform())

	collision_whole.connect("area_enter", self, "_on_area_enter_whole")
	collision_legs.connect("area_enter", self, "_on_area_enter_legs")

	pass

# ---------------------------------------------------------------------------
func _on_area_enter_whole(other):
	pass

# ---------------------------------------------------------------------------
func _on_area_enter_legs(other):
	pass

# ---------------------------------------------------------------------------
func update_animation():

	if (velocity.x < 0 and looking_right == true):
		cat_sprite.set_flip_h(false)
		looking_right = false
	elif (velocity.x > 0 and looking_right == false):
		cat_sprite.set_flip_h(true)
		looking_right = true

	if (velocity.x == 0 and velocity.y == 0):
		if (standing == false):
			cat_sprite.set_animation("sit")
			standing = true
	else:
		if (standing == true):
			cat_sprite.set_animation("walk")
			standing = false

	pass
