"""
Author: Jayanth L (Indie Dev)
This Script is attached to the TextlabelFild in the GameOverScreen.tscn and manages the final score showed after game overs

"""

extends RichTextLabel

# preloading the Global GameManager Script so we can access the current game score
onready var game_manager = get_node("/root/GameManager")


func _ready():
	# Setting the ScoreTextlabel in this game over scene to the current score value in the GameManager Script
	# as the text field accepts string we are typecasting the int score to string score
	text = str(game_manager.game_score)


# this function extected at every frame
func _process(delta):
	# When the button "r" associated with the restart input event in godot input settings is pressed the restart the game
	if Input.is_action_just_pressed("restart"):
		# This below statement reloads the MainTmp Game Scene so the game strats again
		get_tree().change_scene("res://MainScenes/MainTmp.tscn")