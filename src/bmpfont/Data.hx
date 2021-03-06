package bmpfont;

import haxe.io.Bytes;

/**
	Represents the data and dimensions of a bitmap font item.
**/
typedef Font = {
	/**
		The letter of glyph the font is to represent.
	**/
	@:optional var letter:String;

	/**
		Width of the font in pixels.
	**/
	@:optional var width:Int;

	/**
		Height of the font in pixels.
	**/
	@:optional var height:Int;

	/**
		Row of the bitmap file the font is on.
	**/
	@:optional var row:Int;

	/**
		Bytes that represent the bitmap font glyph.
	**/
	@:optional var data:Bytes;
}

/**
	Defines the a lookup entry for a font.
**/
@:structInit class CharCodeEntry {
	/**
		ASCII Char Code to assign the font glyph.
	**/
	@:optional public var charCode:UInt;

	/**
		Width of the font glyph.
	**/
	@:optional public var width:UInt;

	/**
		Height of the font glyph.
	**/
	@:optional public var height:UInt;
}

/**
	Data used by the bmpfont.Reader and bmpfont.Writer.
**/
@:structInit class Data {
	/**
		Amount of bytes that the lookup table contains.
	**/
	@:optional public var sectionSize:UInt;

	/**
		Lookup table of font entries.
	**/
	@:optional public var lookupTable:Array<CharCodeEntry>;

	/**
		Byte data of each font in the same order as the lookupTable.
	**/
	@:optional public var fonts:Array<Bytes>;
}
