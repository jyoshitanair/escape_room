extends Node2D
var camera
var main 
var dialog_box
var can_click = true
@export var target = 1
@export var room_number = 4
#ONREADYS 
@onready var jett: CollisionShape2D = $Jett/CollisionShape2D
@onready var desks: CollisionShape2D = $desks/CollisionShape2D
@onready var center: Marker2D = $Marker2D
#STATES
var on_jett = false
var on_desks = false
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
		dialog(on_jett,jett,"What are you looking at punk?! -Jett")
		dialog(on_desks,desks,"Just some desks")
func dialog(on_what,target_what,text_what)-> void: 
	if on_what and can_click: 
		can_click = false
		target = target_what
		camera.zoom = Vector2(1.7,1.7)
		Manager.emit_signal("hide_arrows",self)
		dialog_box.text.text = text_what
		dialog_box.visible = true 
		dialog_box.load_text()
func _on_jett_mouse_entered() -> void:
	on_jett = true
func _on_jett_mouse_exited() -> void:
	on_jett = false
func _on_desks_mouse_entered() -> void:
	on_desks = true
func _on_desks_mouse_exited() -> void:
	on_desks = false
func _return_to_main() -> void: 
	target = center
	camera.zoom = Vector2(1.0,1.0)
