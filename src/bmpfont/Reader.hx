package bmpfont;

import bmpfont.Data.CharCodeEntry;
import haxe.io.Bytes;
import sys.io.File;
import bmpfont.Data.Font;
import haxe.Exception;

class Reader {
	public function new() {}

	static final FILE_FORMAT:String = ".fnt";

	/**
		Reads the font file data and converts it to an array of Font.
		@param fileName File name to read font data.
		@return Array<Font>
	**/
	public function read(fileName:String):Array<Font> {
		if (fileName.substring(fileName.indexOf(FILE_FORMAT)) != FILE_FORMAT)
			throw new Exception('The filename is not the correct file format.');

		var fonts:Array<Font> = new Array<Font>();
		var fontData:Bytes = File.getBytes(fileName);
		var sectionSize:Int = fontData.get(0);
		var lookupTable:Array<CharCodeEntry> = convertToLookupTable(sectionSize, fontData);
		var fontData:Array<Bytes> = extractFontData(sectionSize, lookupTable, fontData);

		for (i in 0...sectionSize) {
			var entry:CharCodeEntry = lookupTable[i];
			var bytes:Bytes = fontData[i];

			fonts.push({
				letter: String.fromCharCode(entry.charCode),
				width: entry.width,
				height: entry.height,
				data: bytes
			});
		}

		return fonts;
	}

	function convertToLookupTable(sectionSize:Int, data:Bytes) {
		var entry:CharCodeEntry = {charCode: 0, width: 0, height: 0};
		var elements:Int = Std.int(sectionSize / Reflect.fields(entry).length);
		var sectionBytes:Bytes = Bytes.alloc(sectionSize);
		sectionBytes.blit(0, data, 1, sectionSize);

		var lookupTable:Array<CharCodeEntry> = new Array<CharCodeEntry>();
		var index:Int = 0;
		for (i in 0...elements) {
			entry = {
				charCode: sectionBytes.get(index),
				width: sectionBytes.get(index + 1),
				height: sectionBytes.get(index + 2)
			};
			lookupTable.push(entry);
			index += Reflect.fields(entry).length;
		}

		return lookupTable;
	};

	function extractFontData(sectionSize:Int, lookupTable:Array<CharCodeEntry>, data:Bytes) {
		var bytesArray:Array<Bytes> = new Array<Bytes>();

		var index = sectionSize + 1; // Move past the section size byte plus the size of the section to the actual data.
		for (entry in lookupTable) {
			var dataSize = entry.width * entry.height;
			var bytes = Bytes.alloc(dataSize);
			bytes.blit(0, data, index, dataSize);
			index += dataSize;
			bytesArray.push(bytes);
		}

		return bytesArray;
	};
}
