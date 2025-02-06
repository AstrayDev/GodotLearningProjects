class_name FileSearch

static func search_for_file(path: String, file_to_find: String) -> String:
	var dir_access: DirAccess = DirAccess.open(path)

	if dir_access:
		dir_access.list_dir_begin()
		var current_file: String = dir_access.get_next()

		while current_file != "":
			var current_path: String = path + "/" + current_file
			if dir_access.current_is_dir():
				var result: String = search_for_file(current_path, file_to_find)
				if result != "File not found":
					return result
			else:
				if current_file == file_to_find:
					return path + "/" + current_file
			current_file = dir_access.get_next()
	return "File not found"