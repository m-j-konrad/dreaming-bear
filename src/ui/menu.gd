extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	# set focus to start button
	$C/btnContinueGame.grab_focus()
	# connect button functionality
	$C/btnNewGame.pressed.connect(func(): start_new_game())
	$C/btnContinueGame.pressed.connect(func(): continue_game())
	$C/btnOptions.pressed.connect(func(): options())
	$C/btnStory.pressed.connect(func(): story())
	$C/btnQuit.pressed.connect(func(): get_tree().quit())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_new_game():
	pass


func continue_game():
	pass


func options():
	var res = load("res://src/ui/options.tscn").instantiate()
	get_tree().current_scene.add_child(res)


func story():
	var res = load("res://src/ui/story.tscn").instantiate()
	get_tree().current_scene.add_child(res)

