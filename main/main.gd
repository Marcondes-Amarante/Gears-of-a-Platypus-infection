extends Node

@onready var player = $Node2D/Player
@onready var gun = $Node2D/Player/gun
@onready var hud = $Hud
@onready var timer = $Spauner

func _ready() -> void:
	player.remaining_health.connect(hud.update_health_ui)
	gun.remaining_bullets.connect(hud.update_bullets_ui)
	timer.remaining_time.connect(hud.update_timer_ui)
	
