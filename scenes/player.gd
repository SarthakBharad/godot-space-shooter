extends CharacterBody2D

@export var playerSpeed := 750
var can_shoot : bool = true
var laser_sound_toggle : bool = true

signal laser(pos)

func _ready() -> void:
	position = Vector2(960, 960)

func _process(_delta) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * playerSpeed
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		#laser sound
		var sound_file = "sfx_laser1.ogg" if laser_sound_toggle else "sfx_laser2.ogg"
		var path = "res://kenney_space-shooter-redux/Bonus/"
		$LaserSound.stream = load(path + sound_file)
		$LaserSound.play()
		laser_sound_toggle = !laser_sound_toggle
		
		laser.emit($LaserMarker.global_position)
		can_shoot = false
		$LaserTimer.start()

func _on_laser_timer_timeout() -> void:
	can_shoot = true
	
func _play_collision_sound():
	$DamageSound.play()
