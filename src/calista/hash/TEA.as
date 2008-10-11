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
package calista.hash 
{

	/**
	 * Wheeler & Needham’s Tiny Encryption Algorithm is a simple but powerful encryption algorithm (based on a ‘Feistel cipher’).
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import calista.hash.TEA ;
	 * 
	 * var source:String = "hello world is secret" ;
	 * var password:String = "calista" ;
	 * 
	 * var encrypt:String = TEA.encrypt( source , password ) ;
	 * trace("encrypt : " + encrypt) ;
	 * 
	 * var decrypt:String = TEA.decrypt(encrypt , password) ;
	 * trace("decrypt : " + decrypt) ;
	 * </pre>
	 * <p>Original Javascript implementation :</p>
	 * Chris Veness, Movable Type Ltd: www.movable-type.co.uk
	 * Algorithm: David Wheeler & Roger Needham, Cambridge University Computer Lab
	 * See http://www.movable-type.co.uk/scripts/TEAblock.html
	 * @author eKameleon
	 */
	public class TEA 
	{
		
		/**
		 * Uses corrected Block TEA to encrypt a string value using key.
	 	 * <pre class="prettyprint">
	 	 * import calista.hash.TEA ;
	 	 * 
	 	 * var source:String   = "hello world is secret" ;
	 	 * var password:String = "calista" ;
	 	 * 
	 	 * var encrypt:String = TEA.encrypt( source , password ) ;
	 	 * trace("encrypt : " + encrypt) ;
	 	 * // encrypt : 021fd8983c171657403494ffe971fdbea3f48acea8418864
	 	 * </pre>
		 * @return encrypted text as string
		 */
		public static function encrypt( src:String, key:String ):String
		{
			var v:Array = charsToLongs(strToChars(src)) ;
			var k:Array = charsToLongs(strToChars(key)) ;
			var n:Number = v.length ;
			if (n == 0) 
			{
				return "" ;
			}
			if (n == 1) 
			{
				v[n++] = 0;
			}
			var z:Number = v[n-1], y:Number = v[0], delta:Number = 0x9E3779B9 ;
			var mx:Number ;
			var e:Number  ;
			var q:Number = Math.floor(6+52/n) ;
			var sum:Number = 0 ;
			while (q-- > 0) 
			{
				sum += delta;
				e = sum>>>2 & 3;
				for (var p:Number = 0; p<n-1; p++) 
				{
					y = v[p+1];
					mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
					z = v[p] += mx;
				}
				y = v[0];
				mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z);
				z = v[n-1] += mx;
			}
			return charsToHex(longsToChars(v));
		}
		
		/**
	 	 * Use Corrected Block TEA to decrypt ciphertext using password.
		 * <p><b>Example :</b></p>
	 	 * <pre class="prettyprint">
	 	 * import calista.hash.TEA ;
	 	 * 
		 * var source:String = "hello world is secret" ;
	 	 * var password:String = "calista" ;
	 	 * 
	 	 * var encrypt:String = TEA.encrypt( source , password ) ;
	 	 * trace("encrypt : " + encrypt) ;
	 	 * 
	 	 * var decrypt:String = TEA.decrypt(encrypt , password) ;
	 	 * trace("decrypt : " + decrypt) ;
	 	 * 
	 	 * // encrypt : 021fd8983c171657403494ffe971fdbea3f48acea8418864
	 	 * // decrypt : hello world is secret
	 	 * </pre>
	 	 */
		public static function decrypt( src:String, key:String ):String
		{
			var v:Array = charsToLongs(hexToChars(src)) ;
			var k:Array = charsToLongs(strToChars(key)) ;
			var n:Number = v.length ;
			if (n == 0) 
			{
				return "" ;
			}
			var z:Number     = v[n-1] ;
			var y:Number     = v[0]   ;
			var delta:Number = 0x9E3779B9 ;
			var mx:Number ;
			var e:Number ;
			var q:Number = Math.floor(6 + 52/n) ;
			var sum:Number = q*delta ;
			while (sum != 0) 
			{
				e = sum>>>2 & 3;
				for(var p:Number = n-1; p > 0; p--)
				{
					z  = v[p-1] ;
					mx = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z) ;
					y  = v[p] -= mx ;
				}
				z         = v[n-1] ;
				mx        = (z>>>5^y<<2)+(y>>>3^z<<4)^(sum^y)+(k[p&3^e]^z) ;
				y = v[0] -= mx ;
				sum      -= delta ;
			}
			return charsToStr(longsToChars(v));
    	}
		
		/**
		 * Converts an array of chars to array of longs, each containing 4 chars.
		 * @private
		 */
		private static function charsToLongs(chars:Array):Array 
		{  
			var size:Number = Math.ceil( chars.length/4 ) ;
			var ar:Array    = new Array(size);
			for (var i:Number = 0 ; i<size ; i++) 
			{
				ar[i] = chars[i*4] + (chars[i*4+1]<<8) + (chars[i*4+2]<<16) + (chars[i*4+3]<<24);
			}
			return ar ; 
		}
		
		/**
		 * Converts the char passed-in value in string hexadecimal string representation.
		 * @private
		 */
		private static function charsToHex(chars:Array):String 
		{
			var result:String = new String("") ;
			var hex:Array   = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"] ;
			var size:Number = chars.length ;
			for (var i:Number = 0; i<size ; i++) 
			{
				result += hex[chars[i] >> 4] + hex[chars[i] & 0xf] ;
			}
			return result;
		}
		
		/**
	 	 * Converts an array of chars in a string representation.
		 * @return a string representation of the passed-in array of chars.
		 * @private
		 */
		private static function charsToStr(chars:Array):String 
		{
			var result:String = new String("") ;
			var size:Number   = chars.length ;
			for ( var i:Number = 0 ; i<size ; i++ ) 
			{
				result += String.fromCharCode( chars[i] ) ;
			}
			return result ;
		}
			
		/**
	 	 * Converts the hexadecimal string passed-in argument in array of chars.
	 	 * @private
		 */
		private static function hexToChars(hex:String):Array 
		{
			var ar:Array = [] ;
			for (var i:Number = (hex.substr(0, 2) == "0x") ? 2 : 0; i< hex.length ; i+=2) 
			{
				ar.push( parseInt( hex.substr(i, 2), 16) ) ;
			}
			return ar ;
		}
	
		/**
		 * Converts an array of longs back to an array of chars.
		 * @private
		 */
		private static function longsToChars( longs:Array ):Array 
		{
			var ar:Array = new Array();
			var size:Number = longs.length ;
			for ( var i:Number = 0 ; i<size ; i++ ) 
			{
				ar.push(longs[i] & 0xFF, longs[i]>>>8 & 0xFF, longs[i]>>>16 & 0xFF, longs[i]>>>24 & 0xFF) ;
			}
			return ar;
		}
	
		/**
		 * @private
		 */
		private static function strToChars(str:String):Array 
		{
			var codes:Array = new Array();
			for (var i:Number = 0; i<str.length; i++) 
			{
				codes.push(str.charCodeAt(i));
			}
			return codes;
		}		
		
	}
	
}
