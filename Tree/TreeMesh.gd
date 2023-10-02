@tool
class_name TreeMesh
extends MeshInstance3D


var branches := MeshAttributes.new()
var leaves := MeshAttributes.new()


func add_branch(attrs: MeshAttributes) -> void:
	branches.append_mesh_attributes(attrs)
	

func add_leaf(attrs: MeshAttributes) -> void:
	leaves.append_mesh_attributes(attrs)


func commit_mesh(branch_colour: Color, leaf_colour: Color) -> TreeMesh: # hasbeen -> void
	mesh = ArrayMesh.new()
	
	# add branch surface
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, branches.create_array())
	
	var mat = StandardMaterial3D.new()
	mat.set_albedo(branch_colour)
	mat.set_cull_mode(StandardMaterial3D.CULL_DISABLED)

	set_surface_override_material(0, mat)

	# add leaf surface
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, leaves.create_array())
	
	mat = StandardMaterial3D.new()
	mat.set_albedo(leaf_colour)
	mat.set_cull_mode(StandardMaterial3D.CULL_DISABLED)

	set_surface_override_material(1, mat)
	
	return self # hasbeen void
