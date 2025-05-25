extends Node

# We first export a variable to the Inspector
# so that we can assign mob.tscn or any other monster to it by drag-n-drop
@export var mob_scene: PackedScene


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
