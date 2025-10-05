extends Node2D

@onready var anim = $AnimatedSprite2D

func _ready():
	# toca uma animação automaticamente ao abrir o menu
	anim.play("default")
