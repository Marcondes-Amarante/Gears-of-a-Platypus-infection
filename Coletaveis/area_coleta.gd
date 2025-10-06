extends Area2D

func _on_area_coleta_body_entered(body):
	if body.is_in_group("player"):
		print("Jogador coletou o item!")
		# aqui você pode adicionar o efeito desejado:
		body.current_health = min(body.max_health, body.current_health + 1)
		queue_free()
