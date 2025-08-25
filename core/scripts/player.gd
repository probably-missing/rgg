extends RigidBody3D

var controlable_movement = true
var controlable_camera = true
var speed = 25
var jump = 100
var max_speed = 10
var health = 300

func _ready() -> void:
	Handler.loadout("pull", self) # yo where my guns at?

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("killbind"):
		damage(10000000)

func _physics_process(delta: float) -> void:
	if controlable_movement == true:
		$CameraPivot.global_position = global_position
		rotation.y = $CameraPivot.rotation.y
		
		# rules for if the player IS on the ground
		if $ShapeCast3D.is_colliding() == true:
			if linear_velocity.length() > max_speed:
				linear_velocity = (linear_velocity.normalized()) * max_speed

			# m o v e m e n t
			if Input.is_action_pressed("up"):
				apply_central_force(-global_transform.basis.z.normalized()*(speed*5))
			if Input.is_action_pressed("down"):
				apply_central_force(global_transform.basis.z.normalized()*(speed*5))
			if Input.is_action_pressed("left"):
				apply_central_force(-global_transform.basis.x.normalized()*(speed*5))
			if Input.is_action_pressed("right"):
				apply_central_force(global_transform.basis.x.normalized()*(speed*5))
			if Input.is_action_pressed("jump"):
				apply_central_force(global_transform.basis.y.normalized()*(jump*5))

		# rules for if the player is NOT on the ground
		else:
			# m o v e m e n t
			if Input.is_action_pressed("up"):
				apply_central_force(-global_transform.basis.z.normalized()*(speed*2))
			if Input.is_action_pressed("down"):
				apply_central_force(global_transform.basis.z.normalized()*(speed*2))
			if Input.is_action_pressed("left"):
				apply_central_force(-global_transform.basis.x.normalized()*(speed*3))
			if Input.is_action_pressed("right"):
				apply_central_force(global_transform.basis.x.normalized()*(speed*3))


		if Input.is_action_pressed("left"):
			$CameraPivot.rotation.z = (0.02)
		elif Input.is_action_pressed("right"):
			$CameraPivot.rotation.z = (-0.02)
		else:
			$CameraPivot.rotation.z = (0)

func damage(damage):
	if damage < health:
		health -= damage
		print(name, " was hurt for ", damage)
	else:
		health = 0
	if health == 0:
		Handler.death(self)
	$HUD/healthbar.value = health
