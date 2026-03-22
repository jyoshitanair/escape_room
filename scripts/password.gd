extends ColorRect
var clickable = false
var solved = false
@export var label:Label
var cur_value = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("label 1 value %d"%Manager.label1_value)
	#print("label 2 value %d"%Manager.label2_value)
	#print("label 3 value %d"%Manager.label3_value)
	#print("label 4 value %d"%Manager.label4_value)
	if Manager.label1_value == 5 && Manager.label2_value == 5 && Manager.label3_value == 5 && Manager.label4_value == 5:
		solved = true 
func _input(event):
	if event.is_action_pressed("click") and clickable:
		if cur_value != 9:
			cur_value += 1
		else:
			cur_value = 1
		print(label.get_groups())
		if label.is_in_group("label1"):
			print("yay lev 1")
			Manager.label1_value = cur_value
		if label.is_in_group("label2"):
			print("yay lev 2")
			Manager.label2_value = cur_value
		if label.is_in_group("label3"):
			print("yay lev 3")
			Manager.label3_value = cur_value
		if label.is_in_group("label4"):
			print("yay lev 4")
			Manager.label4_value = cur_value
		label.text = "%d"%cur_value
		print(Manager.label1_value)
func _on_area_2d_mouse_entered() -> void:
	clickable = true
func _on_area_2d_mouse_exited() -> void:
	clickable = false
func _on_area_4_mouse_entered() -> void:
	clickable = true
func _on_area_4_mouse_exited() -> void:
	clickable = false
func _on_area_2_mouse_entered() -> void:
	clickable = true
func _on_area_2_mouse_exited() -> void:
	clickable = false
func _on_area_3_mouse_entered() -> void:
	clickable = true
func _on_area_3_mouse_exited() -> void:
	clickable = false
