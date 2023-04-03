# fight state
extends PlayerState


func enter(_msg := {}) -> void:
	print("ENTER STATE: SHOOT")
	player.anim.current_animation = player.ANIM_SHOOT
	player.velocity = Vector2.ZERO
	player.idle_timer.stop()


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	if Input.is_action_just_pressed("run"):
		state_machine.transition_to("Run")

