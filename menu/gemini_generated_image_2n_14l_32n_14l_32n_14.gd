extends Button

@onready var imagem = $GeminiGeneratedImage2n14l32n14l32n14  # Caminho para o nó da imagem

func _ready():
	# Conectando os sinais do mouse
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

	# Esconde a imagem no início
	imagem.visible = false


func _on_mouse_entered():
	imagem.visible = true  # Mostra a imagem quando o mouse entra


func _on_mouse_exited():
	imagem.visible = false  # Esconde a imagem quando o mouse sai
