# Anexe este script a um nó do tipo Control
extends Control

# Vamos usar sinais para avisar o jogo qual upgrade foi escolhido
signal upgrade_selecionado(tipo_upgrade)

# Referências para os botões, configuradas no editor
@onready var button1: Button = $Button
@onready var button2: Button = $Button2
@onready var button3: Button = $Button3

# Variáveis para guardar a escolha de cada botão
var tipo_escolhido1: String
var tipo_escolhido2: String
var tipo_escolhido3: String

func _ready():
	# Garante que esta tela de UI funcione mesmo com o jogo pausado.
	# Definir no nó pai (este Control) é suficiente para todos os filhos.
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Não é necessário despausar aqui. Quem pausa o jogo deve ser
	# o responsável por despausar.
	# get_tree().paused = false 
	
	randomize()
	
	# Configura cada botão com uma opção aleatória
	tipo_escolhido1 = setup_upgrade_button(button1)
	tipo_escolhido2 = setup_upgrade_button(button2)
	tipo_escolhido3 = setup_upgrade_button(button3)
	
	# Conecta os sinais dos botões a métodos NESTE script
	button1.pressed.connect(_on_button_pressed.bind(tipo_escolhido1))
	button2.pressed.connect(_on_button_pressed.bind(tipo_escolhido2))
	button3.pressed.connect(_on_button_pressed.bind(tipo_escolhido3))

# Função para configurar um botão com um upgrade aleatório
func setup_upgrade_button(botao: Button) -> String:
	var imagens = [
		botao.get_node("velocidade"),
		botao.get_node("knockback"),
		botao.get_node("hp")
	]
	
	# Esconde todas as imagens
	for img in imagens:
		img.visible = false
	
	# Escolhe e mostra uma imagem aleatória
	var escolhida = imagens.pick_random()
	escolhida.visible = true
	
	print("Opção de upgrade disponível:", escolhida.name)
	# Retorna o nome do upgrade escolhido
	return escolhida.name

# Este método é chamado quando QUALQUER um dos botões é pressionado
func _on_button_pressed(tipo_escolhido: String):
	print("Botão clicado! Upgrade escolhido foi:", tipo_escolhido)
	
	# Emite um sinal para que o jogo saiba qual upgrade aplicar
	emit_signal("upgrade_selecionado", tipo_escolhido)
	
	# Despausa o jogo
	get_tree().paused = false
	
	# Esconde a tela de upgrade
	queue_free() # ou hide(), dependendo da sua lógica
