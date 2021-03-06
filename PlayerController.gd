extends Node2D

var has_queued_click = false
var click_position = Vector2(0, 0)

var humans  = [preload("res://SFX/punch1.wav"),preload("res://SFX/punch2.wav")]
var seals = [preload("res://SFX/seal.wav")]

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action("click"):
			has_queued_click = true
			click_position = event.global_position
			
func _physics_process(delta):
	if has_queued_click:
		has_queued_click = false
		
		var phys = get_world_2d().direct_space_state
		var result = phys.intersect_point(click_position, 3)
		
		for obj in result:
			var collider = obj["collider"]
			if collider.has_method("get_obj"):
				collider = collider.get_obj()
			if collider.is_in_group("mob"):
				if collider.is_human:
					$AudioStreamPlayer2D.set_stream(humans[randi()%humans.size()])
					$AudioStreamPlayer2D.play()
					collider.queue_free()
				else:
					$AudioStreamPlayer2D.set_stream(seals[randi()%seals.size()])
					$AudioStreamPlayer2D.play()
					GameState.shake = 80
					collider.queue_free()
					GameState.reduce_lives()
				return