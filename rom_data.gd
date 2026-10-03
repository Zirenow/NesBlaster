#Helper class for storing file metadata

class_name RomData

var path:String
var size:int
var data:PackedByteArray
var handle:FileAccess
func _init(p:String) -> void:
	handle=FileAccess.open(p,FileAccess.READ)
	path=p
	size=handle.get_length()
	data=handle.get_buffer(size)
