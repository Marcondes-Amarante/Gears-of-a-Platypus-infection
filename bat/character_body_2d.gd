extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta: float) -> void:
	
	var sprite: AnimatedSprite2D = $muv
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if (Global.p.x - 180) < self.position.x:
		velocity.x = - 20
		sprite.animation = "esquerda"
		sprite.play()
	else:
		velocity.x = + 20
		sprite.animation = "direita"
		sprite.play()
	if (Global.p.y - 50) < self.position.y:
		velocity.y = - 20
	else:
		velocity.y = + 20
	
	var rity = (Global.p.y - 50) - self.position.y
	var ritx = (Global.p.x - 180) - self.position.x
	
	if rity < 0:
		rity = rity * -1
	if ritx < 0:
		ritx = ritx * -1
	
	if rity < 65 && ritx < 60:
		queue_free()
	
	move_and_slide()
	get_slide_collision_count()
