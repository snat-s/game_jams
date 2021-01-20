extends "res://src/Actors/Actor.gd"
onready var  anim_player: AnimatedSprite = $AnimatedSprite
export var score: = 100

func _ready()-> void:
	set_physics_process(false)
	_velocity.x = -speed.x

func _on_STOMP_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("STOMP").global_position.y:
		return 
	get_node("CollisionShape2D").disabled = true
	$AudioStreamPlayer2D.play()
	#yield($AudioStreamPlayer2D, "finished")
	$AnimatedSprite.play("edead") 
	yield(anim_player, "animation_finished")
	die()  

func _physics_process(delta: float) ->  void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func die() -> void:
	queue_free()
	PlayerData.score += score 
