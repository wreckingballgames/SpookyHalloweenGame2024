@tool
extends Node


# TODO: Write a parser to take user's language choice and a directory of .xlf
# files to make localization string tables in the form of .tres files
# To store things in res:// instead of user://, you must do it in the editor.
# I think it's okay to ship the game with all of the languages included instead
# of building them when the user picks a language. So make an editor script to
# do this.
# - List high level steps to complete this task here


# TODO: move this tool code to a button in the editor instead of doing on ready
func _ready() -> void:
	if Engine.is_editor_hint():
		# Prefix for absolute file paths
		var path_prefix: String
		# Store all file names (which matches end of file path if you add .xlf)
		var xliff_files: Array[String]
		var parser := XMLParser.new()
		# Get the paths to all the .xlf files first
		parser.open("res://assets/xml/xliff_paths.xml")
		# All nodes in this file should have only one attribute
		while parser.read() != ERR_FILE_EOF:
					if parser.get_node_type() == XMLParser.NODE_ELEMENT:
						if parser.get_node_name() == "xliff_paths":
							path_prefix = parser.get_attribute_value(0)
						elif parser.get_node_name() == "path":
							xliff_files.append(parser.get_attribute_value(0))
		# Make directories for each culture
		for file: String in xliff_files:
			DirAccess.make_dir_absolute(Constants.STRING_RESOURCE_PATH + file)
		# TODO
		# Dynamically build a .gd file that extends Resource and includes all of
		# the exported fields my .tres files need, using the information from
		# the .xlf files. Then create the Resources and set their values
		#
		# alternately TODO just do this outside of Godot like a smart person

		# Parse each .xlf file and build a Resource
		for file: String in xliff_files:
			parser.open(path_prefix + file + ".xlf")
			while parser.read() != ERR_FILE_EOF:
				var node_name: String = parser.get_node_name()
				# If open <file>
				if parser.get_node_type() == XMLParser.NODE_ELEMENT and node_name == "file":
					# Store full path of new file to update easily
					# TODO: Ensure file system updates so devs can see strings after they're created
					#  without reloading godot
					var full_file_path: String = Constants.STRING_RESOURCE_PATH + file + "/" + file + ".tres"
					# Make a new resource corresponding to <file>, named after
					# its id attribute
					var new_resource := Resource.new()
					var save_result := ResourceSaver.save(new_resource, full_file_path)
					print(save_result)
		# For each .xlf file, parse the file and save a Resource for each
		#  <file> to res://resources/localization/strings/<culture>
		# Build the default culture folder first (en)
		# For every other .xlf file, parse trgLang attribute from <xliff> root
		#  to get name for culture folder
		# Each Resource file should be named after the id attribute in its
		#  corresponding <file>
		# Each Resource should have a section with a #region labeling by
		#  the id attribute of each <unit>
		# Then each <segment> should become a field named after the id attribute
		# The field's value will be the content of the <target> tags
		#  (or <source> for the default culture)
