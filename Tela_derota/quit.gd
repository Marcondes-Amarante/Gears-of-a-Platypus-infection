extends Button
@onready var imagem = $Im3

func _ready():
	# Conecta o botão ao método de clique
	connect("pressed", Callable(self, "_on_BotaoIniciar_pressed"))
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	imagem.visible = false

func _on_BotaoIniciar_pressed():
	print("Iniciando o jogo...")
	get_tree().quit()  # Fecha o jogo

func _on_mouse_entered():
	imagem.visible = true  # Mostra a imagem quando o mouse entra

func _on_mouse_exited():
	imagem.visible = false  # Esconde a imagem quando o mouse sai
