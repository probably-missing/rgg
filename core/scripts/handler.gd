extends Node

var player_scene = preload("res://core/scenes/player/player.tscn")

var slot1 = null
var slot2 = null
var slot3 = null
var slot4 = null

func host() -> void:
	error("feature nonexistent!")

func join() -> void:
	error("feature nonexistent!")

func singleplayer() -> void:
	get_tree().change_scene_to_file("res://core/maps/s&_dev.tscn")
	await get_tree().create_timer(0.1).timeout
	var scene_root = get_tree().current_scene
	var parent = scene_root.get_node_or_null("WorldEnvironment/special")
	var spawn = parent.get_node_or_null("spawn")
	var player = player_scene.instantiate()
	parent.add_child(player)
	player.global_position = spawn.global_position
	

func loadout(mode, source):
	if mode == "pull": # get the weapons options on scene change
		slot1 = source.get_node("VBoxContainer2/slot1").selected
		print("we have ", slot1, " equipped in slot1")
	if mode == "push": # give the player their weapons, source SHOULD be the player.
		var slot1_scene = null
		if slot1 == 0: # nothing
			print("player has nothing in slot1.")
		if slot1 == 1: # dev gun
			slot1_scene = preload("res://core/scenes/weapons/weapon_gun_dev.tscn").instantiate()
			print("player has dev gun in slot1.")
		else:
			push_warning("the item in slot1 is invalid! current value is: ", slot1)
			
		if slot1_scene != null:
			source.add_child(slot1_scene)
			slot1_scene.global_position = source.get_node("weapon_pos1").global_position
		print(source.get_node("weapon_pos1").global_position)

func death(player):
	player.controlable_movement = false # you ain't going nowhere
	player.axis_lock_angular_x = false # you CAN roll around on the ground tho
	player.axis_lock_angular_y = false
	player.axis_lock_angular_z = false
	player.get_node("AudioStreamPlayer3D").play(0) # i love caleb city sound effects lmaooo
	player.get_node("AudioStreamPlayer3D2").play(0)
	player.get_node("CameraPivot").top_level = false
	player.get_node("CameraPivot/Camera3D").controlable = false
	await get_tree().create_timer(3).timeout
	player.queue_free()
	singleplayer()
	# wait several seconds
	# play disconnecting animation
	# respawn player
	# play reconnect animation
	# give control back to player

func error(error):
	get_tree().change_scene_to_file("res://core/scenes/menus/error.tscn")
	while get_tree().current_scene == null or get_tree().current_scene.scene_file_path != "res://core/scenes/menus/error.tscn":
		await get_tree().process_frame  # wait one frame before checking again
	
	get_tree().current_scene.get_node("main/VBoxContainer/error_code").text = "[center][color=#ff554c][pulse freq=1.0 color=black ease=-1.0] error: " + str(error) + "[/pulse][/color][/center]"
	push_error("yo, we fucked up. error:", error)
