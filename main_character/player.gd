extends Node2D

var walk_speed = 100
var run_speed = 200
# executa instruções quando o nó raiz é adicionado a cena
func _ready():
	
	#definindo nó raiz para o centro da tela
	self.position = get_viewport_rect().size / 2
	$body.position = Vector2.ZERO
	$AreaDano.position = Vector2.ZERO
	
#obtendo referência dos sprites
@onready var sprite: AnimatedSprite2D = $body

#executa instruções a cada frame
#delta = tempo desde último frame
func _process(delta: float):
	#inicializando vetor2D (x, y) de direcao com zeros
	#esse vetor vai armazenar uma direção (horizontal e vertical) com base em qual botão mapeado foi apertado
	var vetor_direcao_input = Vector2.ZERO
	#captando pressionamento de teclas
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
	position += vetor_direcao_input * speed * delta
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
