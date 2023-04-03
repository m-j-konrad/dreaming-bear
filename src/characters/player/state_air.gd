# air state
# handles everything in the air: jumping and falling
extends PlayerState


# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	print("ENTER STATE: AIR")
	player.idle_timer.stop()
	if msg.has("do_jump"):
		player.fall_frames = 0
		player.jump_frames = 0
		player.velocity.y += player.jump_velocity
		player.anim.current_animation = player.ANIM_JUMP


func physics_update(delta: float) -> void:
	player.fall_frames += 1
	
	if player.fall_frames == player.frames_to_fall:
		player.anim.current_animation = player.ANIM_FALL
	
	if Input.is_action_pressed("jump") and player.jump_frames < player.max_jump_frames:
		player.velocity.y += player.jump_velocity * delta
		player.jump_frames += 1
		
	if Input.is_action_just_released("jump") or player.jump_frames > player.max_jump_frames:
		player.jump_frames = player.max_jump_frames
		player.velocity.y += player.gravity * 0.25
	
	# Landing.
	if player.is_on_floor():
		if player.fall_frames > player.frames_to_fall:
			state_machine.transition_to("Sit")
		elif is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
		player.fall_frames = 0

