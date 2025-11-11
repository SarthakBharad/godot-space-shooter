extends Node2D

var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")
var health : int = 5

func _ready():
	#set health
	get_tree().call_group('ui', 'set_health', health)
	
	#Stars
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for star in $Stars.get_children():
		#position
		var random_x = rng.randi_range(int(size.x), 0)
		var random_y = rng.randi_range(0, int(size.y))
		star.position = Vector2(random_x, random_y)
		
		#scale
		var random_scale = rng.randf_range(0.1,1)
		star.scale = Vector2(random_scale, random_scale)
		
		#animation speed
		star.speed_scale = rng.randf_range(0.5, 1)

func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	$Meteors.add_child(meteor)
	
	meteor.connect('collision', _on_meteor_collision)

func _on_meteor_collision():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/gameover.tscn")
	$Player._play_collision_sound()

func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
