extends Node2D
@onready var left: TextureButton = $left
@onready var right: TextureButton = $right
var index = 1
var cur_room
var main
var camera 
var room_num
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_tree().current_scene.get_node_or_null("Node").get_node_or_null("camera")
	main =  get_tree().current_scene
	cur_room = get_tree().get_first_node_in_group("room")
	if cur_room:
		room_num = cur_room.room_number
	change_page(room_num)
func change_page(room_number:int) -> void:
	camera.zoom = Vector2(1.0,1.0)
	if cur_room:
		cur_room.queue_free()
	var path = "res://scenes/room_%d.tscn"%room_number
	cur_room = load(path).instantiate()
	cur_room.add_to_group("room")
	main.get_node("Node").add_child.call_deferred(cur_room)
	var key_1 = get_tree().get_first_node_in_group("key_room_1")
	var key_2 =get_tree().get_first_node_in_group("key_room_2")
	var key_3 =get_tree().get_first_node_in_group("key_room_3")
	if room_number == 1:
		if key_1:
			key_1.visible = true
		if key_2:
			key_2.visible = false
		if key_3:
			key_3.visible = false
	if room_number == 2:
		if key_2:
			key_2.visible = true
		if key_1:
			key_1.visible = false
		if key_3:
			key_3.visible = false
	if room_number == 3:
		if key_2:
			key_2.visible = false
		if key_1:
			key_1.visible = false
		if key_3:
			key_3.visible = true
	#main.call_deferred("move_child",cur_room,0)
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
