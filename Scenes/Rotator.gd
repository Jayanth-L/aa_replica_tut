"""
Author: Jayanth L (Indie Dev)
Attached to Rotator.tscn which handles the Rotation Scene and controls it

"""

extends KinematicBody2D

# declaring the Black circle Rotator speed
export var rotate_speed = 60


# Rotate the Rotator everyframe with a speed of 60 degrees
func _process(delta):
	linear_rotate(delta)

# function to rotate the rotator
func linear_rotate(delta):
	# Delta is used to sync the framerate with rotation speed so tht there are no frame drops
	rotate(deg2rad(rotate_speed) * delta)