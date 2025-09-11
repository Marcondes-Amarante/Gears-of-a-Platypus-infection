extends Node2D

@onready var gun: AnimatedSprite2D = $spriteHandGun
@onready var gunMarkerLeft: Marker2D = $gunPositionLeft
@onready var posCano: Marker2D = $cano
@onready var posCanoLeft: Marker2D = $canoLeft

const BULLET = preload("res://bullet/bullet.tscn")

var municao_atual: int = 6
var maximo_municao: int = 6
var recarregar: bool = false

func _ready() -> void:
	#conectando sinal de mudança de frame da animação de gun a função de gerar bala
	gun.frame_changed.connect(_criar_bala)
	gun.animation_finished.connect(_recarregar_arma)

func _process(delta: float):
	
	#ajusta rotação do nó raiz para rotacionar sempre em relação ao mouse
	look_at(get_global_mouse_position())
	
	#limita rotação para ficar entre 0° e 360°
	rotation_degrees = wrap(rotation_degrees, 0, 360)

	#invertendo verticalmente sprite da arma caso rotação esteja entre 90 e 270
	if rotation_degrees > 90 and rotation_degrees < 270:
		gun.flip_v = true
	else:
		gun.flip_v = false
	#mudando gun position para o marker esquerdo caso arma tenha sido invertida em y
	if gun.flip_v == true:
		gun.position = gunMarkerLeft.position
	else:
		gun.position = Vector2(40, 0)
		
	#lógica do tiro
	if Input.is_action_just_pressed("shoot") and recarregar == false:
		
		if municao_atual == 0:
			recarregar = true
			gun.animation = "reload"
			gun.play()
		else:
			#acionando animacao de tiro
			gun.animation = "gun_shoot"
			gun.play()
		
func _criar_bala():
	
	if gun.animation == "gun_shoot" and gun.frame == 5 and recarregar == false:
		
		#criando instância da bala
		var bullet_instance = BULLET.instantiate()
		
		#adicionando instância criado como nó filho da arma
		get_tree().root.add_child(bullet_instance)
		
		#definindo posição de origem da bala como a frente do cano
		bullet_instance.global_position = posCano.global_position
		if gun.flip_v == true:
			bullet_instance.global_position = posCanoLeft.global_position
			
		#definindo rotação da bala como rotação da arma
		bullet_instance.rotation = rotation
		
		municao_atual = municao_atual-1
		print(municao_atual)
	
func _recarregar_arma():
	if gun.animation == "reload":
		municao_atual = maximo_municao
		recarregar = false
