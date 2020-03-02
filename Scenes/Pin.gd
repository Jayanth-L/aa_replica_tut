"""
Author: Jayanth L (Indie Dev)
This Script is attached to the Pin.tscn Scene which contains and handles the Pin assets and behaviour

"""


extends Area2D

# defining global target variable, the rotator is assigned to this at later stages
var target

# preloading the Global GameManager Script so we can access the current game score
onready var game_manager = get_node("/root/GameManager")
# preloading the GameOverTscn scene so we can instance this scene whenever it s needed
onready var end_screen = preload("res://Scenes/GameOverScreen.tscn")


# Defining the speed of the pi, which moves towards the rotatar to get pinned
export var move_speed = 10
# A boolean variable to control the movement of the pin, by default the Pin moves upwards when instantiated 
var should_move = true

# predifining this varialble as global so that we can acces this variables at any section in this script
# later this variables holds the instantaneouss transform of the Rotator when the pin hits rotator
var target_transform_at_hit
# this variable is used to get the transform or coordinates of the point where the pin hits the rotator so we can hook up the pin to rotater at the hit point
var rotate_angle

# This boolean variables tells tells the Pin to whether detect collisions or not when needed, by default it detects any collisions
var detect_pin_collision = true


# This method runs at every frame of the game, this function is useful when the game involves physics like collision detection instead of just _process(delta)
func _physics_process(delta):
	# This if conditions tells the pin to move upward only when it is supposed to move at later stage if we set the should_move variable to false the pin does not move the we can hook it up to rotator
	if should_move:
		position.y -= move_speed * delta
	
	# Note: The below elif section contains a lot Linear algebra in it the concept is quite advanced Watch Associated YouTube Video for more detailed explaination
	# if the pin is not suppossed to move means that we have hit the rotator we will make the Pin hooked to the rotator and follow the rotator
	elif target:
		# Note: This algorithm involves Linear Algebra Math (See line 68 also)
		# In this two lines we rotate Basis Vectors of "PinRotateHookOrigin" to align or displace "PinRotateHook" to the Pin rotator hit co-ordinates so we can 
		# hook up the pin to the rotator
		var x_basis = target.get_node("PinRotateHookOrigin").global_transform.x.rotated(rotate_angle)
		var y_basis = target.get_node("PinRotateHookOrigin").global_transform.y.rotated(rotate_angle)
		# After rotating the basis vectors then apply the resulting the transform to the pin at every frame so that the pin remains hooked to the Rotator hit spot
		transform = Transform2D(x_basis, y_basis, target.get_node("PinRotateHookOrigin").global_transform.origin)

		


# This function is fired when the Pin gets a "body_entered" signal from itself, the Area2D Pin "body_entered" signal is connected to this below function
# this function is trigerred when the Pin collides with the Rotator, when it happes the below mentioned instaruction will be followed
func _on_Pin_body_entered(body):
	# When the rotator collided with the Rotator the its win increment score with 1
	game_manager.game_score += 1
	# Update text in the Main Scene Score text with the current game_manager script score 
	get_tree().get_root().get_node("MainTmp").get_node("ScoreText").text = str(game_manager.game_score)
	# It is obvious that when the pin hits rotator pin should doesn't move, it will be hooked to Rotator, so setting should_move to false will tell the _physics_process to no move Pin
	should_move = false
	# This is used because when the Pin hits Rotator the collision has already occured we don't want to detect further more unnecessary collision
	detect_pin_collision = false
	# Here we are assigning global target variables to the collided body which is Rotator (Pin has collided with the rotator so body variables will be Rotator)
	target = body
	# Note: Involves Linear Algebra Math
	# this gets the instantaneous transform of the "PinRotateHook" Node when the collision occured, this is used to calculate the exact Hit/ Collision Co-ordinates to hook the pin into
	target_transform_at_hit = body.get_node("PinRotateHookOrigin").get_node("PinRotateHook").transform
	# This gets the Delta Angle the PinRotateHookOrigin to be rotated to get to the exact hit/collision or hook point (See Line 43)
	rotate_angle = get_angle_between_transform(target_transform_at_hit, body.global_transform)

# function to get the angle between the transforms,
func get_angle_between_transform(original_transform, instantaneous_transform):
	var offset_angle = original_transform.x.angle_to(instantaneous_transform.x)
	return -offset_angle


# This function is only triggered when only when the Pin collides with the Other Instantiated Pins in the scene, When this occurs, that means that the player is out so now show the end screen
func _on_Pin_area_entered(area):
	# if the pin has detected collision with other Pins then show the endscreen
	if detect_pin_collision:
		print("Collided: ", area.name)
		print("Final Game Score: ", game_manager.game_score)
		# The Game has ended so show the final endscreen!!!
		get_tree().change_scene("res://Scenes/GameOverScreen.tscn")
