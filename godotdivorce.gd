@tool
extends EditorPlugin

const GODOTTOGETHER := "res://addons/GodotTogether/"

func _enable_plugin() -> void:
	var path := ProjectSettings.globalize_path(GODOTTOGETHER)

	if DirAccess.dir_exists_absolute(path):
		_remove_directory(path)


func _remove_directory(path: String) -> void:
	var dir := DirAccess.open(path)

	if dir == null:
		return

	dir.list_dir_begin()

	while true:
		var file_name := dir.get_next()

		if file_name == "":
			break

		if file_name == "." or file_name == "..":
			continue

		var item_path := path.path_join(file_name)

		if dir.current_is_dir():
			_remove_directory(item_path)
		else:
			DirAccess.remove_absolute(item_path)

	dir.list_dir_end()
	dir = null

	DirAccess.remove_absolute(path)


func _disable_plugin() -> void:
	pass


func _enter_tree() -> void:
	pass


func _exit_tree() -> void:
	pass
