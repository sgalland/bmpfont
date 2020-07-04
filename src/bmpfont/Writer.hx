package bmpfont;

import haxe.Exception;
import sys.io.File;
import bmpfont.Data.Font;

/**
	Writes the bitmap font data to a file.

	@throws
**/
class Writer {
	public function new() {}

	/**
		Writes the binary data to a disk file.
		@param outputFileName Name of the file to write.
		@param fonts Array of Font to write to disk.
	**/
	public function write(outputFileName:String, fonts:Array<Font>) {
		var data:Data = {};

		data.lookupTable = fonts.map(function(f:Font) {
			return {charCode: f.letter.charCodeAt(0), width: f.width, height: f.height};
		});

		data.sectionSize = data.lookupTable.length * Reflect.fields(data.lookupTable[0]).length;

		data.fonts = fonts.map(function(f:Font) {
			return f.data;
		});

		var handle = File.write(outputFileName, true);
		if (handle == null)
			throw new Exception('$outputFileName could not be created for a write operation.');

		handle.writeByte(data.sectionSize);

		for (entry in data.lookupTable) {
			handle.writeByte(entry.charCode);
			handle.writeByte(entry.width);
			handle.writeByte(entry.height);
		}

		for (font in data.fonts) {
			handle.write(font);
		}

		handle.close();
	}
}
