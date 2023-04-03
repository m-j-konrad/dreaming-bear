# walk state
extends PlayerState


func enter(_msg := {}) -> void:
	print("ENTER STATE: WALK")
	
	if player.fall_frames > 85:
		player.anim.current_animation = player.ANIM_SIT
		await get_tree().create_timer(0.2).timeout
		player.fall_frames = 0
	
	player.anim.current_animation = player.ANIM_WALK
	player.idle_timer.stop()
	
	var direction = Input.get_axis("left", "right")
	if direction:
		# set player velocity to speed
		player.velocity.x = direction * player.speed
	else:
		# decrease player velocity
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
		
	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		state_machine.transition_to("Idle")
