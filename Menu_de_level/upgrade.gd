extends Node2D

var tipo_escolhido: String = ""
var tipo_escolhido2: String = ""
var tipo_escolhido3: String = ""

func _ready():
	randomize()
	process_mode = Node.PROCESS_MODE_ALWAYS
	$Button.process_mode = Node.PROCESS_MODE_ALWAYS
	$Button2.process_mode = Node.PROCESS_MODE_ALWAYS
	$Button3.process_mode = Node.PROCESS_MODE_ALWAYS
	
	var imagens = [
		$Button/knockback,
		$Button/velocidade,
		$Button/dano
	]
	
	# Esconde todas
	for img in imagens:
		img.visible = false
	
	# Escolhe uma imagem aleatória
	var indice = randi() % imagens.size()
	var escolhida = imagens[indice]
	escolhida.visible = true
	
	# Guarda o tipo para usar no botão
	tipo_escolhido = escolhida.name
	print("Upgrade escolhido:", tipo_escolhido)
	
	# Conecta o botão ao método de clique
	$Button.pressed.connect($Button._on_button_pressed)
	
	var imagens2 = [
		$Button2/knockback,
		$Button2/velocidade,
		$Button2/dano
	]
	
	# Esconde todas
	for img2 in imagens2:
		img2.visible = false
	
	# Escolhe uma imagem aleatória
	var indice2 = randi() % imagens2.size()
	var escolhida2 = imagens2[indice2]
	escolhida2.visible = true
	
	# Guarda o tipo para usar no botão
	tipo_escolhido2 = escolhida2.name
	print("Upgrade escolhido:", tipo_escolhido2)
	
	# Conecta o botão ao método de clique
	$Button2.pressed.connect($Button2._on_button_pressed)
	
	var imagens3 = [
		$Button3/knockback,
		$Button3/velocidade,
		$Button3/dano
	]
	
	# Esconde todas
	for img3 in imagens3:
		img3.visible = false
	
	# Escolhe uma imagem aleatória
	var indice3 = randi() % imagens3.size()
	var escolhida3 = imagens3[indice3]
	escolhida3.visible = true
	
	# Guarda o tipo para usar no botão
	tipo_escolhido3 = escolhida3.name
	print("Upgrade escolhido:", tipo_escolhido3)
	
	# Conecta o botão ao método de clique
	$Button3.pressed.connect($Button3._on_button_pressed)
