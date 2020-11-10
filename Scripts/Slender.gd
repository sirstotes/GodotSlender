extends KinematicBody

var path = []
var path_node = 0
var is_visible = false

export(float) var movement_speed = 10

onready var nav = get_parent()
onready var player = $"../../Player"
var right 
var left

func _ready():
	right = get_node("RightNode")
	left = get_node("LeftNode")

func _process(delta):
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			var speed = movement_speed
			if is_visible:
				speed = 0
			else:
				look_at(player.global_transform.origin, Vector3.UP)
				self.rotation.y -= PI/2
				self.rotation.x = 0
				self.rotation.z = 0
			move_and_slide(direction.normalized() * speed, Vector3.UP)

func _physics_process(delta):
	var space_state = get_world().direct_space_state
	var resultleft = space_state.intersect_ray(left.global_transform.origin, player.global_transform.origin, [self])
	var resultright = space_state.intersect_ray(right.global_transform.origin, player.global_transform.origin, [self])
	if get_node("VisibilityNotifier").is_on_screen() and ((resultleft['shape'] == 0) or (resultright['shape'] == 0)):
		is_visible = true
	else:
		is_visible = false
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0

func _on_Timer_timeout():
	move_to(player.global_transform.origin)
