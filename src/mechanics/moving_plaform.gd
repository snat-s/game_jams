extends Node2D

func _physics_process(delta):
	velocity.y += gravity * delta
	var snap = Vector2.DOWN * 16 if is_on_floor() else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
