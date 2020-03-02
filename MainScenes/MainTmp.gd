"""
Author: Jayanth L (Indie Dev)

This Script is attached to the MainTmp entry scene, which controls various aspect of the game as explained below
"""

extends Node2D

# preoad the pin scene so that it can be instantiated when needed
var pin_path = preload("res://Scenes/Pin.tscn")


# Load Game Manager Singleton Script
onready var game_manager = get_node("/root/GameManager")


func _process(delta):
	# when everytime spacebar or jump is pressed spawn a pin at the spawing point in Scene
	if Input.is_action_just_pressed("jump"):
		spawn_pin()



# Method to spawn  a pin
func spawn_pin():
	# instantiate the pin scene
	var pin = pin_path.instance()
	# set position on the pin
	pin.position = $PinSpawnPoint.position
	# Make pin smaller as the image dimensions are big
	pin.scale = Vector2(0.5, 0.5)
	# Load the pin into to scene so that it appears
	add_child(pin)