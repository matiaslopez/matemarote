/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is CalistA Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package calista.util 
{

	/**
	 * The Base64 algorithm encoding tool class.
	 * @author eKameleon
	 */
	public class Base64 
	{
		
		/**
		 * Encodes a base64 string.
	 	 * <p><b>Example :</b></p>
	 	 * <pre class="prettyprint">
	 	 * import calista.util.Base64 ;
	 	 * var source:String = "hello world with a base 64 algorithm" ;
	 	 * 
	 	 * var encode:String = Base64.encode( source ) ;
	 	 * trace("encode : " + encode) ;
	 	 * 
	 	 * // encode : aGVsbG8gd29ybGQgd2l0aCBhIGJhc2UgNjQgYWxnb3JpdGht
	 	 * </pre>
		 */
		public static function encode( str:String ):String
		{
			str = new String(str) ; // optimize
			var size:Number   = str.length ;
			var i:Number      = 0 ;
			var output:String = "" ;
			var chr1:Number, chr2:Number, chr3:Number;
			var enc1:Number, enc2:Number, enc3:Number, enc4:Number;
			while (i < size) 
			{
				chr1 = str.charCodeAt(i++) ;
				chr2 = str.charCodeAt(i++) ;
				chr3 = str.charCodeAt(i++) ;
				enc1 = chr1 >> 2;
				enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
				enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
				enc4 = chr3 & 63;
				if(isNaN(chr2)) 
				{
					enc3 = enc4 = 64;
				}	
				else if(isNaN(chr3)) 
				{
					enc4 = 64;
				}
				output += base64chars.charAt(enc1) + base64chars.charAt(enc2) ;
				output += base64chars.charAt(enc3) + base64chars.charAt(enc4) ;
			}
			return output;
		}
		
		/**
		 * Decodes a base64 string.
	 	 * <p><b>Example :</b></p>
	 	 * <pre class="prettyprint">
	 	 * import calista.util.Base64 ;
	 	 * 
	 	 * var source:String = "hello world with a base 64 algorithm" ;
	 	 * 
	 	 * var encode:String = Base64.encode( source ) ;
 	 	 * trace("encode : " + encode) ;
	 	 * 
	 	 * var decode:String = Base64.decode( encode ) ;
	 	 * trace("decode : " + decode) ;
	 	 * 
	 	 * // encode : aGVsbG8gd29ybGQgd2l0aCBhIGJhc2UgNjQgYWxnb3JpdGht
	 	 * // decode : hello world with a base 64 algorithm
	 	 * </pre>
		 */
		public static function decode( str:String ):String
		{
			str = new String(str) ; // optimize
			var size:Number   = str.length ;
			var i:Number      = 0;
			var output:String = "" ;
			var chr1:Number, chr2:Number, chr3:Number;
			var enc1:Number, enc2:Number, enc3:Number, enc4:Number;
			while (i < size) 
			{
				enc1 = base64chars.indexOf(str.charAt(i++)) ;
				enc2 = base64chars.indexOf(str.charAt(i++)) ;
				enc3 = base64chars.indexOf(str.charAt(i++)) ;
				enc4 = base64chars.indexOf(str.charAt(i++)) ;
				chr1 = (enc1 << 2) | (enc2 >> 4);
				chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
				chr3 = ((enc3 & 3) << 6) | enc4 ;
				output += String.fromCharCode(chr1);
				if (enc3 != 64) 
				{
					output = output + String.fromCharCode(chr2);
				}
				if (enc4 != 64) 
				{
					output = output + String.fromCharCode(chr3);
				}
			}
			return output;
		}
		
		/**
		 * Internal base 64 characters.
		 */
		private static var base64chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
			
	}
}
