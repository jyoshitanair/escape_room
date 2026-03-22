extends Node2D
var camera
@export var target = 1
#ONREADYS 
@onready var angry_teacher: CollisionShape2D = $angry_teacher/CollisionShape2D
@onready var center: Marker2D = $Marker2D
#STATES
var on_teacher = false
var can_click = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_tree().current_scene.get_node_or_null("Node").get_node_or_null("camera")
	_return_to_main()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera.position = camera.position.lerp(target.position,delta*3)
func _input(event):
	if event.is_action_pressed("click"):
		if on_teacher and can_click:
			print("hi")
			target = angry_teacher
			camera.zoom = Vector2(1.7,1.7)
			Manager.emit_signal("hide_arrows",self)
			can_click = false
func _on_angry_teacher_mouse_entered() -> void:
	on_teacher = true 
func _on_angry_teacher_mouse_exited() -> void:
	on_teacher = false 
func _return_to_main() -> void: 
	target = center
	camera.zoom = Vector2(1.0,1.0)
