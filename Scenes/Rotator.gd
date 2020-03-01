extends KinematicBody2D

export var rotate_speed = 60


func _ready():
	pass

func _process(delta):
	rotate(deg2rad(rotate_speed) * delta)