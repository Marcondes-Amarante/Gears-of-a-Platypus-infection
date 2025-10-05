extends AnimatedSprite2D

@onready var anim = $AnimationPlayer

func _ready():
	# toca uma animação automaticamente ao abrir o menu
	anim.play("entrada_menu")

func _on_BotaoIniciar_pressed():
	# toca uma animação antes de iniciar o jogo
	anim.play("default")
