extends Node

# We first export a variable to the Inspector
# so that we can assign mob.tscn or any other monster to it by drag-n-drop
@export var mob_scene: PackedScene

func _ready():
	$UserInterface/Retry.hide()



func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = $SpawnPath/SpawnLocation
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()
	
	var player_position = $Player.position
	# Initialize is our func to modify the object's property before ...
	mob.initialize(mob_spawn_location.position, player_position)
	# adding it
	add_child(mob)
	
	# We connect the mob to the score label to update the score upon squashing one.
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())


func _on_player_hit() -> void:
	$MobTimer.stop()
	print("Game over, you have been hit!")
	$UserInterface/Retry.show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()
