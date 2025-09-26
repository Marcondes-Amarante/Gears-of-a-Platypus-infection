extends "res://enemies/enemies.gd"

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	super()
	speed = 40
	add_to_group("enemies")
	
func _updata_animation(direction: Vector2):
	if direction.x < 0:
		animation.play("zombie_axe_walk_left")
	else:
		animation.play("zombie_axe_walk_right")

func _process(delta: float) -> void:
	_updata_animation(direction)
		
	
