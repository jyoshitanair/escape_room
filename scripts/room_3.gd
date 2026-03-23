extends Node2D
var camera
var main 
var dialog_box
var can_click = true
var key = preload("res://scenes/key.tscn")
var password
@export var target = 1
@export var room_number = 3
#ONREADYS 
@onready var window: CollisionShape2D = $window/CollisionShape2D
@onready var chart: CollisionShape2D = $chart/CollisionShape2D
@onready var locked: CollisionShape2D = $locked/CollisionShape2D
@onready var center: Marker2D = $Marker2D
#STATES
var on_chart = false
var on_locked = false
var on_window = false
var password_loaded = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Manager.show_key.connect(on_show_key)
	main = get_tree().current_scene
	camera = main.get_node_or_null("Node").get_node_or_null("camera")
	dialog_box =  main.get_node("CanvasLayer/dialog_box")
	_return_to_main()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	camera.position = camera.position.lerp(target.position,delta*3)
func _input(event):
	if event.is_action_pressed("click"):
		dialog(on_window,window,"It's locked. Seems like you need 3 keys.")
		dialog(on_chart,chart,"Some kind of code?")
		if Manager.key3_visible and on_locked:
			dialog(on_locked,locked,"You already found a key")
		else:
			dialog(on_locked,locked,"You need a password")
func dialog(on_what,target_what,text_what)-> void: 
	if on_what and can_click: 
		can_click = false
		target = target_what
		if on_what !=on_locked:
			camera.zoom = Vector2(1.7,1.7)
		else:
			camera.zoom = Vector2(2.3,2.3)
		Manager.emit_signal("hide_arrows",self)
		dialog_box.text.text = text_what
		dialog_box.visible = true 
		dialog_box.load_text()
		if on_what == on_locked and !Manager.key3_visible and !password_loaded:
			password = load("res://scenes/password.tscn").instantiate()
			password.position = Vector2(829,293)
			password.add_to_group("room")
			main.get_node("CanvasLayer").add_child.call_deferred(password)
			password_loaded = true
func _on_window_mouse_entered() -> void:
	on_window = true
func _on_window_mouse_exited() -> void:
	on_window = false
func _on_chart_mouse_entered() -> void:
	on_chart = true
func _on_chart_mouse_exited() -> void:
	on_chart = false
func _on_locked_mouse_entered() -> void:
	on_locked = true
func _on_locked_mouse_exited() -> void:
	on_locked = false
func _return_to_main() -> void: 
	target = center
	camera.zoom = Vector2(1.0,1.0)
func on_show_key() -> void: 
	can_click = true
	password.queue_free()
	Manager.key3_visible = true
	var new_key = key.instantiate()
	new_key.add_to_group("key_room_3")
	new_key.get_node("ColorRect").position = Vector2(694,52)
	new_key.get_node("ColorRect").size = Vector2(418,227)
	Manager.key_count += 1 
	main.get_node("Node").add_child.call_deferred(new_key)
	dialog(true,locked,"It opened. You found a key")
