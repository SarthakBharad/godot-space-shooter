extends Control

@export var level_scene: PackedScene = load("res://scenes/level.tscn")

func _ready():
	$CenterContainer/VBoxContainer/Score.text = $CenterContainer/VBoxContainer/Score.text + str(Global.score)

func _input(event):
	if event.is_action_pressed("new game"):
		get_tree().change_scene_to_packed(level_scene)
