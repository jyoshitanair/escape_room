extends Control
var tween
var duration 
@onready var text: RichTextLabel = $Panel/RichTextLabel
@onready var timer: Timer = $Timer
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
func load_text()-> void:
	text.visible_ratio = 0
	tween = create_tween()
	duration = 0.5+(0.045*text.text.length())
	tween.tween_property(text,"visible_ratio",1.0,duration)
	await tween.finished
	timer.start()
func _on_timer_timeout() -> void:
	if Manager.cur_room: 
		Manager.cur_room.can_click = true
	visible = false
