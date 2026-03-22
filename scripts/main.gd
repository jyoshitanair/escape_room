extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer
var current 
var can_hide_arrows = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Manager.hide_arrows.connect(_on_hide_arrows)
	_show_arrows()
#HIDES SIDE ARROWS
func _on_hide_arrows(room_name)-> void: 
	if can_hide_arrows:
		can_hide_arrows = false
		var arrows = get_tree().current_scene.get_node_or_null("CanvasLayer/arrows")
		if arrows:
			arrows.queue_free()
		var path = "res://scenes/back_arrow.tscn"
		current = load(path).instantiate()
		canvas_layer.add_child.call_deferred(current)
		Manager.cur_room = room_name

#HIDES BACK ARROW
func _show_arrows() -> void:
	var back_arrow = get_tree().current_scene.get_node_or_null("CanvasLayer/back_arrow")
	if back_arrow:
		back_arrow.queue_free()
	var path = "res://scenes/arrows.tscn"
	current = load(path).instantiate()
	canvas_layer.add_child.call_deferred(current)
