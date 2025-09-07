extends Node2D

const SPEED: int  = 450

func _process(delta: float) -> void:
	position += transform.x * SPEED * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#removendo da fila balas que sairam da área vísivel
	queue_free()
