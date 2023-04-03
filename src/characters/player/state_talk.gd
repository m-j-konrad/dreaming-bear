# talk state
extends PlayerState


func enter(_msg := {}) -> void:
	print("ENTER STATE: TALK")
	player.anim.current_animation = player.ANIM_TALK
	player.velocity = Vector2.ZERO
	player.idle_timer.stop()


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return

	if Input.is_action_just_released("use"):
		state_machine.transition_to("Idle")

