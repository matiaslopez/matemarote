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
	 * The Base8 algorithm encoding tool class.
	 * @author eKameleon
	 */
	public class Base8 
	{
		
		/**
		 * Encodes a base8 string.
	 	 * <p><b>Example :</b></p>
	 	 * <pre class="prettyprint">
	 	 * import calista.util.Base8 ;
	 	 * var source:String = "hello world with a base 8 algorithm" ;
	 	 * 
	 	 * var encode:String = Base8.encode( source ) ;
	 	 * trace("encode : " + encode) ;
	 	 * 
	 	 * // encode : 68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d
	 	 * 
	 	 * </pre>
		 */
		public static function encode( str:String ):String
		{
			str = new String(str) ; // optimize
			var size:Number   = str.length ;
			var result:String = "" ;
			for (var i:Number = 0; i<size ; i++) 
			{
				result += str.charCodeAt(i).toString(16);
			}
			return result;
		}
		
		/**
		 * Decodes a base8 string.
	 	 * <p><b>Example :</b></p>
 	 	 * <pre class="prettyprint">
	 	 * import calista.util.Base8 ;
	 	 * 
 	 	 * var source:String = "hello world with a base 8 algorithm" ;
	 	 * 
	 	 * var encode:String = Base8.encode( source ) ;
	 	 * trace("encode : " + encode) ;
	 	 * 
	 	 * var decode:String = Base8.decode( encode ) ;
 	 	 * trace("decode : " + decode) ;
 	 	 * 
	 	 * // encode : 68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d
	 	 * // decode : hello world with a base 8 algorithm
	 	 * 
	 	 * </pre>
		 */
		public static function decode( str:String ):String
		{
			str = new String(str) ; // optimize
			var result:String = "" ;
			var size:Number   = str.length ;
			for ( var i:Number = 0 ; i<size ;  i+=2 ) 
			{
				result += String.fromCharCode( parseInt(str.substr(i, 2), 16));
			}
			return result;
		}
		
	}
}
