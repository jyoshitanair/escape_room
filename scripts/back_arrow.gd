extends Node2D
var cur_room 

func _on_back_pressed() -> void:
	cur_room._return_to_main()
	get_tree().current_scene._show_arrows()
