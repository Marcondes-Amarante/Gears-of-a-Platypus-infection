extends "res://enemies/enemies.gd"

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	super()
	speed = 60
	bullet_damage_received = 100
	add_to_group("enemies")

func _updata_animation(direction: Vector2):
	if direction.x < 0:
		animation.play("bat_fly_left")
	else:
		animation.play("bat_fly_right")
