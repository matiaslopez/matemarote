
package system.text.parser
    {
    
	/**
	 * The GenericParser static tool class.
	 */
    public class GenericParser
        {
        
        /**
         * @private
         */
        private var _source:String;
        
		/**
		 * The current character to parse.
		 */
        public var  ch:String;
        
		/**
		 * The current parser position in the string expression to parse.
		 */
        public var  pos:uint;
        
		/**
		 * Indicates the String source representation of the parser (read-only).
		 */
        public function get source():String
            {
            return _source;
            }
        
		/**
		 * Creates a new GenericParser instance.
		 * @param source The string expression to parse.
		 */
        public function GenericParser( source:String )
            {
            _source = source;
            pos    = 0;
            ch     = "";
            }
        
		/**
		 * Returns the current char in the parse process.
		 * @return the current char in the parse process.
		 */
        public function getChar():String
            {
            return source.charAt( pos );
            }        
        
		/**
		 * Returns the char in the source to parse at the specified position.
		 * @return the char in the source to parse at the specified position.
		 */
        public function getCharAt( pos:uint ):String
            {
            return source.charAt( pos );
            }

		/**
		 * Returns the next character in the source of this parser.
		 * @return the next character in the source of this parser.
		 */
        public function next():String
            {
            ch = getChar();
            pos++;
            return ch;
            }
                
		/**
		 * Indicates if the source parser has more char.
		 */
        public function hasMoreChar():Boolean
            {
            return pos <= (source.length-1);
            }
        
		/**
		 * Indicates if the specified character is an alpha (A-Z or a-z) character.
		 */
        public static function isAlpha( c:String ):Boolean
            {
            //debug( "isAlpha( "+c+" )" );
            return (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z"));
            }
        
		/**
		 * Indicates if the specified character is an ASCII character.
		 */
        public static function isASCII( c:String ):Boolean
            {
            //debug( "isASCII( "+c+" )" );
            return c.charCodeAt( 0 ) <= 255;
            }
        
		/**
		 * Indicates if the specified character is a digit.
		 */
        public static function isDigit( c:String ):Boolean
            {
            //debug( "isDigit( "+c+" )" );
            return ("0" <= c) && (c <= "9");
            }
        
		/**
		 * Indicates if the specified character is a hexadecimal digit.
		 */
        public static function isHexDigit( c:String ):Boolean
            {
            //debug( "isHexDigit( "+c+" )" );
            return isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f"));
            }
        
		/**
		 * Indicates if the specified character is a unicode character.
		 */
        public static function isUnicode( c:String ):Boolean
            {
            //debug( "isUnicode( "+c+" )" );
            return c.charCodeAt( 0 ) > 255;
            }
        
        }
    }

