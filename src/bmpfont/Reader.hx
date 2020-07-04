package bmpfont;

import haxe.Exception;

class Reader {
	public function new() {}

	static final FILE_FORMAT:String = ".font";

	public function read(fileName:String) {
		trace('Extension of file: ${fileName.indexOf(FILE_FORMAT)}');
		if (fileName.substring(fileName.indexOf(FILE_FORMAT)) != FILE_FORMAT)
            throw new Exception('The filename is not the correct file format.');
        
        		// var row:Int = 0;

			// trace(data.getData());
			// for (y in 0...symbol.height) {
			// 	row = y;
			// 	for (x in 0...symbol.width) {
			// 		var ploc = x + (y * symbol.width);
			// 		var a = data.get(ploc);

			// 		trace('==> (x: $x, y: $y)\tpixel: $a');
			// 	}
			// 	trace('row: $row');
			// }
	}
}
