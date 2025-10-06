extends CharacterBody2D

func _on_body_entered(body):
	if body.name == "player": # substitua pelo nome do nó do jogador
		body.vida += 1  # exemplo: aumenta variável do jogador
		queue_free()    # remove o coletável da cena
