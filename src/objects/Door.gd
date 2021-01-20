tool
extends Area2D

onready var  anim_player: AnimationPlayer = $AnimationPlayer
#var key := false
export var next_scene: PackedScene

func _on_body_entered(body):
	teleport()

func _get_configuration_warning():
	return "The next scene property can't be empty" if not next_scene else ""

func teleport() -> void:
	$AudioStreamPlayer.play()
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)



