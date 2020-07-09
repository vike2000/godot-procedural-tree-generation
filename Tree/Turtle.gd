tool
extends Object
class_name Turtle

var transform_stack := [TurtleTransform.new()]

func create_line(length: float, thickness: float, colour: Color) -> Branch:
	var transform: TurtleTransform = transform_stack[-1]
	
	var point1 := get_current_point()
	transform.move_forward(length)
	var point2 := get_current_point()
	var rotation: Basis = get_current_rotation()
	
	return Branch.new(point1, point2, rotation, thickness, colour)
	
func rotate(axis: Vector3, angle: float) -> void:
	var transform: TurtleTransform = transform_stack[-1]
	transform.rotate(axis, deg2rad(angle))
	
func push() -> void:
	transform_stack.push_back(TurtleTransform.new())
	
func pop() -> void:
	transform_stack.pop_back()
	
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