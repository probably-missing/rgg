extends Node

# remember: root is one level up, use ../ at the start of all your paths to reach stuff correctly

func startup() -> void:
	var spawnpoint = get_node_or_null("../WorldEnvironment/spawns/orange_spawns/spawn1") # yoink the spawn points
	if spawnpoint == null: # check if spawn DOESN'T exist
		print(spawnpoint)
		Handler.error("spawn doesn't exist in map!")
	else: spawn(spawnpoint) # if it does, spawn the player.

func spawn(spawnpoint):
	var player = Handler.player_scene.instantiate()
	spawnpoint.add_child(player)
	add_to_group("orange") # i still need to actually ask the player what team they wanna be on buttt i'll do that later
	player.global_position = spawnpoint.global_position
