extends Node

@onready var player = $Node2D/Player
@onready var gun = $Node2D/Player/gun
@onready var hud = $Hud
@onready var timer = $Spauner

func _ready() -> void:
	player.remaining_health.connect(hud.update_health_ui)
	gun.remaining_bullets.connect(hud.update_bullets_ui)
	timer.remaining_time.connect(hud.update_timer_ui)

func _input(InputEvent) -> void:
	if Global.xp >= Global.xp_r:
		pause_game()

func pause_game():
	get_tree().paused = true
	var pause_menu = load("res://Menu_de_level/upgrade.tscn").instantiate()
	add_child(pause_menu)
