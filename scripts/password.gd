extends ColorRect
var clickable = false
var solved = false
@export var label:Label
var cur_value = 1

func _input(event):
	if event.is_action_pressed("click") and clickable:
		if cur_value != 10:
			cur_value += 1
		if cur_value == 10:
			cur_value = 0
		if label.is_in_group("label1"):
			Manager.label1_value = cur_value
		if label.is_in_group("label2"):
			Manager.label2_value = cur_value
		if label.is_in_group("label3"):
			Manager.label3_value = cur_value
		if label.is_in_group("label4"):
			Manager.label4_value = cur_value
		label.text = "%d"%cur_value
		_check_solved()
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


func _on_button_pressed() -> void:
	_check_solved()
	if solved: 
		print("emmiting")
		Manager.emit_signal("show_key")
func _check_solved() -> void: 
	for i in range(1,4):
		var room_name = "room%d"%i
		if Manager.cur_room.room_number == i:
			var room_password = Manager.get("password_%d" % i)
			print(room_password)
			if room_password and \
			Manager.label1_value == room_password[0] and \
			Manager.label2_value == room_password[1] and \
			Manager.label3_value == room_password[2] and \
			Manager.label4_value == room_password[3]:
				print("solved")
				solved = true
				break
