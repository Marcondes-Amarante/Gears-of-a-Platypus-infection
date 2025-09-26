extends Node2D

const SPEED: int  = 600

func _physics_process(delta: float) -> void:
	position += transform.x * SPEED * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		body.decrease_health(body.bullet_damage_received)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#removendo da fila balas que sairam da área vísivel
	queue_free()
