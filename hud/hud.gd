extends CanvasLayer
@onready var hour_glass = $Control/Timer_container/AnimatedSprite2D

@onready var hearts = $Control/Hearts_container.get_children()
var empty_hearth = preload("res://hud/sprite_heart_empty.png")
var hearth_full = preload("res://hud/sprite_heart_full.png")

@onready var bullets = $Control/Bullets_container.get_children()
@onready var bullets_text_indicator = $Control/Bullets_container/Label
var full_bullet_shell = preload("res://hud/Pistol-Bullet.png")
var empty_bullet_shell = preload("res://hud/Pistol-Bullet_Empty.png")

@onready var timer_text_indicator = $Control/Timer_container/Label

func _ready() -> void:
	hour_glass.play("default")
	
func update_health_ui(current_health: int, max_health: int):
	for i in range(max_health):
		hearts[i].texture = hearth_full
	for i in range(max_health-1, current_health-1, -1):
		hearts[i].texture = empty_hearth

func update_bullets_ui(current_bullets: int, max_bullets: int, recarregar: bool):
	if recarregar == true:
		print("entro em recarga")
		for i in range(max_bullets):
			bullets[i].texture = full_bullet_shell
			bullets_text_indicator.text = "%d/%d" %[current_bullets, max_bullets]
	else:
		for i in range(max_bullets-1, current_bullets-1, -1):
			bullets[i].texture = empty_bullet_shell
			bullets_text_indicator.text = "%d/%d" %[current_bullets, max_bullets]

func update_timer_ui(remaning_time: float):
	var minutes = int(remaning_time)/60
	var seconds = int(remaning_time)%60
	timer_text_indicator.text = "%02d:%02ds" %[minutes, seconds]
	
