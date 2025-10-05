extends Button

func _ready():
	# Conecta o botão ao método de clique
	connect("pressed", Callable(self, "_on_BotaoIniciar_pressed"))

func _on_BotaoIniciar_pressed():
	print("Iniciando o jogo...")
	get_tree().change_scene_to_file("res://main/main.tscn")
