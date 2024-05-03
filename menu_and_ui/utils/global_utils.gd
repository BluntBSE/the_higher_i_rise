class_name GlobalUtils

static func get_script_by_name(name_of_class:String) -> Script:
	if ResourceLoader.exists(name_of_class, "Script"):
		return load(name_of_class) as Script

	for global_class in ProjectSettings.get_global_class_list():
		var found_name_of_class:String = global_class["class"]
		var found_path:String = global_class["path"]
		if found_name_of_class == name_of_class:
			return load(found_path) as Script

	return null
	
static func instantiate_class(name_of_class:String) -> Object:
	if name_of_class.is_empty():
		return null

	var result:Object = null
	if ClassDB.class_exists(name_of_class):
		result = ClassDB.instantiate(name_of_class)
	else:
		var script := get_script_by_name(name_of_class)
		if script is GDScript:
			result = (script as GDScript).new()
		else:
			return null

	return result
