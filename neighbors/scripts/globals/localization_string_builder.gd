@tool
extends Node


# TODO: move this tool code to a button in the editor instead of doing on ready
func _ready() -> void:
	if Engine.is_editor_hint():
		# Prefix for absolute file paths
		var path_prefix: String
		# Store all file names (which matches end of file path if you add .xlf)
		var xliff_files: Array[String]
		var parser := XMLParser.new()
		# Get the paths to all the .xlf files first
		parser.open(Constants.XLF_PATHS)
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

		# NOTE:
		# Doing one script and one Resource per culture for simplicity
		# Breaking them up would be better. Next project.
		# Next project I'll probably handle this outside of GDScript :)

		# Parse the default .xlf file
		# Each <file> gets a comment header based on id
		# Each <unit> gets a comment header based on id
		# Each <segment> corresponds to an export String var named after id
		#  with content as value
		# Each culture gets a Resource based off of this script
		# A global flag determines which Resource is used to get strings
		var script := FileAccess.open("res://scripts/localization/localization_string_table.gd", FileAccess.WRITE)
		script.store_line("class_name LocalizationStringTable")
		script.store_line("extends Resource")
		script.store_line("")

		# Parse default.xlf and build script
		var default_xlf := xliff_files[0]
		parser.open(path_prefix + default_xlf + ".xlf")
		# Build field string in two steps before writing to file
		var field_string: String
		# Store id value for grouping sections with comments
		var id_value: String
		# Store logical prefix for each field
		var field_prefix: String
		# Track if inside <source>, constructing field
		var is_field_open: bool
		while parser.read() != ERR_FILE_EOF:
			var node_name: String = parser.get_node_name()
			var node_type: XMLParser.NodeType = parser.get_node_type()
			# Write comment headers for <file>s and <unit>s
			if node_type == XMLParser.NODE_ELEMENT and node_name == "file":
				id_value = parser.get_attribute_value(0)
				script.store_line("# " + id_value)
				script.store_line("")
			elif node_type == XMLParser.NODE_ELEMENT and node_name == "unit":
				id_value = parser.get_attribute_value(0)
				field_prefix = id_value
				script.store_line("# " + id_value)
				script.store_line("")
			# Build fields with <segment>s and their <source>
			if node_type == XMLParser.NODE_ELEMENT and node_name == "segment":
				# Start field
				field_string = "@export var " + field_prefix + "_" + parser.get_attribute_value(0) + ": String ="

			# Prepare to get data between <source> tags
			if node_type == XMLParser.NODE_ELEMENT and node_name == "source":
				is_field_open = true

			# If inside <source>, add data to field string
			if is_field_open and node_type == XMLParser.NODE_TEXT:
				is_field_open = false
				# Complete field
				field_string = field_string + " " + "\"" + parser.get_node_data() + "\""

			# Create field
			if node_type == XMLParser.NODE_ELEMENT_END and node_name == "source":
				script.store_line(field_string)
				script.store_line("")

		# Final new line
		script.store_line("")
		# Close script, saving it to disk
		script.close()

		# For each .xlf file, parse the file and save a Resource to res://resources/localization/strings/<culture>.tres
		for file: String in xliff_files:
			parser.open(path_prefix + file + ".xlf")
			var new_resource := LocalizationStringTable.new()
			while parser.read() != ERR_FILE_EOF:
				var node_name: String = parser.get_node_name()
				var node_type: XMLParser.NodeType = parser.get_node_type()

				# Get field prefix
				if node_type == XMLParser.NODE_ELEMENT and node_name == "unit":
					field_prefix = parser.get_attribute_value(0)
				# Get complete field name
				if node_type == XMLParser.NODE_ELEMENT and node_name == "segment":
					field_string = field_prefix + "_" + parser.get_attribute_value(0)

				# Prepare to get data between <target> tags (or <source> for default)
				if node_type == XMLParser.NODE_ELEMENT and (node_name == "target" or (node_name == "source" and file == "default")):
					is_field_open = true

				# If inside <target>, set corresponding property
				if is_field_open and node_type == XMLParser.NODE_TEXT:
					new_resource.set(field_string, parser.get_node_data())

				# Close field when done with <target> (or default's <source>) data
				if node_type == XMLParser.NODE_ELEMENT_END and (node_name == "target" or (node_name == "source" and file == "default")):
					is_field_open = false
			ResourceSaver.save(new_resource, Constants.STRING_RESOURCE_PATH + file + "/" + file + ".tres")
		# Update file system
		EditorInterface.get_resource_filesystem().scan()
