extends Node2D

var pin_path = preload("res://Scenes/Pin.tscn")


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		spawn_pin()


func spawn_pin():
	var pin = pin_path.instance()
	pin.position = $PinSpawnPoint.position
	add_child(pin)