extends CharacterBody2D

var walk_speed = 100
var run_speed = 200

@export var max_health: int = 4
var current_health: int

@export var forca_empurrao: float = 200.0
@export var duracao_empurrao: float = 0.2
var foi_empurrado: bool = false
var tempo_empurrao: float = 0.0

#obtendo referência dos sprites
@onready var sprite: AnimatedSprite2D = $body

signal remaining_health(current_health: int, max_health: int)

func _ready():
	
	#definindo nó raiz para o centro da tela
	self.position = get_viewport_rect().size / 2
	$body.position = Vector2.ZERO
	$AreaDano.position = Vector2.ZERO
	
	current_health = max_health
	
	add_to_group("player")

func _process(delta: float):
	
	#bloqueando movimento momentaneamente se player foi empurrado
	if foi_empurrado:
		tempo_empurrao -= delta
		if tempo_empurrao <= 0:
			foi_empurrado = false
			velocity = Vector2.ZERO
		move_and_slide()
		return
	
	#esse vetor vai armazenar uma direção (horizontal e vertical) com base em qual botão mapeado foi apertado
	var vetor_direcao_input = Vector2.ZERO

	#direita assume sempre valores positivos, enquanto esquerda negativos
	vetor_direcao_input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	vetor_direcao_input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#verificando se alguma tecla foi pressionada com base no valor de comprimento do vetor
	if vetor_direcao_input.length() > 0:
		
		#normalizando vetor para garantir que personagem se mova na mesma proporção de comprimento em todas as direções
		vetor_direcao_input = vetor_direcao_input.normalized()
		
	var speed = walk_speed
	
	#trocando velocidades caso shift seja apertado
	#se tanto a direção do mouse como a global são a mesma então muda-se a velocidade
	if (Input.is_action_pressed("ui_shift") and Input.get_action_strength("ui_left") and get_global_mouse_position().x < global_position.x) or (Input.is_action_pressed("ui_shift") and Input.get_action_strength("ui_right") and get_global_mouse_position().x > global_position.x):
		speed = run_speed
	
	#usando delta para garantir que independente da quantidade de frames por segundo o desloawcamento (comprimento do vetor) seja sempre o mesmo
	velocity = vetor_direcao_input * speed
	move_and_slide()
	Global.p = self.position
	
	#geranciando sprites
	if vetor_direcao_input != Vector2.ZERO:
		if speed == walk_speed:
			sprite.animation = "Walk"
			
		#tratando caso do personagem corre para trás:
		#(mouse a direita + direção esquerda + shift)
		elif (speed == run_speed and Input.get_action_strength("ui_left") and get_global_mouse_position().x > global_position.x):
			sprite.animation = "Walk"
			
		#(mouse a esquerda + direcao direita + shift)
		elif (speed == run_speed and Input.get_action_strength("ui_right") and get_global_mouse_position().x < global_position.x):
			sprite.animation = "Walk"
		else:
			sprite.animation = "Run"
		sprite.play()
	else:
		sprite.animation = "Idle"
		sprite.play()
	
	#invertendo sprite horizontalmente com base na posição do mouse
	if get_global_mouse_position().x < global_position.x:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
func decrease_health(qtd_damage: int, direcao_inimigo: Vector2):
	current_health -= qtd_damage
	print("player levou ", qtd_damage, " de dano e tem ", current_health, " de vida")
	
	#acionando empurrao
	if direcao_inimigo != Vector2.ZERO:
		var direcao_empurrao = (global_position - direcao_inimigo).normalized()
		velocity = direcao_empurrao * forca_empurrao
		foi_empurrado = true
		tempo_empurrao = duracao_empurrao
	
	#acionando efeito de flash de dano
	hit_flash_effect()
	
	#acionando sinal para decrescimo de saúde
	emit_signal("remaining_health", current_health, max_health)
		
	if current_health <= 0:
		die()

func hit_flash_effect():
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", Color(1, 0, 0, 0.5), 0.05)
	tween.tween_property(sprite, "modulate", Color(1, 1, 1, 1), 0.05)
	tween.set_loops(1)
	
func die():
	queue_free()
