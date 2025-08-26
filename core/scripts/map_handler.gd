extends Node

# remember: root is one level up, use ../ at the start of all your paths to reach stuff correctly

func startup() -> void:
	var spawnpoint = get_node_or_null("../WorldEnvironment/spawn") # go one up into the root and yoink the spawn point
	if spawnpoint == null: # check if spawn DOESN'T exist
		print(spawnpoint)
		Handler.error("spawn doesn't exist in map!")
	else: spawn(spawnpoint) # if it does, spawn the player.

func spawn(spawnpoint):
	var player = Handler.player_scene.instantiate()
	spawnpoint.add_child(player)
	player.global_position = spawnpoint.global_position
