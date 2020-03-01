extends Area2D

var target


export var move_speed = 10
var should_move = true

var target_transform_at_hit
var rotate_angle

var detect_pin_collision = true


func _physics_process(delta):
	if should_move:
		position.y -= move_speed * delta
	elif target:
		print()
		# transform = target.get_node("PinRotateHookOrigin").get_node("PinRotateHook").global_transform
		#transform = Transform2D(target.transform.x , target.transform.y, target.transform.origin)
		var x_basis = target.get_node("PinRotateHookOrigin").global_transform.x.rotated(rotate_angle)
		var y_basis = target.get_node("PinRotateHookOrigin").global_transform.y.rotated(rotate_angle)
		transform = Transform2D(x_basis, y_basis, target.get_node("PinRotateHookOrigin").global_transform.origin)

		


func _on_Pin_body_entered(body):
	print("Body entered: ", body.name)
	should_move = false
	detect_pin_collision = false
	target = body
	target_transform_at_hit = body.get_node("PinRotateHookOrigin").get_node("PinRotateHook").transform
	rotate_angle = get_angled_between_transform(target_transform_at_hit, body.global_transform)

func get_angled_between_transform(original_transform, instantaneous_transform):
	var offset_angle = original_transform.x.angle_to(instantaneous_transform.x)
	
	
	"""
	var orig_x_angle = original_transform.x.angle()
	var inst_x_angle = instantaneous_transform.x.angle()
	var orig_y_angle = original_transform.y.angle()
	var inst_y_angle = instantaneous_transform.y.angle()
	
	if(orig_x_angle < inst_x_angle):
		x_angle = x_angle + PI
	if(orig_y_angle < inst_y_angle):
		y_angle = y_angle + PI
	"""
	return -offset_angle


func _on_Pin_area_entered(area):
	if detect_pin_collision:
		print("Collided: ", area.name)
		get_tree().quit()
