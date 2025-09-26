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
