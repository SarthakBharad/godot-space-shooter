extends Area2D

var meteorSpeed : int
var meteorRotationSpeed : int
var direction_x : float
var can_collide := true

signal collision

func _ready() -> void:
	var rng := RandomNumberGenerator.new()
	
	#Meteor Texture
	var path: String = "res://kenney_space-shooter-redux/PNG/Meteors/" + str(rng.randi_range(1,6)) + ".png"
	$MeteorAvatar.texture = load(path)
	
	#Spawn Position
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	position = Vector2(random_x, random_y)
	
	#Meteor Speed, Rotation Speed and Direction
	meteorSpeed = rng.randi_range(250, 750)
	direction_x = rng.randf_range(-1 , 1)
	meteorRotationSpeed = rng.randi_range(25, 100)

func _process(delta: float) -> void:
	position += Vector2(direction_x, 1.0) * meteorSpeed * delta
	rotation_degrees += meteorRotationSpeed * delta

func _on_body_entered(_body) -> void:
	if can_collide:
		collision.emit()

func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	$MeteorDestroySound.play()
	$MeteorAvatar.hide()
	can_collide = false
	await get_tree().create_timer(1).timeout
	queue_free()
