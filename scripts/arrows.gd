extends Node2D
@onready var left: TextureButton = $left
@onready var right: TextureButton = $right
var index = 1
var cur_room
var main
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main =  get_tree().current_scene
	cur_room = main.get_node("cur_room")
	change_page(1)
func change_page(room_number:int) -> void:
	cur_room.queue_free()
	var path = "res://scenes/room_%d.tscn"%room_number
	cur_room = load(path).instantiate()
	main.add_child.call_deferred(cur_room)
	main.call_deferred("move_child",cur_room,0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_left_pressed() -> void:
	if index ==1:
		index = 4
	else:
		index -=1
	change_page(index)
func _on_right_pressed() -> void:
	if index ==4:
		index = 1
	else:
		index +=1
	change_page(index)
