@tool
class_name Turtle
extends RefCounted


var transform_stack := [TurtleTransform.new()]

var root: Root = Root.new()
var current: Branch = root
var branch_stack := [root]


func create_branch(length: float, variance: float, thickness: float, colour: Color) -> void:
	# get current transform
	var transform: TurtleTransform = transform_stack[-1]
	
	# get the start and end points for the branch
	var point1 := get_current_point()
	transform.move_forward(length * randf_range(1 - variance, 1 + variance))
	var point2 := get_current_point()
	# get the branch's rotation
	var rotation: Basis = get_current_rotation()
	
	# create the branch
	var branch := Branch.new(point1, point2, rotation, thickness, colour)
	current.add_child_branch(branch)
	branch.set_parent_branch(current)
	current = branch
	

# rotate the current transform around an axis
func rotate(axis: Vector3, angle: float) -> void:
	var transform: TurtleTransform = transform_stack[-1]
	transform.rotate(axis, deg_to_rad(angle))
	

func push() -> void:
	transform_stack.push_back(TurtleTransform.new())
	branch_stack.push_back(current)
	

func pop() -> void:
	transform_stack.pop_back()
	current = branch_stack.pop_back()
	

func get_current_rotation() -> Basis:
	var rotation := Basis()
	for transform in transform_stack:
		rotation *= transform.rotation
	return rotation


# returns the point (0, 0, 0) tranformed by each transformation from the stack
func get_current_point() -> Vector3:
	var rotation := Basis()
	var point := Vector3()
	
	for transform in transform_stack:
		point += rotation * transform.position
		rotation *= transform.rotation
	
	return point
	

func get_tree() -> Root:
	return root
