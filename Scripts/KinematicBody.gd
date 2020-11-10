extends KinematicBody

export(float) var walk_accel = 10000
export(float) var max_walk_speed = 1
export(float) var max_run_speed = 2
export(float) var jump_speed = 0
export(float) var gravity = -50
export(float) var sensitivity = 0.2
export(float) var friction = 100

var velocity = Vector3()
var looking = Vector3()
var looking_x
var looking_y
var viewport

func _ready():
	viewport = get_node("Viewport")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		looking.y -= deg2rad(event.relative.x * sensitivity)
		looking.x -= deg2rad(event.relative.y * sensitivity)
		looking.x = clamp(looking.x, -PI/3, PI/3)
		viewport.rotation.y = looking.y
		viewport.rotation.x = looking.x
func _physics_process(delta):
	
	if velocity.x > friction:
		velocity.x -= friction
	elif velocity.x < -friction:
		velocity.x += friction
	else:
		velocity.x = 0

	if velocity.z > friction:
		velocity.z -= friction
	elif velocity.z < -friction:
		velocity.z += friction
	else:
		velocity.z = 0
	velocity.y += gravity * delta
	var forward = Input.is_action_pressed("player_forward")
	var backward = Input.is_action_pressed("player_backward")
	var left = Input.is_action_pressed("player_left")
	var right = Input.is_action_pressed("player_right")
	var jump = Input.is_action_just_pressed("player_jump")
	var run = Input.is_action_pressed("player_run")
	
	if is_on_floor() and jump:
		velocity.y = jump_speed
		
	var walkvector = Vector2()
	walkvector.x += velocity.x
	walkvector.y -= velocity.z
	if forward:
		walkvector += Vector2(walk_accel * delta, 0).rotated(viewport.rotation.y + PI/2)
	if backward:
		walkvector += Vector2(-walk_accel * delta, 0).rotated(viewport.rotation.y + PI/2)
	if left:
		walkvector += Vector2(0, walk_accel * delta).rotated(viewport.rotation.y + PI/2)
	if right:
		walkvector += Vector2(0, -walk_accel * delta).rotated(viewport.rotation.y + PI/2)
	if run:
		walkvector = walkvector.clamped(max_run_speed)
	else:
		walkvector = walkvector.clamped(max_walk_speed)
	velocity = Vector3(walkvector.x, velocity.y, -walkvector.y)
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
