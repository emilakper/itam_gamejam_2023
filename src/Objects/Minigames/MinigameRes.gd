@tool

extends Resource

class_name MinigameResource

enum MinigameType {
	BLOOD,
	CORPSE
}

@export 
var TYPE: MinigameType : 
	set(value): 
		TYPE = value 
@export 
var ExcludesForOverwrite: Array[int] :
	set(value):
		ExcludesForOverwrite = value
# I do not know how to pass the file name as a resource 
@export 
var Json: String:
	set(value):
		Json = value
		
		


var texts: Array
var title: String

func getTitle() -> String:
	return title
	
func getTexts() -> Array:
	return texts


var typeString: String

func _init(p_type: MinigameType = MinigameType.BLOOD, p_excludes_overwrite: Array[int] = [], p_path_to_json = ""):
	match TYPE:
		MinigameType.BLOOD:
			typeString = "blood"
		MinigameType.CORPSE:
			typeString = "corpse"

	
	
	
	
func parse():
	assert(!typeString.is_empty(), "Type was empty")
	assert(!Json.is_empty(), "Json path was not provided")
	var json = JSON.new()
	var err: Error = json.parse(__readJsonFile(Json))
	var json_data = json.data
	assert(err == OK)
	texts = json_data[typeString]["possible_strings"]
	title = json_data[typeString]["title"]
	
	



func __readJsonFile(json_path: String) -> String:
	assert(FileAccess.file_exists(json_path), "File was not found[" + json_path + "]")
	var file = FileAccess.open(json_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return content
