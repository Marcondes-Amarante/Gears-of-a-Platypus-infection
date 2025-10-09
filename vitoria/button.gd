extends Button

func _ready():
	connect("pressed", Callable(self, "_on_BotaoIniciar_pressed"))

func _on_BotaoIniciar_pressed():
	print("Iniciando o jogo...")
	get_tree().quit()
