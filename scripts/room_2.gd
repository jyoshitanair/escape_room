extends Node2D
var camera
var main 
var dialog_box
var can_click = true
@export var target = 1
@export var room_number = 2
#ONREADYS 
@onready var clocks: CollisionShape2D = $clocks/CollisionShape2D
@onready var globe: CollisionShape2D = $globe/CollisionShape2D
@onready var books: CollisionShape2D = $books/CollisionShape2D
@onready var locked: CollisionShape2D = $locked/CollisionShape2D
@onready var center: Marker2D = $Marker2D
#STATES
var on_clocks = false
var on_globe = false
var on_books = false
var on_locked = false
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

		dialog(on_clocks,clocks,"A lot of clocks. Weird.")
		dialog(on_globe,globe,"Is this a geography class?")
		dialog(on_books,books,"Just some books.")
		dialog(on_locked,locked,"It's locked")
func dialog(on_what,target_what,text_what)-> void: 
	if on_what and can_click: 
		can_click = false
		target = target_what
		camera.zoom = Vector2(1.7,1.7)
		Manager.emit_signal("hide_arrows",self)
		dialog_box.text.text = text_what
		dialog_box.visible = true 
		dialog_box.load_text()		
func _on_clocks_mouse_entered() -> void:
	on_clocks = true
func _on_clocks_mouse_exited() -> void:
	on_clocks = false

func _on_globe_mouse_entered() -> void:
	on_globe = true
func _on_globe_mouse_exited() -> void:
	on_globe = false

func _on_books_mouse_entered() -> void:
	on_books = true
func _on_books_mouse_exited() -> void:
	on_books = false

func _on_locked_mouse_entered() -> void:
	on_locked = true
func _on_locked_mouse_exited() -> void:
	on_locked = false
	
func _return_to_main() -> void: 

	target = center
	camera.zoom = Vector2(1.0,1.0)
