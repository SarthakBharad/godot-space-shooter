extends Area2D

@export var speed = 500

func _ready():
	var tween = create_tween()
	tween.tween_property($LaserAvatar, 'scale', Vector2(1,1), 0.15).from(Vector2(0, 0))

func _process(delta: float) -> void:
	position.y -= speed * delta
