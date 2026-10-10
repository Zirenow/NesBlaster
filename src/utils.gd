extends Node
# Helper class with all sorts of usefull constants and functions

enum Platform {
	WINDOWS,
	MACOS,
	LINUX,
	ANDROID,
	IOS,
	WEB,
	UNKNOWN
}

var project_platform: Platform
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match OS.get_name():
		"Windows":
			project_platform = Platform.WINDOWS
		"macOS":
			project_platform = Platform.MACOS
		"Linux":
			project_platform = Platform.LINUX
		"Android":
			project_platform = Platform.ANDROID
		"iOS":
			project_platform = Platform.IOS
		"Web":
			project_platform = Platform.WEB
		_:
			project_platform = Platform.UNKNOWN

func is_file_executable(file:String)->bool:
	match Platform:
		Platform.LINUX:
			if OS.execute("test", ["-x", file])==0:
				return true
			else:
				return false
		_:
			return false


# Handy coroutine that opens file explorer and returns file path
func get_file_from_explorer()->String:
	var _path:String
	var dialog := FileDialog.new()
	dialog.title = "Select a file"
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.access = FileDialog.ACCESS_FILESYSTEM

	dialog.size = Vector2i(600, 450)
	dialog.transient = false
	dialog.exclusive = false

	get_tree().root.add_child(dialog)
	dialog.popup_centered()
	return await dialog.file_selected
