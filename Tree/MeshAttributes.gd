class_name MeshAttributes
extends RefCounted


var num_verts: int = 0
var verts := PackedVector3Array()
var uvs := PackedVector2Array()
var normals := PackedVector3Array()
var indices := PackedInt32Array()


func append_vertex(v: Vector3) -> void:
	verts.append(v)
	num_verts += 1
	

func append_verts(v: PackedVector3Array) -> void:
	verts.append_array(v)
	num_verts += v.size()
	

func append_uv(uv: Vector2) -> void:
	uvs.append(uv)
	

func append_uvs(uv: PackedVector2Array) -> void:
	uvs.append_array(uv)
	

func append_normal(n: Vector3) -> void:
	normals.append(n)
	

func append_normals(n: PackedVector3Array) -> void:
	normals.append_array(n)
	

func append_index(i: int, add_vertex_count: bool = true) -> void:
	if add_vertex_count:
		i += num_verts
	indices.append(i)
	

func append_indices(indices_: PackedInt32Array, add_vertex_count: bool = true) -> void:
	if add_vertex_count:
		for i in (indices_.size()):
			indices_[i] += num_verts
	indices.append_array(indices_)
	

func append_mesh_attributes(attrs: MeshAttributes) -> void:
	append_uvs(attrs.uvs)
	append_normals(attrs.normals)
	append_indices(attrs.indices)
	append_verts(attrs.verts)


func create_array() -> Array:
	var arr := []
	arr.resize(Mesh.ARRAY_MAX)
	arr[Mesh.ARRAY_VERTEX] = verts
	arr[Mesh.ARRAY_TEX_UV] = uvs
	arr[Mesh.ARRAY_NORMAL] = normals
	arr[Mesh.ARRAY_INDEX] = indices
	
	return arr
	
