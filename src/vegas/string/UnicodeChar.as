/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.string
{
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    
    import vegas.core.types.Char;
    
    /**
     * <b>ECMA 262</b> Unicode IFormat-Control Characters tools.
     * <p>See <a href='http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf'>ECMAScript 262 specifications</a></p>
     * @example
     * <pre class="prettyprint">
     * UnicodeChar = vegas.string.UnicodeChar ;
     * 
     * trace("-----") ;
     * 
     * trace("Number of white space characters : " + UnicodeChar.WHITE_SPACE_CHARS.length) ;
     * 
     * trace("-----") ;
     * 
     * trace( "|" + UnicodeChar.TAB + "hello world" ) ;
     * 
     * trace("-----") ;
     * 
     * trace ("isWhiteSpace UnicodeChar.TAB : " + UnicodeChar.isWhiteSpace( UnicodeChar.TAB ) ) ;
     * 
     * trace("-----") ;
     * 
     * trace("UnicodeChar.toChar('0040') : " + UnicodeChar.toChar("0040")) ;
     * 
     * trace("UnicodeChar.toUnicode('220')  : " + UnicodeChar.toUnicode(220)) ;
     * trace("UnicodeChar.toChar(UnicodeChar.toUnicode('220')) : " + UnicodeChar.toChar(UnicodeChar.toUnicode(220))) ;
     * 
     * trace("-----") ;
     * 
     * u = new UnicodeChar() ;
     * trace( u.u5c0f() + u.u98fc() + u.u5f3e() + u.u0040() ) ; // 小飼弾@
     * </pre>
     * @author eKameleon
     */
    dynamic public class UnicodeChar extends Proxy
    {
        
       	/**
    	 * Creates a new <code class="prettyprint">UnicodeChar</code> instance.
	     * @example
	     * <pre class="prettyprint">
	     * var u:UnicodeChar = new UnicodeChar() ;
	     * trace( u.u0040() ) ; // @
	     * </pre>
	     */
	    public function UnicodeChar()
	    {
    		//	
    	}

    	/**
    	 * Array with all whitespace characters. NB : USP no implement (Any other Unicode "space separator")
    	 */
        public static const SPECIAL_CHARS:Array = [ "\u005C" , "\u0008" , "\u0027" , "\u0022" ] ;

	    /**
    	 * Back Slash utf8 representation (special char).
    	 */
       	public static const BACK_SLASH:String = SPECIAL_CHARS[0] ;	

	    /**
    	 * Back Space utf8 representation (special char).
    	 */
	    public static const BACK_SPACE:String = SPECIAL_CHARS[1] ;

	    /**
    	 * Simple Quote utf8 representation (special char).
    	 */
        public static const SIMPLE_QUOTE:String = SPECIAL_CHARS[2] ;

	    /**
    	 * Double Quote utf8 representation (special char).
    	 */
        public static const DOUBLE_QUOTE:String = SPECIAL_CHARS[3] ;
	
    	/**
    	 * Array with all whitespace characters. NB : USP no implement (Any other Unicode "space separator")
    	 */
        public static const WHITE_SPACE_CHARS:Array = [ "\u0009", "\u000B", "\u000C", "\u0020", "\u00A0" ] ; // hack only with ASDoc :(		
	
    	/**
    	 * Tab utf8 representation (whitespace).
    	 */
        public static const TAB:String = WHITE_SPACE_CHARS[0] ;

	    /**
    	 * Vertical Tab utf8 representation (whitespace).
    	 */
        public static const VT:String = WHITE_SPACE_CHARS[1] ;
        
    	/**
    	 * Form Feed utf8 representation (whitespace).
    	 */
        public static const FF:String = WHITE_SPACE_CHARS[2] ;
   
   	   /**
	    * Space utf8 representation (whitespace).
	    */
        public static const SP:String = WHITE_SPACE_CHARS[3] ;

    	/**
    	 * No-break space utf8 representation (whitespace).
    	 */
        public static const NBSP:String = WHITE_SPACE_CHARS[4] ;
        
    	/**
    	 * Array with all line terminators characters
    	 */
	    public static const LINE_TERMINATOR_CHARS:Array = [ "\u000A", "\u000D", "\u2028", "\u2029" ] ;  // hack only with ASDoc :(     
        
       	/**
	     * Line Feed utf8 representation (line terminators).
	     */
        public static const LF:String = LINE_TERMINATOR_CHARS[0] ;
        
    	/**
    	 * Carriage Return utf8 representation (line terminators).
    	 */
        public static const CR:String = LINE_TERMINATOR_CHARS[1] ;

    	/**
    	 * Line Separator utf8 representation (line terminators).
	     */        
        public static const LS:String = LINE_TERMINATOR_CHARS[2] ;	

    	/**
    	 * Paragraph Separator utf8 representation (line terminators).
	     */   
        public static const PS:String = LINE_TERMINATOR_CHARS[3] ;	

        /**
         * Overrides the behavior of an object property that can be called as a function. 
         * When a method of the object is invoked, this method is called. 
         * While some objects can be called as functions, some object properties can also be called as functions. 
         */
        flash_proxy override function callProperty( methodName:*  , ...rest:Array ):* 
        {
            if ( String(methodName) != null )
            {
                return String.fromCharCode( String(methodName).replace( /^u/ , "0x" ) ) ;
            }
            else
            {
                return "" ;
            } 
        }

    	/**
    	 * Returns <code class="prettyprint">true</code> of the specified character is a whitespace.
    	 * @return <code class="prettyprint">true</code> of the specified character is a whitespace.
    	 */
	    public static function isWhiteSpace( char:String ):Boolean 
	    {
            var c:Char = new Char(char) ;
		    return (WHITE_SPACE_CHARS.indexOf(c) != -1) ;
        }

    	/**
    	 * Returns <code class="prettyprint">true</code> of the specified character is a line terminator.
    	 * @return <code class="prettyprint">true</code> of the specified character is a line terminator.
    	 */
        public static function isLineTerminators( char:String ):Boolean 
        {
		    var c:Char = new Char(char) ;
        	return (LINE_TERMINATOR_CHARS.indexOf(c) != -1) ;
        }

    	/**
    	 * Converts a unicode representation and returns this char's string.
    	 * @return The char of the unicode representation.
    	 */
	    public static function toChar( unicode:String ):Char
	    {
            return new Char( toCharString( unicode ) ) ;
        }
        
    	/**
    	 * Converts a unicode representation and returns this char's string.
    	 * @return The char of the unicode representation.
    	 */
	    public static function toCharString( unicode:String ):String
	    {
            return String.fromCharCode( parseInt( unicode , 16) ) ;
        }

	    /**
    	 * Converts an unicode number value and returns this string representation.
	     * @return The string representation of a unicode number.
    	 */
        public static function toUnicode(n:Number):String 
        {
    	    var hex:String = n.toString(16) ;
        	while( hex.length < 4 ) hex = "0" + hex ;
        	return hex ;
        }
    
    }

}