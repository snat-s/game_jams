tool
extends Button

export(String, FILE) var next_scene_path_ = ""

func _on_PlayButton_button_up():
	get_tree().change_scene(next_scene_path_)
	
func _get_configuration_warning():
	return "next_scene_path must be set for the button to work" if next_scene_path_ == "" else ""

