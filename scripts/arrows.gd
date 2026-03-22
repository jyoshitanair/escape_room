extends Node2D
@onready var left: TextureButton = $left
@onready var right: TextureButton = $right
var index = 1
var cur_room
var main
var camera 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_tree().current_scene.get_node_or_null("Node").get_node_or_null("camera")
	main =  get_tree().current_scene
	if Manager.first_time: 
		cur_room = main.get_node("Node").get_node("cur_room")
		Manager.first_time = false
		print("wwrong loop")
	else:
		cur_room = get_tree().get_first_node_in_group("room")
	change_page(1)
func change_page(room_number:int) -> void:
	camera.zoom = Vector2(1.0,1.0)
	if cur_room:
		cur_room.queue_free()
	var path = "res://scenes/room_%d.tscn"%room_number
	cur_room = load(path).instantiate()
	cur_room.add_to_group("room")
	main.add_child.call_deferred(cur_room)
	main.call_deferred("move_child",cur_room,0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		_on_left_pressed()
	if Input.is_action_just_pressed("right"):
		_on_right_pressed()

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
