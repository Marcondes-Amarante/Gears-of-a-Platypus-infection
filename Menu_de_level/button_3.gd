extends Button

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_button_pressed():
	match get_parent().tipo_escolhido3:
		"velocidade":
			Global.walk_speed = Global.walk_speed + (Global.walk_speed * 0.1)
		"knockback":
			Global.forca_empurrao = Global.forca_empurrao + 20
		"dano":
			if Global.max_health >= 10:
				Global.max_health = Global.max_health - 10
	Global.xp = 0
	Global.xp_r = Global.xp_r + 3
	get_tree().paused = false
	get_parent().queue_free()
