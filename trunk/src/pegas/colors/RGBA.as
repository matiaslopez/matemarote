/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.colors 
{
    import system.numeric.Mathematics;                    

    /**
     * The RGBA class encapsulates an rgba color.
     * <pre class="prettyprint">
     * import pegas.colors.RGBA ;
     * 
     * trace("---- black") ;
     * 
     * var black:RGBA = new RGBA() ;
     * 
     * trace( "black                  : " + black ) ; // [RGBA r:0 g:0 b:0 a:1 hex:0xFF000000]
     * trace( "black.toHexString('#') : " + black.toHexString("#") ) ; // #FF000000
     * trace( "black.alpha            : " + black.alpha   ) ; // 1
     * trace( "black.red              : " + black.red     ) ; // 0
     * trace( "black.green            : " + black.green   ) ; // 0
     * trace( "black.blue             : " + black.blue    ) ; // 0
     * trace( "black.percent          : " + black.percent ) ; // 100
     * trace( "black.offset           : " + black.offset  ) ; // 255
     * 
     * trace("---- red") ;
     * 
     * var red:RGBA = new RGBA(255 , 0 , 0 , 0.5 ) ;
     * 
     * trace( "red         : " + red ) ; // [RGBA r:255 g:0 b:0 a:0.5 hex:0x7FFF0000]
     * trace( "red.alpha   : " + red.alpha   ) ; // 0.5
     * trace( "red.red     : " + red.red     ) ; // 255
     * trace( "red.green   : " + red.green   ) ; // 0
     * trace( "red.blue    : " + red.blue    ) ; // 0
     * trace( "red.percent : " + red.percent ) ; // 50
     * trace( "red.offset  : " + red.offset  ) ; // 127.5
     * 
     * trace("---- blue") ;
     * 
     * var blue:RGBA = new RGBA(92, 160, 205, 0.4) ;
     * 
     * trace( "blue         : " + blue ) ; // [RGBA r:92 g:160 b:205 a:0.4 hex:0x665CA0CD]
     * trace( "blue.alpha   : " + blue.alpha   ) ; // 0.4
     * trace( "blue.red     : " + blue.red     ) ; // 92
     * trace( "blue.green   : " + blue.green   ) ; // 160
     * trace( "blue.blue    : " + blue.blue    ) ; // 205
     * trace( "blue.percent : " + blue.percent ) ; // 40
     * trace( "blue.offset  : " + blue.offset  ) ; // 102
     * 
     * blue.offset = 255 ;
     * trace( "blue : " + blue ) ; // [RGBA r:92 g:160 b:205 a:1 hex:0xFF5CA0CD]
     * 
     * blue.percent = 50 ;
     * trace( "blue : " + blue ) ; // [RGBA r:92 g:160 b:205 a:0.5 hex:0x7F5CA0CD]
     * 
     * blue.fromNumber( 0x23516D ) ;
     * trace( "blue : " + blue ) ; // [RGBA r:35 g:81 b:109 a:0 hex:0x0023516D]
     * </pre>
 	 */
	public class RGBA extends RGB 
	{
		
		/**
		 * Creates a new RGBA instance.
		 * @param r The red component, an interger value between 0 and 255 (default 0).
		 * @param g The green component, an interger value between 0 and 255 (default 0).
		 * @param b The blue component, an interger value between 0 and 255 (default 0).
		 * @param a The alpha component, an interger value between 0 and 1 (default 1).
		 */
		public function RGBA( r:uint = 0 , g:uint = 0 , b:uint = 0 , a:Number = 1 )
		{
			super( r , g , b ) ;
			alpha = a ;
		}
		
		/**
		 * The alpha component (integer value between 0 and 1)
		 */
        public function get alpha():Number
        {
            return _alpha ;
        }
        
        /**
         * @private
         */
        public function set alpha( value:Number ):void
        {
            _alpha = Mathematics.clamp( isNaN(value) ? 0 : value , 0, 1 ) ;
        }
        
        /**
         * Defines the alpha component value with an offset representation (number value between 0 and 255)
         */
        public function get offset():Number
        {
            return _alpha * maximum ;
        }
        
        /**
         * @private
         */
        public function set offset( value:Number ):void
        {
            _alpha = Mathematics.clamp( isNaN(value) ? 0 : value , 0, maximum ) / maximum ;
        }          
        
        /**
         * Defines the alpha component value with a percent representation (number value between 0 and 100)
         */
        public function get percent():Number
        {
            return _alpha * 100 ;
        }
        
        /**
         * @private
         */
        public function set percent( value:Number ):void
        {
            alpha = Mathematics.clamp( isNaN(value) ? 0 : value , 0, 100 ) / 100 ;
        }        
        
        /**
         * Sets the red, green and blue component with the specified number value.
         */
        public override function fromNumber( value:Number ):void 
        {
        	alpha = value >> 24 ;
            super.fromNumber( value ) ;
        }           
        
		/**
		 * Converts the red, green, blue passed-in arguments in a HTML number color (base 10).
		 */
		public static function rgbaToNumber( r:uint=0, g:uint=0, b:uint=0 , a:uint=1 ):Number  
		{	
			return (a << 24) | ( r << 16 ) | ( g << 8 ) | b ;
		}
		
        /**
         * Sets all foor components of a color. 
         */
        public override function set( ...args:Array ):void
        {
            super.set( args[0] , args[1], args[2] ) ;
            alpha = isNaN(args[3]) ? 1 : args[3] ;
        }   		
                
        /**
         * Returns the full String representation of the color.
         * @return the full String representation of the color.
         */
        public override function toHexString( prefix:String = "0x" ):String
        {
            return prefix + toHex( offset ) + toHex( red ) + toHex( green ) + toHex( blue );
        }
                
        /**
         * Converts an object to an equivalent Object value.
         * @return the Object representation of the instance.
         */
        public override function toObject():Object 
        {
            return { red:_red , green:_green , blue:_blue , alpha:_alpha } ;  
        }        
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public override function toString( ...args:Array ):String
        {
            return "[RGBA r:" + _red + " g:" + _green + " b:" + _blue + " a:" + _alpha + " hex:" + toHexString() + "]";
        }         
        
        /**
         * Returns the real value of the object.
         * @return the real value of the object.
         */
        public override function valueOf():uint
        {
            return ( _alpha << 24 ) | ( _red << 16 ) | ( _green << 8 ) | _blue ;
        }
                
        /**
         * @private
         */        
        protected var _alpha:Number ;
			
	}

}
