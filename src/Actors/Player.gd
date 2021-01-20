extends Actor

onready var anim_player = $AnimatedSprite
onready var sprite = $tile_0240

export var stomp_impulse: = 200.0

var key = false
var facing_right = false
var direction

func _on_key_Detector_body_entered(body):
	pass


func _on_Key_Detector_area_entered(area):
	pass # Replace with function body.

func _on_Enemy_Detector_area_entered(area):
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_Enemy_Detector_body_entered(body):
	die()


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	direction = get_direction()
	if Input.is_action_just_pressed("jump"):
		$jump.play()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2( 
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor()  else 1.0
	) 

func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

func calculate_stomp_velocity (linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func _process(delta):
	var grounded = is_on_floor()
	if grounded:
		if direction.x == 0:
			$AnimatedSprite.play("stand")
		elif direction.x > 0:
			$AnimatedSprite.play("run_r")
		else:
			$AnimatedSprite.play("run_l")
	else:
		if direction.x > 0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("jump.l")

func sounds():
	pass

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

func die() -> void:
	#anim_player.play("die")
	#yield($AnimatedSprite,"animation_finished")
	get_tree().paused = false
	get_tree().reload_current_scene()
	PlayerData.deaths += 1
	PlayerData.score -= 10
	queue_free()


