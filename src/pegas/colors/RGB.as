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

    /**
     * The RGB class encapsulates an rgb color.
     * <pre class="prettyprint">
     * import pegas.colors.RGB ;
     * 
     * trace("---- black") ;
     * 
     * var black:RGB = new RGB() ;
     * 
     * trace( "black : " + black ) ; // [RGB r:0 g:0 b:0 hex:0x000000]
     * trace( "black.toHexString('#') : " + black.toHexString("#") ) ; // #000000
     * 
     * black.difference() ;
     * trace( "black difference : " + black ) ; // [RGB r:255 g:255 b:255 hex:0xFFFFFF]
     * 
     * trace("---- red") ;
     * 
     * var red:RGB = new RGB(255, 0, 0) ;
     * trace( "red : " + red ) ; // [RGB r:255 g:0 b:0 hex:0xFF0000]
     * trace( "red.toHexString('#') : " + red.toHexString("#") ) ; // #FF0000
     * 
     * red.difference() ; 
     * trace( "red difference : " + red ) ; // [RGB r:0 g:255 b:255 hex:0x00FFFF]
     * 
     * trace("---- blue") ;
     * 
     * var blue:RGB = new RGB(92, 160, 205) ;
     * trace( "blue : " + blue ) ; // [RGB r:92 g:160 b:205 hex:0x5CA0CD]
     * trace( "blue.toHexString('#') : " + blue.toHexString("#") ) ; // #5CA0CD
     * 
     * blue.difference() ;
     * trace( "blue difference       : " + blue ) ; // [RGB r:163 g:95 b:50 hex:0xA35F32]
     * 
     * blue.fromNumber( 0x23516D ) ;
     * trace( "blue                  : " + blue ) ; // [RGB r:35 g:81 b:109 hex:0x23516D]
     * trace( "blue.red              : " + blue.red   ) ; // 35
     * trace( "blue.green            : " + blue.green ) ; // 81
     * trace( "blue.blue             : " + blue.blue  ) ; // 109
     * </pre>
 	 */
	public class RGB 
    {

        /**
		 * Creates a new RGB instance.
         * @param r The red component, an interger value between 0 and 255 (default 0).
         * @param g The green component, an interger value between 0 and 255 (default 0).
         * @param b The blue component, an interger value between 0 and 255 (default 0). 
		 */
		public function RGB( r:uint = 0 , g:uint = 0 , b:uint = 0 )
		{
            red   = r ;
            green = g ;
            blue  = b ;
		}
                
        /**
         * The blue component (interger value between 0 and 255)
         */
        public function get blue():uint
        {
            return _blue ;
        }
        
        /**
         * @private
         */
        public function set blue( value:uint ):void
        {
            _blue = Math.min( value, maximum ) as uint ;
        } 
        
        /**
         * The green component (interger value between 0 and 255)
         */        
        public function get green():uint
        {
            return _green ;
        }
        
        /**
         * @private
         */
        public function set green( value:uint ):void
        {
            _green = Math.min( value, maximum ) as uint ;
        }        

        /**
         * The red component (interger value between 0 and 255)
         */
        public function get red():uint
        {
            return _red ;
        }

        /**
         * @private
         */
        public function set red( value:uint ):void
        {
            _red = Math.min( value, maximum ) as uint ;
        }
                
        /**
         * Transforms the red, green and blue components of the color in this difference color representation.
         */
        public function difference():void
        {
            _red   = maximum - _red   ;
            _green = maximum - _green ;
            _blue  = maximum - _blue  ;
        }
        
        /**
         * Sets the red, green and blue component with the specified number value.
         */
        public function fromNumber( value:Number ):void 
        {
            var gb:int ;
            red   = value >> 16 ;
            gb    = value ^ red << 16 ;
            green = gb >> 8 ;
            blue  = gb^green << 8 ;
        }        
        
	    /**
	     * Interpolate the color and returns a new RGB object.
	     * @param c The RGB reference used to interpolate the current RGB object.
	     * @param level The level to interpolate the color.
	     * @return The interpolate RGB reference of the current color.
	     */
	    public function interpolate( c:RGB , level:uint ):RGB
	    {
	    	return new RGB
	    	(
                _red   + ( c.red   - _red   ) * level ,
                _green + ( c.green - _green ) * level ,
                _blue  + ( c.blue  - _blue  ) * level 
	    	) ;
	    }
        	    
        /**
         * Returns the object representation of the color number passed in argument. 
         * This object contains the properties r, g and b for the red, the green and the blue component of the color.
         * @return the object representation of the color number passed in argument.
         */
        public static function numberToRGB( value:Number ):RGB 
        {
            var r:int, g:int, b:int, gb:int ;
            r  = value >> 16 ;
            gb = value ^ r << 16 ;
            g  = gb >> 8 ;
            b  = gb^g << 8 ;
            return new RGB( r , g , b ) ;
        }
	    
		/**
		 * Converts the red, green, blue passed-in arguments in a HTML number color (base 10).
		 */
		public static function rgbToNumber( r:Number, g:Number, b:Number ):Number  
		{	
			return ( r << 16 ) | ( g << 8 ) | b ;
		}
		
        /**
         * Sets all tree components of a color. 
         */
        public function set( ...args:Array ):void
        {
            red   = uint(args[0]) ;
            green = uint(args[1]) ;
            blue  = uint(args[2]) ;
        }		
                
        /**
         * Returns the full String representation of the color.
         * @return the full String representation of the color.
         */
        public function toHexString( prefix:String = "0x" ):String
        {
            return prefix + toHex( red ) + toHex( green ) + toHex( blue );
        }
                
        /**
         * Converts an object to an equivalent Object value.
         * @return the Object representation of the instance.
         */
        public function toObject():Object 
        {
            return { red:red , green:green , blue:blue } ;  
        }        
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public function toString( ...args:Array ):String
        {
            return "[RGB r:" + _red + " g:" + _green + " b:" + _blue + " hex:" + toHexString() + "]";
        }         
        
        /**
         * Returns the real value of the object.
         * @return the real value of the object.
         */
        public function valueOf():uint
        {
            return (red << 16) | (green << 8) | blue;
        }
        
        /**
         * The maximum value specified with a color component.
         */
        protected const maximum:uint = 0xFF ;        
          
        /**
         * Basic method use to convert the specified uint value in a hexadecimal String representation.
         * @return The String representation of the specified color.
         */
        protected function toHex( value:uint ):String
        {
            var hex:String = value.toString( 16 ) ;
            return (( hex.length % 2 ) == 0 ? hex : "0" + hex).toUpperCase() ;
        }        
                  
        /**
         * @private
         */        
        protected var _blue:uint ;        
        
        /**
         * @private
         */        
        protected var _green:uint ;     
                
        /**
         * @private
         */
        protected var _red:uint ;
			
	}

}
