# idle state
extends PlayerState


func enter(_msg := {}) -> void:
	print("ENTER STATE: IDLE")
	
	player.anim.current_animation = player.ANIM_IDLE
	player.velocity = Vector2.ZERO
	player.idle_timer.start(player.max_idle_time)


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	if Input.is_action_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		state_machine.transition_to("Run")
	elif Input.is_action_just_pressed("use"):
		state_machine.transition_to("Talk")


