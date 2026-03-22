extends Node2D
var camera
var main 
var dialog_box
var can_click = true
@export var target = 1
@export var room_number = 1
#ONREADYS 
@onready var angry_teacher: CollisionShape2D = $angry_teacher/CollisionShape2D
@onready var white_board: CollisionShape2D = $white_board/CollisionShape2D
@onready var tests: CollisionShape2D = $test_board/CollisionShape2D
@onready var lock: CollisionShape2D = $lock/CollisionShape2D

@onready var center: Marker2D = $Marker2D
#STATES
var on_teacher = false
var on_white_board = false
var on_test = false
var on_lock = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main = get_tree().current_scene
	camera = main.get_node_or_null("Node").get_node_or_null("camera")
	dialog_box =  main.get_node("CanvasLayer/dialog_box")
	_return_to_main()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera.position = camera.position.lerp(target.position,delta*3)
func _input(event):
	if event.is_action_pressed("click"):
		dialog(on_teacher,angry_teacher,"Well what are you looking at?!")
		dialog(on_white_board,white_board,"Weird symbols.")
		dialog(on_test,tests,"Tests. Ugh.")
		dialog(on_lock,lock,"You need a password")
func dialog(on_what,target_what,text_what)-> void: 
	if on_what and can_click: 
		can_click = false
		target = target_what
		camera.zoom = Vector2(1.7,1.7)
		Manager.emit_signal("hide_arrows",self)
		dialog_box.text.text = text_what
		dialog_box.visible = true 
		dialog_box.load_text()		
func _on_angry_teacher_mouse_entered() -> void:
	on_teacher = true 
func _on_angry_teacher_mouse_exited() -> void:
	on_teacher = false 
	
func _on_white_board_mouse_entered() -> void:
	on_white_board = true
func _on_white_board_mouse_exited() -> void:
	on_white_board = false
	
func _on_test_board_mouse_entered() -> void:
	on_test = true 
func _on_test_board_mouse_exited() -> void:
	on_test = false
	
func _on_lock_mouse_entered() -> void:
	on_lock = true
func _on_lock_mouse_exited() -> void:
	on_lock = false
	
func _return_to_main() -> void: 
	target = center
	camera.zoom = Vector2(1.0,1.0)
