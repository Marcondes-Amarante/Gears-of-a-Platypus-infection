extends "res://enemies/enemies.gd"

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	super()
	speed = 30
	bullet_damage_received = 34
	add_to_group("enemies")
	
func _updata_animation(direction: Vector2):
	if direction.x < 0:
		animation.play("zombie_big_walk_left")
	else:
		animation.play("zombie_big_walk_right")

func hit_flash_effect():
	var tween = create_tween()
	tween.tween_property(animation, "modulate", Color(1, 0, 0, 0.5), 0.05)
	tween.tween_property(animation, "modulate", Color(1, 1, 1, 1), 0.05)
	tween.set_loops(1)
