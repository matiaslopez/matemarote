/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  - Marc Alcaraz <ekameleon@gmail.com>
*/

package system.serializers.eden
    {
    import system.Reflection;
    import system.Strings;
    import system.console;    
    import system.text.parser.GenericParser;
    

    /* note:
       how to debug eden (part 1)
       
       by default eden
       use namespace release;
       
       to have all the traces displayed in the console
       use namespace debug;
       
       with that you will also have the logs displaying in the console
       even if config.showLogs = false
    */
    //import system.serializers.eden.debug;
    //import system.serializers.eden.release;
    
    /* note:
       how to debug eden (part 2)
       
       If you want to monitor more precisely some code snapshot
       you can use the VirtualMachine beginTrace/endTrace functions
       (which reuse the flash.trace.Trace function calls)
       
       if you uncomment those methods in doesExistInGlobalScope method
       you will see for ex:
        ------------------------------------------------------
          * system.serializers.eden::ECMAScript/isDigitNumber("0")
          * String/split("",4294967295)
          * String$/_split()
          * Array/get length()
          * system.serializers.eden::GenericParser$/isDigit("0")
          * Array/get length()
          * global/parseInt()
        ------------------------------------------------------
       
       avoid to trace too much or you could crash the Flash Player
    */
    //import system.diagnostics.VirtualMachine;
    
    
	/**
	 * The ECMAScript parser class.
	 */
    public class ECMAScript
        {
        /* note:
           Always commit changes with the release namespace
        */
        use namespace release;
        
        /**
         * @private
         */
        private var _source:String;
        
        private var _ORC:String            = "\uFFFC";
        private var _singleValue:Boolean   = true;
        private var _inAssignement:Boolean = false;
        private var _inConstructor:Boolean = false;
        // private var _inFunction:Boolean    = false;
        
        /* note:
           a pool contains string indexes to object references
           (yeah this could be surely optimized with a Dictionnary)
           ex:
           (code)
           _globalPool[ "system.serializers.eden.config" ] = system.serializers.eden.config;
           _localPool[ "x.y.z" ] = localScope.x.y.z;
           (end)
           
        */
        private static var _globalPool:Array = [];
        private var _localPool:Array = [];

		/**
		 * The comments string representation.
		 */
        public static var comments:String = "";
        
		/**
		 * The current character to parse.
		 */
        public var  ch:String;
        
		/**
		 * The current parser position in the string expression to parse.
		 */
        public var  pos:uint;
        
		/**
		 * The local scope reference.
		 */
        public var localscope:*;
        
        /**
        * Hook to catch the global trace function call
        */
        protected function trace( message:String ):void
        {
            console.writeLine( message );
        }
        
        debug function traceGlobalPool():void
            {
            trace( "---------------------" );
            trace( "global pool:" );
            for( var member:String in _globalPool )
                {
                trace( member + " = " + _globalPool[member] );
                }
            trace( "---------------------" );
            }
        
        debug function tracePool():void
            {
            trace( "---------------------" );
            trace( "local pool:" );
            for( var member:String in _localPool )
                {
                trace( member );
                }
            trace( "---------------------" );
            }
        
        debug function debug( message:String ):void
            {
            trace( message );
            }
        
        release function traceGlobalPool():void
            {
            //do nothing;
            }
        
        release function tracePool():void
            {
            //do nothing
            }
        
        release function debug( message:String ):void
            {
            //do nothing
            }
        
		/**
		 * Creates a new ECMAScript instance.
		 * @param source The string expression to parse.
		 */
        public function ECMAScript( source:String )
            {
            _source = source;
            pos    = 0;
            ch     = "";
            localscope = {};
            
            //VirtualMachine.filteredMethods.push( "system.serializers.eden::ECMAScript/debug" );
            }
        
		/**
		 * Indicates the String source representation of the parser (read-only).
		 */
        public function get source():String
            {
            return _source;
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
            //debug( "next() - ["+ch+"]" );
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
		 * Evaluate the specified string source value with the parser.
		 */
        public static function evaluate( source:String ):*
            {
            var parser:ECMAScript = new ECMAScript( source );
            return parser.eval();
            }
        
		/**
		 * Eval the source and returns the serialized object.
		 */
        public function eval():*
            {
            debug( "eval()" );
            comments = ""; //clean comments before starting a new eval
            var value:* = _ORC;
            var tmp:*;
            
            while( hasMoreChar() )
                {
                _scanSeparators();
                
                if( !GenericParser.isAlpha( ch ) )
                    {
                    next();
                    }
                
                tmp = _scanValue();
                
                _scanSeparators();
                
                if( tmp != _ORC )
                    {
                    value = tmp;
                    }
                
                /* note: poor man semicolon auto-insertion */
                if( ch == " " )
                    {
                    ch = ";";
                    }
                }
            
            if( value == _ORC )
                {
                value = undefined;
                }
            
            if( !_singleValue )
                {
                value = localscope;
                }
            
            return value;
            }
        
		/**
		 * Dispatch a log message.
		 * Add a config to either
		 * <li> store logs (nonblock parsing)</li>
		 * <li> display logs (nonblock parsing)</li>
		 * <li> throw an error (block parsing)</li>
		 * <li>add a safety mecanism to prevent infinite loop log when the same error is logged over and over in non-blocking mode</li>
		 */
        public function log( str:String ):void
            {
            if( config.verbose )
                {
                trace( str );
                }
            }
        
        /* group: testers */
        
		/**
		 * Indicates if the specified expression is a digit number value.
		 */
        public function isDigitNumber( num:String ):Boolean
            {
            debug( "isDigitNumber( \""+num+"\" )" );
            var numarr:Array = num.split( "" );
            
            for( var i:int=0; i<numarr.length; i++ )
                {
                if( !GenericParser.isDigit( numarr[i] ) )
                    {
                    return false;
                    }
                }
            
            return true;
            }
        
		/**
		 * Indicates if the specified expression is a start identifier.
		 * @see ECMA-262 spec 7.6 (PDF p26/188)
		 */
        public function isIdentifierStart( c:String ):Boolean
            {
            debug( "isIdentifierStart( \""+c+"\" )" );
            if( GenericParser.isAlpha( c ) || (c == "_") || (c == "$" ) )
                {
                return true;
                }
            
            if( c.charCodeAt( 0 ) < 128 )
                {
                return false;
                }
            
            return false;
            }
        
		/**
		 * Indicates if the identifier is a part.
		 */
        public function isIdentifierPart( c:String ):Boolean
            {
            debug( "isIdentifierPart( \""+c+"\" )" );
            if( isIdentifierStart( c ) )
                {
                return true;
                }
            
            if( GenericParser.isDigit( c ) )
                {
                return true;
                }
            
            if( c.charCodeAt( 0 ) < 128 )
                {
                return false;
                }
            
            return false;
            }
        
		/**
		 * Inidcates if the specified character is a line terminator.
		 * <p>Note: line terminators</p>
		 * <pre class="prettyprint">
		 * "\n" - u000A - LF
		 * "\R" - u000D - CR
		 * ???  - u2028 - LS
		 * ???  - u2029 - PS
		 * see: ECMA-262 spec 7.3 (PDF p24/188)
		 * </p>
		 */
        public function isLineTerminator( c:String ):Boolean
            {
            debug( "isLineTerminator( \""+c+"\" )" );
            switch( c )
                {
                case "\u000A": case "\u000D": case "\u2028": case "\u2029":
                return true;
                
                default:
                return false;
                }
            }
        
		/**
         * Indicates if the specified indentifier is a reserved keyword.
         * Reserved Keywords see : <b>ECMA-262 spec 7.5.2 p13 (PDF p25/188)</b>
		 */
        public function isReservedKeyword( identifier:String ):Boolean
            {
            debug( "isReservedKeyword( \""+identifier+"\" )" );
            if( !config.strictMode )
                {
                identifier = identifier.toLowerCase();
                }
            
            switch( identifier )
                {
                case "break":
                case "case": case "catch": case "continue":
                case "default": case "delete": case "do":
                case "else":
                case "finally": case "for": case "function":
                case "if": case "in": case "instanceof":
                case "new":
                case "return":
                case "switch":
                case "this": case "throw": case "try": case "typeof":
                case "var": case "void":
                case "while": case "with":
                log( Strings.format( strings.reservedKeyword, identifier ) );
                return true;
                
                default:
                return false;
                }
            }
        
		/**
         * Indicates if the specified identifier string value is a future reserved keyword.  
		 * <p><b>Note :</b> Future Reserved Keywords in ECMA-262 spec 7.5.3</p>
		 */
        public function isFutureReservedKeyword( identifier:String ):Boolean
            {
            debug( "isFutureReservedKeyword( \""+identifier+"\" )" );
            if( !config.strictMode )
                {
                identifier = identifier.toLowerCase();
                }
            
            switch( identifier )
                {
                case "abstract":
                case "boolean": case "byte":
                case "char": case "class": case "const":
                case "debugger": case "double":
                case "enum": case "export": case "extends":
                case "final": case "float":
                case "goto":
                case "implements": case "import": case "int": case "interface":
                case "long":
                case "native":
                case "package": case "private": case "protected": case "public":
                case "short": case "static": case "super": case "synchronized":
                case "throws": case "transient":
                case "volatile":
                log( Strings.format( strings.futurReservedKeyword, identifier ) );
                return true;
                
                default:
                return false;
                }
            }

		/**
		 * Indicates if the specified path is valid.
		 */
        public function isValidPath( path:String ):Boolean
            {
            debug( "isValidPath( \""+path+"\" )" );
            var paths:Array = _pathAsArray( path );
            var subpath:String;
            
            for( var i:int=0; i<paths.length; i++ )
                {
                subpath = paths[i];
                
                if( isReservedKeyword( subpath ) ||
                    isFutureReservedKeyword( subpath ) )
                    {
                    log( Strings.format( strings.notValidPath, path ) );
                    return false;
                    }
                
                }
            
            /* TODO:
               - add authorized hook
            */
            
            return true;
            }
		
		/**
		 * Indicates if the specified path does exist in the local scope.
		 */
        private function _doesExistInLocalScope( path:String ):Boolean
            {
            debug( "doesExistInLocalScope( \""+path+"\" )" );
            if( _localPool[ path ] != undefined )
                {
                return true;
                }
            
            var scope:*     = localscope;
            var paths:Array = _pathAsArray( path );
            var subpath:*;
            var arrayIndex:Boolean;
            
            for( var i:int=0; i<paths.length; i++ )
                {
                arrayIndex = false;
                subpath = paths[i];
                
                if( isDigitNumber( subpath ) )
                    {
                    subpath = parseInt( subpath );
                    arrayIndex = true;
                    }
                
                if( scope[ subpath ] == undefined )
                    {
                    return false;
                    }
                
                if( arrayIndex )
                    {
                    _localPool[ paths.slice(0,i).join(".") + "." + subpath ] = scope[ subpath ];
                    }
                
                scope = scope[ subpath ];
                }
            
            return true;
            }
        
		/**
		 * Indicates if the specified path does exist in the global scope.
		 */
        private function _doesExistInGlobalScope( path:String ):Boolean
            {
            debug( "doesExistInGlobalScope( \""+path+"\" )" );
            if( _globalPool[ path ] != undefined )
                {
                traceGlobalPool();
                return true;
                }
            
            var scope:*;
            var scopepath:String = "";
            var subpath:*        = "";
            var paths:Array      = _pathAsArray( path );
            var arrayIndex:Boolean;
            
            var foundScope:Boolean = false;
            
            for( var i:int=0; i<paths.length; i++ )
                {
                if( !foundScope )
                    {
                    if( i == 0 )
                        {
                        scopepath = paths[i];
                        }
                    else
                        {
                        scopepath += "." + paths[i];
                        }
                    
                    if( _globalPool[ scopepath ] != undefined )
                        {
                        foundScope = true;
                        scope = _globalPool[ scopepath ];
                        }
                    else if( Reflection.hasClassByName( scopepath ) )
                        {
                        foundScope = true;
                        scope =  Reflection.getDefinitionByName( scopepath );
                        debug( "GLOBAL POOL: " + scopepath );
                        _globalPool[ scopepath ] = scope;
                        }
                    }
                else
                    {
                    arrayIndex = false;
                    subpath = paths[i];
                    //VirtualMachine.beginTrace();
                    if( isDigitNumber( subpath ) )
                        {
                        subpath = parseInt( subpath );
                        arrayIndex = true;
                        }
                    //VirtualMachine.endTrace();
                    if( scope[ subpath ] == undefined )
                        {
                        return false;
                        }
                    
                    if( arrayIndex )
                        {
                        debug( ">> GLOBAL POOL : " + scopepath+"."+paths[i-1]+"."+subpath );
                        _globalPool[ scopepath+"."+paths[i-1]+"."+subpath ] = scope[ subpath ];
                        }
                    else
                        {
                        debug( ">> GLOBAL POOL : " + scopepath+"."+subpath );
                        _globalPool[ scopepath+"."+subpath ] = scope[ subpath ];
                        }
                    scope = scope[ subpath ];
                    }
                }
            
            if( foundScope )
                {
                return true;
                }
            
            return false;
            }
        
        /* group: scanners */
        
        /**
         * Scan the comments. 
         * - add a log/store mecanism for the comments
         *   so after a parsing we can review all the comments
         * - allow an option to ouput comment strings instead
         *   of the parsing result
         *   -> could be usefull to parse code for documentation
         */
        private function _scanComments():void
            {
            debug( "scanComments()" );
            next();
            
            switch( ch )
                {
                case "/":
                comments += "//";
                while( !isLineTerminator( ch ) && hasMoreChar() )
                    {
                    next();
                    comments += ch;
                    }
                
                _scanSeparators();
                break;
                
                case "*":
                comments += "/*";
                var ch_:String = next();
                comments += ch_;
                
                while( (ch_ != "*") && (ch != "/") )
                    {
                    ch_ = ch;
                    next();
                    comments += ch;
                    
                    if( ch == "" )
                        {
                        log( strings.unterminatedComment );
                        break;
                        }
                    }
                
                next();
                break;
                
                case "":
                default:
                log( strings.errorComment );
                }
            }
        
        /**
         * Scan the separators.
         */
        private function _scanSeparators():void
            {
            debug( "scanSeparators()" );
            var scan:Boolean = true;
            
            while( scan )
                {
                switch( ch )
                    {
                    /* note:
                       White Space
                       "\t" - \u0009 - TAB
                       "\v" - \u000B - VT
                       "\f" - \u000C - FF
                       " "  - \u0020 - SP
                       ???  - \u00A0 - NBSP
                       see: ECMA-262 spec 7.2 (PDF p23/188)
                    */
                    case "\u0009": case "\u000B": case "\u000C": case "\u0020": case "\u00A0":
                    next();
                    break;
                    
                    /* note:
                       line terminators
                       "\n" - \u000A - LF
                       "\R" - \u000D - CR
                       ???  - \u2028 - LS
                       ???  - \u2029 - PS
                       see: ECMA-262 spec 7.3 (PDF p24/188)
                    */
                    case "\u000A": case "\u000D": case "\u2028": case "\u2029":
                    next();
                    break;
                    
                    case "/":
                    _scanComments();
                    break;
                    
                    default:
                    scan = false;
                    }
                }
            }
        
        
        /**
         * Scan the whitespaces.  
         * <p><b>White Space :</b></p>
         * <pre class="prettyprint">
         * "\t" - u0009 - TAB
         * "\v" - u000B - VT
         * "\f" - u000C - FF
         * " "  - u0020 - SP
         * ???  - u00A0 - NBSP
         * </pre>
         * <p><b>See :</b> ECMA-262 spec 7.2 (PDF p23/188)</p>
         */
        private function _scanWhiteSpace():void
            {
            debug( "scanWhiteSpace()" );
            var scan:Boolean = true;
            
            while( scan )
                {
                switch( ch )
                    {
                    case "\u0009": case "\u000B": case "\u000C": case "\u0020": case "\u00A0":
                    next();
                    break;
                    
                    case "/":
                    _scanComments();
                    break;
                    
                    default:
                    scan = false;
                    }
                }
            }
        
        /**
         * Scans the identifiers.
         */
        private function _scanIdentifier():String
            {
            debug( "scanIdentifier()" );
            var id:String = "";
            
            if( isIdentifierStart( ch ) )
                {
                id += ch;
                next();
                
                while( isIdentifierPart( ch ) )
                    {
                    id += ch;
                    next();
                    }
                }
            else
                {
                log( strings.errorIdentifier );
                }
            
            return id;
            }
        
        /**
         * Scan the paths.
         */
        private function _scanPath():String
            {
            debug( "scanPath()" );
            var path:String = "";
            var subpath:String = "";
            
            if( isIdentifierStart( ch ) )
                {
                path += ch;
                next();
                
                while( isIdentifierPart( ch ) ||
                       (ch == ".") ||
                       (ch == "[") )
                    {
                    
                    if( ch == "[" )
                        {
                        next();
                        _scanWhiteSpace();
                        
                        if( GenericParser.isDigit( ch ) )
                            {
                            subpath = String( _scanNumber() );
                            _scanWhiteSpace();
                            path += "." + subpath;
                            }
                        else if( (this.ch == "\"") || (this.ch == "\'") )
                            {
                            subpath = _scanString( ch );
                            _scanWhiteSpace();
                            path += "." + subpath;
                            }
                        
                        if( ch == "]" )
                            {
                            next();
                            continue;
                            }
                        }
                    
                    
                    path += ch;
                    next();
                    }
                
                }
            
            /*
            if( path.startsWith( "_global." ) )
                {
                path = path.substr( "_global.".length );
                }
            */
            
            /*
            if( !_inConstructor && ch == "(" )
                {
                _inFunction = true;
                return scanFunction( path );
                }
            */
            
            /*
            if( ch == "(" )
                {
                _inFunction = true;
                return scanFunction( path );
                }
            */
            debug( "scanPath returns ["+path+"]" );
            return path;
            }
        
        /* group: evaluators */
        
        /**
         * @private
         */
        private function _pathAsArray( path:String ):Array
            {
            debug( "_pathAsArray( \""+path+"\" )" );
            var paths:Array;
            if( path.indexOf( "." ) > -1 )
                {
                paths = path.split( "." );
                }
            else
                {
                paths = [ path ];
                }
            debug( "_pathAsArray returns ["+path+"]" );
            return paths;
            }
        
        /**
         * @private
         */
        private function _createPath( path:String ):void
            {
            debug( "_createPath( \""+path+"\" )" );
            var paths:Array    = _pathAsArray( path );
            var prop:*         = paths.shift();
            var subpath:String = "";
            var member:*;
            
            if( localscope[ prop ] == undefined )
                {
                if( isDigitNumber( prop ) )
                    {
                    prop = parseInt( prop );
                    }
                
                localscope[ prop ] = {};
                _localPool[ prop ] = localscope[ prop ];
                }
            
            if( paths.length > 0 )
                {
                subpath = prop;
                var scope:* = localscope[ prop ];
                
                for( var i:int=0; i<paths.length; i++ )
                    {
                    member = paths[i];
                    subpath += "." + member;
                    
                    if( isDigitNumber( member ) )
                        {
                        member = parseInt( member );
                        }
                    
                    if( scope[member] == undefined )
                        {
                        scope[member] = {};
                        _localPool[ subpath ] = scope[member];
                        }
                    
                    scope = scope[member];
                    }
                }
            
            }
        
		/**
		 * Scans the Strings.
		 */
        private function _scanString( quote:String ):String
            {
            debug( "scanString( "+quote+" )" );
            var str:String = "";
            
            if( ch == quote )
                {
                while( (next() != "") )
                    {
                    switch( ch )
                        {
                        case quote:
                        next();
                        return str;
                        
                        case "\\":
                        /* note:
                           Escape Sequence
                           \ followed by one of ' " \ b f n r t v
                           or followed by x hexdigit hexdigit
                           or followed by u hexdigit hexdigit hexdigit hexdigit
                           see: ECMA-262 specs 7.8.4 (PDF p30 to p32/188)
                        */
                        switch( next() )
                            {
                            case "b": //backspace       - \u0008
                            str += "\b";
                            break;
                            
                            case "t": //horizontal tab  - \u0009
                            str += "\t";
                            break;
                            
                            case "n": //line feed       - \u000A
                            str += "\n";
                            break;
                            
                            /* TODO: check \v bug */
                            case "v": //vertical tab    - \u000B
                            str += "\v";
                            break;
                            
                            case "f": //form feed       - \u000C
                            str += "\f";
                            break;
                            
                            case "r": //carriage return - \u000D
                            str += "\r";
                            break;
                            
                            case "\"": //double quote   - \u0022
                            str += "\"";
                            break;
                            
                            case "\'": //single quote   - \u0027
                            str += "\'";
                            break;
                            
                            case "\\": //backslash      - \u005c
                            str += "\\";
                            break;
                            
                            case "u": //unicode escape sequence \uFFFF
                            var ucode:String = source.substring( pos, pos+4 );
                            str += String.fromCharCode( parseInt( ucode, 16 ) );
                            pos += 4;
                            break;
                            
                            case "x": //hexadecimal escape sequence \xFF
                            var xcode:String = source.substring( pos, pos+2 );
                            str += String.fromCharCode( parseInt( xcode, 16 ) );
                            pos += 2;
                            break;
                            
                            default:
                            str += ch;
                            }
                        break;
                        
                        default:
                        if( !isLineTerminator( ch ) )
                            {
                            str += ch;
                            }
                        else
                            {
                            log( strings.errorLineTerminator );
                            }
                        }
                    
                    }
                }
            
            log( strings.errorString );
            return "";
            }
        
		/**
		 * Scans Numbers.
		 */
        private function _scanNumber():Number
            {
            debug( "scanNumber()" );
            var value:Number;
            
            var num:String  = "";
            // var oct:String  = "";
            var hex:String  = "";
            var sign:String = "";
            var isSignedExp:String = "";
            
            if( ch == "-" )
                {
                sign = "-";
                next();
                }
            
            if( ch == "0" )
                {
                next();
                
                if( (ch == "x") || (ch == "X") )
                    {
                    next();
                    
                    while( GenericParser.isHexDigit( ch ) )
                        {
                        hex += ch;
                        next();
                        }
                    
                    if( hex == "" )
                        {
                        log( strings.malformedHexadecimal );
                        return NaN;
                        }
                    else
                        {
                        return Number( sign + "0x" + hex );
                        }
                    }
                else
                    {
                    num += "0";
                    }
                }
            
            while( GenericParser.isDigit( ch ) )
                {
                num += ch;
                next();
                }
            
            if( ch == "." )
                {
                num += ".";
                next();
                
                while( GenericParser.isDigit( ch ) )
                    {
                    num += ch;
                    next();
                    }
                }
        
            if( ch == "e" )
                {
                num += "e";
                isSignedExp = next();
                
                if( (isSignedExp == "+") || (isSignedExp == "-") )
                    {
                    num += isSignedExp;
                    next();
                    }
                
                while( GenericParser.isDigit( ch ) )
                    {
                    num += ch;
                    next();
                    }
                }
            
            /*
            if( (num.charAt(0) == "0") && isOctalNumber( num ) )
                {
                value = parseInt( sign + num );
                }
            else
                {
                value = Number( sign + num );
                }
            */
            
            /* note:
               we do not support octal numbers anymore
            */
            value = Number( sign + num );
            
            if( !isFinite( value ) )
                {
                log( strings.errorNumber );
                return NaN;
                }
            else
                {
                return value;
                }
            }
        
        /**
        * Scans an objet litteral.
        */
        private function _scanObject():Object
            {
            debug( "scanObject()" );
            var obj:Object = {};
            var member:String;
            var value:*;
            
            if( ch == "{" )
                {
                next();
                _scanSeparators();
                
                if( ch == "}" )
                    {
                    next();
                    return obj;
                    }
                
                while( ch != "" )
                    {
                    member = _scanIdentifier();
                    _scanWhiteSpace();
                    
                    if( ch != ":" )
                        {
                        break;
                        }
                    
                    next();
                    _inAssignement = true;
                    value = _scanValue();
                    _inAssignement = false;
                    
                    if( !isReservedKeyword( member ) &&
                        !isFutureReservedKeyword( member ) )
                        {
                        obj[member] = value;
                        }
                    
                    _scanSeparators();
                    
                    if( ch == "}" )
                        {
                        next();
                        return obj;
                        }
                    else if( ch != "," )
                        {
                        break;
                        }
                    
                    next();
                    _scanSeparators();
                    }
                }
            
            log( strings.errorObject );
            return undefined;
            }
        
        /**
        * Scan an array litteral
        */
        private function _scanArray():Array
            {
            debug( "scanArray()" );
            var arr:Array = [];
            
            if( ch == "[" )
                {
                next();
                _scanSeparators();
                
                if( ch == "]" )
                    {
                    next();
                    return arr;
                    }
                
                while( ch != "" )
                    {
                    arr.push( _scanValue() );
                    _scanSeparators();
                    
                    if( ch == "]" )
                        {
                        next();
                        return arr;
                        }
                    else if( ch != "," )
                        {
                        break;
                        }
                    
                    next();
                    _scanSeparators();
                    }
                }
            
            log( strings.errorArray );
            return undefined;
            }
        
		/**
		 * Scans the Functions.
		 */
        private function _scanFunction( fcnPath:String, pool:*, ref:* = null ):*
            {
            debug( "scanFunction( " + fcnPath + " )" );
            var args:Array = [];
            var fcnName:String;
            var fcnObj:*;
            var fcnObjScope:*;
            
            var isClass:Boolean = pool[ fcnPath ] is Class;
            
            if( fcnPath.indexOf( "." ) > -1 )
                {
                fcnName = fcnPath.split( "." ).pop();
                }
            else
                {
                fcnName = fcnPath;
                }
            
            if( !isClass )
                {
                fcnPath = fcnPath.split( "."+fcnName ).join("");
                }
            
            _scanWhiteSpace();
            next();
            _scanSeparators();
            var foundEndParenthesis:Boolean = false;
            while( ch != "" )
                {
                if( ch == ")" )
                    {
                    foundEndParenthesis = true;
                    next();
                    break;
                    }
                
                args.push( _scanValue() );
                _scanSeparators();
                
                if( ch == "," )
                    {
                    next();
                    _scanSeparators();
                    }
                
                if( (pos == source.length) && (ch != ")") )
                    {
                    log( "unterminated parenthesis, check your function/constructor \"" + fcnPath + "\"" );
                    return config.undefineable;
                    }
                }
            
            if( !foundEndParenthesis )
            	{
            	log( "unterminated parenthesis, check your function/constructor \"" + fcnPath + "\"" );
            	return config.undefineable;
            	}
            
            if( isClass || (fcnPath == fcnName) )
                {
                fcnObj = pool[ fcnPath ];
                fcnObjScope = null;
                }
            else
                {
                fcnObj = pool[ fcnPath ][ fcnName ];
                fcnObjScope = pool[ fcnPath ];
                }
            
            /*
            if( config.security && !isAuthorized( fcnPath ) )
                {
                log( String.format( strings.notAuthorizedFunction, fcnPath ) );
                return config.undefineable;
                }
    //         else
    //             {
    //             this.debug( fcnPath + " is authorized (scanFunction)" );
    //             }
            */
            
            if( !isClass && (ref == null) && (fcnObj == undefined) )
                {
                log( Strings.format( strings.doesNotExist, fcnPath ) );
                return config.undefineable;
                }
            else
                {
                if( _inConstructor )
                    {
                    _inConstructor = false;
                    
                    try
                        {
                        
                        return Reflection.invokeClass(fcnObj as Class, args) ;
                        
                        }
                    catch( e:Error )
                        {
                        log( "malformed ctor - " + e.toString() );
                        return config.undefineable;
                        }
                    }
                
                //return fcnObj.apply( fcnObjScope, args );
                var result:*;
                
                if( ref != null )
                    {
                    result = ref[ fcnName ].apply( ref, args );
                    }
                else
                    {
                    result = fcnObj.apply( fcnObjScope, args );
                    }
                
                if( ch == "." )
                    {
                    next();
                    return _scanFunction( _scanPath(), pool, result );
                    }
                else
                    {
                    if( !config.allowFunctionCall )
                        {
                        log( Strings.format( strings.notFunctionCallAllowed, fcnPath, args ) );
                        return config.undefineable;
                        }
                    return result;
                    }
                }
            
            log( strings.errorFunction );
            }
        
        /**
         * Scans the keywords.
         */
        private function _scanKeyword( pre:String = "" ):*
            {
            debug( "scanKeyword( "+pre+" )" );
            
            var word:String = "";
            var baseword:String = _scanPath();
            
            word = pre + baseword;
            
            if( word == "" )
                {
                return _ORC;
                }
            
            switch( word )
                {
                case "undefined":
                return config.undefineable;
                
                // Null literal
                case "null":
                return null;
                
                // Boolean literals
                case "true":
                return true;
                
                case "false":
                return false;
                
                // Number literals
                /* note:
                   here we use shortcuts for ocmmon const to speedup the parsing
                   but if they were not here they would be parsed just fine ;)
                */
                case "NaN":
                return NaN;
                
                case "-Infinity":
                return -Infinity;
                
                case "Infinity":
                case "+Infinity":
                return Infinity;
                
                
                case "new":
                _inConstructor = true;
                _scanWhiteSpace();
                baseword = _scanPath();
                
                default:
                var localRef:Boolean  = false;
                var globalRef:Boolean = false;
                var result:*;
                
                if( _doesExistInGlobalScope( baseword ) )
                    {
                    globalRef = true;
                    }
                else if( _doesExistInLocalScope( baseword ) )
                    {
                    localRef     = true;
                    _singleValue = false;
                    }
                else if( isValidPath( baseword ) && !_inAssignement && !_inConstructor )
                    {
                    _createPath( baseword );
                    localRef     = true;    
                    _singleValue = false;
                    }
                
                /* coded in the train listening RUN-DMC "It's Tricky"
                   and refactored listening Ugly Kid joe "too bad" :D
                */
                if( !_inAssignement && (source.indexOf( "=" ) > -1) )
                    {
                    
                    if( localRef )
                        {
                        _scanLocalAssignement( baseword );
                        }
                    else if( globalRef )
                        {
                        _scanGlobalAssignement( baseword );
                        }
                    
                    }
                
                if( !localRef && !globalRef )
                    {
                    log( baseword+" not found in MEMORY!" );
                    return config.undefineable;
                    }
                
                if( localRef )
                    {
                    if( ch == "(" )
                        {
                        result = _scanFunction( baseword, _localPool );
                        }
                    else
                        {
                        result = _localPool[ baseword ];
                        }
                    
                    return (pre == "-") ? -result: result;
                    }
                
                if( globalRef )
                    {
                    if( ch == "(" )
                        {
                        result = _scanFunction( baseword, _globalPool );
                        }
                    else
                        {
                        result = _globalPool[ baseword ];
                        }
                    
                    return (pre == "-") ? -result: result;
                    }
                
                return config.undefineable;
                }
            
            log( strings.errorKeyword );
            }

		/**
		 * Scans the global assignement of the specified path.
		 */
        private function _scanGlobalAssignement( path:String ):void
            {
            debug( "scanGlobalAssignement( "+path+" )" );
            var scope:*;
            var scopepath:String = "";
            var subpath:*        = "";
            var paths:Array      = _pathAsArray( path );
            var member:String    = paths.pop();
            
            var foundScope:Boolean = false;
            var size:uint = paths.length ;
            for( var i:uint =0 ; i < size ; i++ )
                {
                if( !foundScope )
                    {
                    if( i == 0 )
                        {
                        scopepath = paths[i];
                        }
                    else
                        {
                        scopepath += "." + paths[i];
                        }
                    
                    if( Reflection.hasClassByName( scopepath ) )
                        {
                        foundScope = true;
                        scope =  Reflection.getDefinitionByName( scopepath );
                        }
                    }
                else
                    {
                    subpath = paths[i];
                    
                    if( isDigitNumber( subpath ) )
                        {
                        subpath = parseInt( subpath );
                        }
                    
                    if( scope[ subpath ] == undefined )
                        {
                        return;
                        }
                    
                    scope = scope[ subpath ];
                    }
                }
            
            _scanWhiteSpace();
            
            if( ch == "=" )
                {
                _singleValue = false;
                _inAssignement = true;
                next();
                _scanWhiteSpace();
                
                if( isLineTerminator( ch ) )
                    {
                    /* TODO: check if undefineable value is not preferable here */
                    log( "assignement = without RHS !" );
                    return;
                    }
                
                var value:* = _scanValue();
                scope[ member ] = value;
                _globalPool[ path ] = scope[member];
                
                _inAssignement = false;
                }
            
            }

		/**
		 * Scans the root local assignement of the specified name value..
		 */
        private function _scanRootLocalAssignement( name:String ):void
            {
            debug( "scanRootLocalAssignement( "+name+" )" );
            _scanWhiteSpace();
            
            if( ch == "=" )
                {
                _singleValue = false;
                _inAssignement = true;
                next();
                //scanWhiteSpace();
                _scanSeparators();
                
                if( isLineTerminator( ch ) )
                    {
                    /* TODO: check if undefineable value is not preferable here */
                    log( "assignement = without RHS !" );
                    return;
                    }
                
                var value:* = _scanValue();
                
                if( value == _ORC )
                    {
                    value = config.undefineable;
                    }
                
                localscope[ name ] = value;
                _localPool[ name ] = localscope[ name ];
                tracePool();
                _inAssignement = false;
                }
            }
        
		/**
		 * Scans the local assigment of the specified path.
		 */        
        private function _scanLocalAssignement( path:String ):void
            {
            debug( "scanLocalAssignement( "+path+" )" );
            
            if( path.indexOf( "." ) == -1 )
                {
                _scanRootLocalAssignement( path );
                return;
                }
            
            
            var paths:Array   = _pathAsArray( path );
            var prop:* = paths.shift();
            var member:* = paths.pop();
            
            if( isDigitNumber( prop ) )
                {
                prop = parseInt( prop );
                }
            
            if( isDigitNumber( member ) )
                {
                member = parseInt( member );
                }
            
            var subpath:*;
            var scope:*;
            
            scope = localscope[ prop ];
            
            var size:uint = paths.length ;
            for( var i:uint =0 ; i < size ; i++ )
                {
                subpath = paths[i];
                
                if( isDigitNumber( subpath ) )
                    {
                    subpath = parseInt( subpath );
                    }
                
                if( scope[ subpath ] == undefined )
                    {
                    return;
                    }
                
                scope = scope[ subpath ];
                }
            
            _scanWhiteSpace();
            
            if( ch == "=" )
                {
                _singleValue = false;
                _inAssignement = true;
                next();
                //scanWhiteSpace();
                _scanSeparators();
                
                if( isLineTerminator( ch ) )
                    {
                    /* TODO: check if undefineable value is not preferable here */
                    log( "assignement = without RHS !" );
                    return;
                    }
                
                var value:* = _scanValue();
                scope[ member ] = value;
                _localPool[ path ] = scope[ member ];
                tracePool();
                _inAssignement = false;
                }
            
            }

		/**
		 * Scans the values.
		 */
        private function _scanValue():*
            {
            debug( "scanValue() - ch:"+ch );
            _scanSeparators();
            debug( "after scan - ch:"+ch );
            
            if( pos == source.length )
                {
                debug( "prevent unecessary scan" );
                
                if( _inAssignement )
                    {
                    debug( "RHS is missing" );
                    }
                
                return;
                }
            
            switch( ch )
                {
                case "{":
                return _scanObject();
                
                case "[":
                return _scanArray();
                
                case "\"": case "\'":
                return _scanString( ch );
                
                case "-": case "+":
                if( GenericParser.isDigit( source.charAt( pos ) ) )
                    {
                    return _scanNumber();
                    }
                else
                    {
                    var ch_:String = ch;
                    next();
                    return _scanKeyword( ch_ );
                    }
                
                case "0": case "1": case "2": case "3": case "4":
                case "5": case "6": case "7": case "8": case "9":
                return _scanNumber();
                
                default:
                return _scanKeyword();
                }
            
            }
        
        }
    
    }

