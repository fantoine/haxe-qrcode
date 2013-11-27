/**
 * ...
 * @author Fabien Antoine
 * @copy Fabien Antoine (fantoine@intuitiv.fr)
 */

package demo;

import sys.io.File;
import qrcode.QRCode;
import qrcode.QREncode;

import qrcode.ErrorCorrection;

class Demo {
	public static function main() {
		var input	= Sys.stdin();
		var output	= Sys.stdout();
		while(true) {
			// Get error correction
			var error = null;
			do {
				output.writeString("Error correction (L|M|Q|H):\n");
				var code = input.readLine();
				error = switch(code.toLowerCase()) {
					case "l":	EC_L;
					case "m":	EC_M;
					case "q":	EC_Q;
					case "h":	EC_H;
					default:	null;
				}
			} while(error == null);
			
			// Get message
			output.writeString("Message:\n");
			var msg = input.readLine();
			
			// Create qrcode
			var frame 	= QRCode.text(msg, error, 3, 4);
			
			// Prepare characters
			var black	= "  ";
			var white	= String.fromCharCode(219) + String.fromCharCode(219);
			
			// Display frame
			output.writeString("\n");
			line(frame[0].length, white);
			for(line in frame) {
				output.writeString(white);
				for(col in line) {
					if(col == 0) {
						output.writeString(white);
					} else {
						output.writeString(black);
					}
				}
				output.writeString(white);
				output.writeString("\n");
			}
			line(frame[0].length, white);
			output.writeString("\n");
		}
	}
	
	static function line(length : Int, char : String) {
		for(i in 0...(length + 2)) {
			Sys.stdout().writeString(char);
		}
		Sys.stdout().writeString("\n");
	}
}