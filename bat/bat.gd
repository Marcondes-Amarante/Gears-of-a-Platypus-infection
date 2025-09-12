extends CharacterBody2D
const SPEED = 300.0

func _ready():
	var lot = randi_range(0, 4) 
	if lot == 1:
		self.position.x = -200
		self.position.y = 275
	elif lot == 2:
		self.position.x = 1900
		self.position.y = 260
	elif lot == 3:
		self.position.x = 200
		self.position.y = -150
	else:
		self.position.x = 200
		self.position.y = 1200
		
func _physics_process(delta: float) -> void:
	
	var sprite: AnimatedSprite2D = $muv
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if (Global.p.x - 180) < self.position.x:
		velocity.x = - 50
		sprite.animation = "esquerda"
		sprite.play()
	else:
		velocity.x = + 50
		sprite.animation = "direita"
		sprite.play()
	if (Global.p.y - 50) < self.position.y:
		velocity.y = - 50
	else:
		velocity.y = + 50
	
	var rity = (Global.p.y - 50) - self.position.y
	var ritx = (Global.p.x - 180) - self.position.x
	
	if rity < 0:
		rity = rity * -1
	if ritx < 0:
		ritx = ritx * -1
	
	if rity < 65 && ritx < 60:
		queue_free()
	
	move_and_slide()
	if get_slide_collision_count() > 0:
		print(get_slide_collision_count())
