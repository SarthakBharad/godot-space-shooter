extends CanvasLayer

static var imagePath = load("res://kenney_space-shooter-redux/PNG/UI/playerLife1_green.png")
var time_elapsed := 0

func set_health(amount):
	#removing all children
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	
	#create new children and amount is set by health
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = imagePath
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		$MarginContainer2/HBoxContainer.add_child(text_rect)
		

func _on_score_timer_timeout() -> void:
	time_elapsed += 1
	$MarginContainer/Scorecard.text = str(time_elapsed)
	Global.score = time_elapsed
