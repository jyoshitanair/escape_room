extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer
var current 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Manager.hide_arrows.connect(_on_hide_arrows)
	_show_arrows()
func _on_hide_arrows(room_name)-> void: 
	print(room_name)
	print("delete arrow")
	var arrows = get_tree().current_scene.get_node_or_null("CanvasLayer/arrows")
	if arrows:
		arrows.queue_free()
	var path = "res://scenes/back_arrow.tscn"
	current = load(path).instantiate()
	canvas_layer.add_child.call_deferred(current)
	call_deferred("_pt2",room_name)
func _pt2(room_name) -> void:
	var back_arrow = get_tree().current_scene.get_node("CanvasLayer/back_arrow")
	back_arrow.cur_room = room_name
func _show_arrows() -> void:
	print("delete back arrow")
	var back_arrow = get_tree().current_scene.get_node_or_null("CanvasLayer/back_arrow")
	if back_arrow:
		back_arrow.queue_free()
	var path = "res://scenes/arrows.tscn"
	current = load(path).instantiate()
	canvas_layer.add_child.call_deferred(current)
