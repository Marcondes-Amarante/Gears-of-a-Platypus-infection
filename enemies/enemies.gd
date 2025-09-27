extends  CharacterBody2D

#script para deinição de comportamentos e atributos padrões compartilhados entre inimigos
@export var max_health: int = 100
var current_health: int

@export var speed: float = 50
@export var damage: int = 1

@export var bullet_damage_received: int = 20

@export var forca_empurrao: float = 200.0
@export var duracao_empurrao: float = 0.2
var foi_empurrado: bool = false
var tempo_empurrao: float = 0.0

var player: Node2D = null

func _ready() -> void:
	current_health = max_health
	$Area2D.body_entered.connect(_on_Area2D_body_entered)
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta: float) -> void:
	
	if foi_empurrado:
		tempo_empurrao -= delta
		if tempo_empurrao <= 0:
			foi_empurrado = false
			velocity = Vector2.ZERO
		move_and_slide()
		return
	
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		_updata_animation(direction)

#método genérico para trocar animação de acordo com a posição de player
func _updata_animation(direction: Vector2):
	pass

func die():
	queue_free()

func hit_flash_effect():
	pass

func decrease_health(qtd_damage: int):
	current_health -= qtd_damage
	
	if player.global_position != Vector2.ZERO:
		var direcao_empurrao = (global_position - player.global_position).normalized()
		velocity = direcao_empurrao * forca_empurrao
		foi_empurrado = true
		tempo_empurrao = duracao_empurrao
	
	hit_flash_effect()
	
	if current_health <= 0:
		die()

#detecta se player entrou na hitbox do inimigo
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player.decrease_health(damage, global_position)

	
	
