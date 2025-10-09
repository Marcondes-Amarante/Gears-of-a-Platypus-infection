extends Node2D

@export var big_zombie = PackedScene
var qtd_zombies_horde: int = 1
@export var bat = PackedScene
var qtd_bats: int = 2 

@export var cooldown: float = 5.0

@export var max_time: float = 0.0
var tempo_atual: float = 600.0
signal remaining_time(tempo_atual: float)

@onready var spawn_points: Array[Marker2D] = []

var timer: Timer

func _ready() -> void:
	
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child)
	
	timer = Timer.new()
	timer.wait_time = cooldown
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)

	timer.timeout.connect(spawnar_hordas)
	
func _process(delta: float) -> void:
	tempo_atual -= delta
	emit_signal("remaining_time", tempo_atual)
	
	if tempo_atual <= 0:
		get_tree().change_scene_to_file("res://vitoria/vitoria.tscn")
	
	if tempo_atual <= 420:
		configurar_dificuldade(1)
	elif tempo_atual <= 240:
		configurar_dificuldade(2)
		
	
func configurar_dificuldade(dificuldade: int):
	
	if dificuldade == 1:
		timer.wait_time = 3.0
		qtd_zombies_horde = 2
		qtd_bats = 3
	elif dificuldade == 2:
		timer.wait_time = 2.0
		qtd_zombies_horde = 3
		qtd_bats = 5
		
func spawnar_hordas():
	
	if get_tree().get_nodes_in_group("enemies").size() >= 100:
		return
	
	var enemies = [big_zombie, bat]
	var chosen_enemy = enemies.pick_random()
	var qtd_enemies = 1
	var cena
	
	if chosen_enemy == big_zombie:
		qtd_enemies = qtd_zombies_horde
		cena = big_zombie
	elif chosen_enemy == bat:
		qtd_enemies = qtd_bats
		cena = bat
		
	var chosen_spawn_point = spawn_points.pick_random().global_position
	
	for i in range(qtd_enemies):
		var inimigo = cena.instantiate()
		inimigo.global_position = chosen_spawn_point + Vector2(randf_range(-40, 40), randf_range(-40, 40))
		add_child(inimigo)
		inimigo.add_to_group("enemies")
	
	
