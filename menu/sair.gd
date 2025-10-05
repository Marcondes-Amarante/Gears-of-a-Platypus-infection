extends Button

func _ready():
	# Conecta o botão ao método de clique
	connect("pressed", Callable(self, "_on_BotaoIniciar_pressed"))

func _on_BotaoIniciar_pressed():
	print("Saindo do jogo...")
	get_tree().quit()  # Fecha o jogo
