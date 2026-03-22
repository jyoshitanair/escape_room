extends Node2D
var main
func _ready() -> void: 
	main = get_tree().current_scene
func _on_back_pressed() -> void:
	Manager.cur_room._return_to_main()
	main._show_arrows()
	main.can_hide_arrows = true
	var password = get_tree().current_scene.get_node("CanvasLayer/password")
	if password:
		password.queue_free()
	
