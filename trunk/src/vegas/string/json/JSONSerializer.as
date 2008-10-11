/*
    Licence
    
        Copyright (c) 2005 JSON.org

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:
    
        The Software shall be used for Good, not Evil.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
    
    Contributor(s) :
    
        - Ported to Actionscript May 2005 by Trannie Carter <tranniec@designvox.com>, wwww.designvox.com
        
        - Alcaraz Marc (aka eKameleon) <ekameleon@gmail.com> 
        
        2006-01-24 
            - Refactoring AS2 and MTASC Compatibilty 
            - AS3 version
            - SSAS version (for 'Flash Communication Server' and 'Flash Media Server')
            - Add Hexa Digits in 'deserialize' method
            - Supports in the objects deserialization the key property with quote, double quote or not surrounded by quotes.
            - Supports in string simple or double quotes.    
            
            More informations in the VEGAS page project : http://code.google.com/p/vegas/
            
            NOTE : eden Hexa digits code inspiration -> http://code.google.com/p/edenrr/
        
        2006-01-24 
            
            - Optimisation use private namespace to implement the parsing method. The parser is fast x2.

*/
package vegas.string.json 
{
    import system.Serializer;        

    /**
     * This class is the concrete class of the JSON singleton.
     * <code class="prettyprint">JSON</code> (JavaScript object Notation) is a lightweight data-interchange format.
     * <p>More information in the official site : <a href="http://www.JSON.org/">http://www.JSON.org</a></p>
     * <p>Add Hexa Digits tool in deserialize method - <a href="http://code.google.com/p/edenrr/">eden inspiration</a></p>
     * @example
     * <pre class="prettyprint">
     * import vegas.string.JSON;
     * import vegas.string.errors.JSONError;
     * 
     * import system.Reflection ;
     * 
     * // --- Init
     * 
     * var a:Array = [2, true, "hello"] ;
     * var o:Object = { prop1 : 1 , prop2 : 2 } ;
     * var s:String = "hello world" ;
     * var n:Number = 4 ;
     * var b:Boolean = true ;
     * 
     * trace("# Serialize \r") ;
     * 
     * trace("- a : " + JSON.serialize( a ) )  ;
     * trace("- o : " + JSON.serialize( o ) )  ;
     * trace("- s : " + JSON.serialize( s ) )  ;
     * trace("- n : " + JSON.serialize( n ) )  ;
     * trace("- b : " + JSON.serialize( b ) )  ;
     * 
     * trace ("\r# Deserialize \r") ;
     * 
     * var source:String = '[ { "prop1" : 0xFF0000 , prop2:2, prop3:"hello", prop4:true} , 2, true, 3, [3, 2] ]' ;
     * 
     * o = JSON.deserialize(source) ;
     * 
     * var l:uint = o.length ;
     * for (var i:uint = 0 ; i < l ; i++)
     * {
     *     trace("> " + i + " : " + o[i] + " -> typeof :: " + typeof(o[i])) ;
     *     if (typeof(o[i]) == "object")
     *     {
     *         for (var each:String in o[i])
     *         {
     *             trace("    > " + each + " : " + o[i][each] + " :: " + Reflection.getClassName(o[i][each]) ) ;
     *         }
     *     }
     * }
     * 
     * trace ("\r# JSONError \r") ;
     * 
     * source = "[3, 2," ; // test1
     * 
     * // var source:String = '{"prop1":coucou"}' ; // test2
     * 
     * try
     * {
     *    var errorObj:* = JSON.deserialize(source) ;
     * }
     * catch( e:JSONError )
     * {
     *     trace( e.toString() ) ;
     * }
     * </pre>
     */
    public class JSONSerializer implements Serializer 
    {

        use namespace jsonparser;
        
        /**
         * Creates a new JSONSerializer instance.
         */
        public function JSONSerializer()
        {
            super() ;
        }
                
        /**
         * The source to evaluate.
         */
        public var source:String ;
        
        /**
         * Indicates the indentor string representation.
         */        
        public function get indentor():String
        {
            return _indentor;
        }
        
        /**
         * @private
         */
        public function set indentor(value:String):void
        {
            _indentor = value;
        }        

        /**
         * Indicates the pretty indent value.
         */   
        public function get prettyIndent():int
        {
            return _prettyIndent;
        }        
        
        /**
         * @private
         */
        public function set prettyIndent(value:int):void
        {
        	 _prettyIndent = value ;
        }
        
        /**
         * Indicates the pretty printing flag value.
         */        
        public function get prettyPrinting():Boolean
        {
            return _prettyPrinting ;
        }        
        
        /**
         * @private
         */        
        public function set prettyPrinting(value:Boolean):void
        {
        	_prettyPrinting = value;
        }
        
        /**
         * Parse a string and interpret the source code to the correct object construct.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * "hello world" --> "hello world"
         * "0xFF"        --> 255
         * "{a:1,"b":2}" --> {a:1,b:2}
         * </pre>
         * @return a string representing the data.
         */ 
        public function deserialize( source:String ):*
        {
        	this.source = source ;
            at = 0 ;
            ch = ' ' ;
            return value() ;
        }
        
        /**
         * Serialize the specified value object passed-in argument.
         */          
        public function serialize( value:* ):String
        {
            var c:String ; // char
            var i:Number ;
            var l:Number ;
            var s:String = '' ;
            var v:* ;
            
            var tof:String = typeof(value) ;
            
            switch (tof) 
            {
            
                case 'object' :
                {
                    if (value)
                    {
                        if (value is Array) 
                        {
                        
                            l = (value as Array).length ;
                        
                            for (i = 0 ; i < l ; ++i) 
                            {
                                v = serialize(value[i]);
                                if (s) s += ',' ;
                                s += v ;
                            }
                            return '[' + s + ']';
                        
                        }
                        else if ( typeof( value.toString ) != 'undefined') 
                        {
                            
                            for (var prop:String in value) 
                            {
                                v = value[prop];
                                if ( (typeof(v) != 'undefined') && (typeof(v) != 'function') ) 
                                {
                                    v = serialize(v);
                                    if (s) 
                                    {
                                        s += ',' ;
                                    }
                                    s += serialize(prop) + ':' + v ;
                                }
                            }
                            return "{" + s + "}";
                        }
                    }
                    return 'null';
                }
            
                case 'number':
                {
                    return isFinite(value) ? String(value) : 'null' ;
                }
                
                case 'string' :
                {
                
                    l = (value as String).length ;
                    s = '"' ;
                    for (i = 0 ; i < l ; i += 1) 
                    {
                        c = (value as String).charAt(i) ;
                        if (c >= ' ') 
                        {
                            if (c == '\\' || c == '"') 
                            {
                                s += '\\';
                            }
                            s += c;
                        } 
                        else 
                        {
                            switch (c) 
                            {
                                
                                case '\b':
                                {
                                    s += '\\b';
                                    break ;
                                }
                                case '\f' :
                                {
                                    s += '\\f' ;
                                    break ;
                                }
                                case '\n' :
                                {
                                    s += '\\n' ;
                                    break ;
                                }
                                case '\r':
                                {
                                    s += '\\r' ;
                                    break ;
                                }
                                case '\t':
                                {
                                    s += '\\t' ;
                                    break ;
                                }
                                default:
                                {
                                    var code:Number = c.charCodeAt() ;
                                    s += '\\u00' + (Math.floor(code / 16).toString(16)) + ((code % 16).toString(16)) ;
                                }
                            }
                        }
                    }
                    return s + '"';
                }
                
                case 'boolean' :
                {
                    return String(value);
                }

                default :
                {
                    return 'null';
                }
            }
        }
                
        /**
         * @private
         */
        private var _prettyIndent:int = 0 ;
        
        /**
         * @private
         */
        private var _prettyPrinting:Boolean = false ;
        
        /**
         * @private
         */
        private var _indentor:String = "    " ;
       
        /**
         * @private
         */
        private namespace jsonparser ;
               
        /**
         * The current position of the iterator in the source.
         */
        jsonparser var at:Number = 0 ;

        /**
         * The current character of the iterator in the source.
         */
        jsonparser var ch:String = ' ' ;
        
        /**
         * Check the Array objects in the source expression.
         */
        jsonparser function array():Array 
        {
            var a:Array = [];
            if ( ch == '[' ) 
            {
                next()  ;
                white() ;
                if (ch == ']') 
                {
                    next();
                    return a;
                }
                while (ch) 
                {
                    a.push( value() ) ;
                    white();
                    if (ch == ']') 
                    {
                        next();
                        return a;
                    }
                    else if (ch != ',') 
                    {
                       break;
                    }
                    next();
                    white();
                }
            }
            error( strings.badArray );
            return null ;
        }        
        
        /**
         * Throws a JSONError with the passed-in message.
         */
        jsonparser function error( m:String ):void 
        {
            throw new JSONError( m, at - 1 , source) ;
        }        
        
        /**
         * Indicates if the passed-in character is a digit.
         */
        jsonparser function isDigit( c:String ):Boolean
        {
            return( ("0" <= c) && (c <= "9") );
        }

        /**
         * Indicates if the passed-in character is a hexadecimal digit.
         */
        jsonparser function isHexDigit( c:String ):Boolean 
        {
            return( isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f")) );
        }

        /**
         * Indicates if the current character is a key.
         */
        jsonparser function key():*
        {
            var s:String = ch;
            var semiColon:Number   = source.indexOf(':', at);
            var quoteIndex:Number  = source.indexOf('"', at) ;
            var squoteIndex:Number = source.indexOf("'", at) ;
            if( (quoteIndex <= semiColon && quoteIndex > -1) || (squoteIndex <= semiColon && squoteIndex > -1))
            {
                s = string() ;
                white() ;
                if(ch == ':')
                {
                    return s;
                }
                else
                {
                    error(strings.badKey);
                }
            }
    
                while ( next() ) // Use key handling 
                   {
                    if (ch == ':') 
                    {
                        return s;
                    } 
                    if(ch <= ' ')
                    {
                        //
                    }
                    else
                    {
                        s += ch;
                    }
                }
                
                error("Bad key") ;
            
        }
        
        /**
         * Returns the next character in the source String representation.
         * @return the next character in the source String representation.
         */
        jsonparser function next():String
        {
           ch = source.charAt(at);
           at += 1;
           return ch;
        }
        
        /**
         * Check the Number values in the source expression.
         */    
        jsonparser function number():* 
        {
            
            var n:* = '' ;
            var v:* ;
            var hex:String = '' ;
            var sign:String = '' ;
            
            if (ch == '-') 
            {
                n = '-';
                sign = n ;
                next();
            }
            
            if( ch == "0" ) 
            {
                next() ;
                if( ( ch == "x") || ( ch == "X") ) 
                {
                    next();
                    while( isHexDigit( ch ) ) 
                    {
                        hex += ch ;
                        next();
                    }
                    if( hex == "" ) 
                    {
                        error(strings.malFormedHexadecimal) ;
                    }
                    else 
                    {
                        return Number( sign + "0x" + hex ) ;
                    }
                } 
                else 
                {
                    n += "0" ;
                }
            }
                
            while ( isDigit(ch) ) 
            {
                n += ch ;
                next() ;
            }
    
            if (ch == '.') 
            {
                n += '.';
                while (next() && ch >= '0' && ch <= '9') 
                {
                    n += ch ;
                }
            }
    
            v = 1 * n ;
        
            if (!isFinite(v)) 
            {
                error(strings.badNumber);
            }
            else 
            {
                return v ;
            }
        
            return NaN ;
         
        }        
        
        /**
         * Check the Object values in the source expression.
         */       
        jsonparser function object():* 
        {
            var k:* = {} ;
            var o:* = {} ;
            if (ch == '{') 
            {
                
                next();
                white();
                
                if (ch == '}') 
                {
                    next() ;
                    return o ;
                }
                
                while (ch) 
                {
                       
                    k = key() ;
                       
                    white();
                        
                    if (ch != ':') 
                    {
                        break;
                    }
                        
                    next();
                        
                    o[k] = value() ;
    
                    white();
    
                    if (ch == '}') 
                    {
                        next();
                        return o;
                    } 
                    else if (ch != ',') 
                    {
                        break;
                    }
                    next();
                    white();
                }
            }
            error( strings.badObject ) ;
        }        
        
        /**
         * Check the string objects in the source expression.
         */
        jsonparser function string():* 
        {
            
           var i:* = '' ;
           var s:* = '' ; 
           var t:* ;
           var u:* ;
                
           var outer:Boolean = false;
            
           if (ch == '"' || ch == "'" ) 
           {
               var outerChar:String = ch ;
               while ( next() ) 
               {
                   if (ch == outerChar) 
                   {
                        next() ;
                        return s ;
                   }
                   else if (ch == '\\') 
                   {
                        switch ( next() ) 
                        {
                            case 'b':
                            {
                                s += '\b' ;
                                break ;
                            }
                            case 'f' :
                            {
                                s += '\f';
                                break ;
                            }
                            case 'n':
                            {
                                s += '\n';
                                    break ;
                                }
                                case 'r' :
                                {
                                    s += '\r';
                                    break ;
                                }
                                case 't' :
                                {
                                    s += '\t' ;
                                    break ;
                                }
                                case 'u' :
                                {
                                    u = 0;
                                    for (i = 0; i < 4; i += 1) 
                                    {
                                        t = parseInt( next() , 16 ) ;
                                        if (!isFinite(t)) 
                                        {
                                            outer = true;
                                            break;
                                        }
                                        u = u * 16 + t;
                                    }
                                    if(outer) 
                                    {
                                        outer = false;
                                        break;
                                    }
                                    s += String.fromCharCode(u);
                                    break;
                                }
                                default :
                                {
                                    s += ch;
                                }
                            }
                        } 
                        else 
                        {
                            s += ch;
                        }
                    }
                }
            
                error( strings.badString );
    
                return null ;
    
        }
        
        /**
         * Evaluates the values in the source expression.
         */
        jsonparser function value():* 
        {
            white() ;
            switch (ch) 
            {
                case '{' :
                {
                    return object();
                }
                case '[' : 
                {
                    return array();
                }
                case '"' : 
                case "'" :
                {
                    return string();
                }
                case '-' : 
                {
                    return number();
                }
                default  : 
                {
                    return ( ch >= '0' && ch <= '9' ) ? number() : word() ;
                }
            }
        }        
        
        /**
         * Check all white spaces.
         */
        jsonparser function white():void 
        {
            while (ch) 
            {
                if (ch <= ' ') 
                {
                    next();
                } 
                else if (ch == '/') 
                {
                    switch ( next() ) 
                    {
                        case '/' :
                        {
                            while ( next() && ch != '\n' && ch != '\r') 
                            {
                            }
                            break;
                        }
                        case '*' :
                        {
                            next();
                            for (;;) 
                            {
                                if (ch) 
                                {
                                    if (ch == '*') 
                                    {
                                        if ( next() == '/' ) 
                                        {
                                            next();
                                            break;
                                        }
                                    } 
                                    else 
                                    {
                                        next();
                                    }
                                }
                                else 
                                {
                                    error( strings.unterminatedComment );
                                }
                            }
                            break ;
                        }
                        default :
                        {
                            error( strings.syntaxError );
                        }
                    }
                } 
                else 
                {
                    break ;
                }
            }
        }
        
        /**
         * Check all special words in the source to evaluate.
         */
        jsonparser function word():* 
        {
                
            switch (ch) 
            {
                    
                case 't' :
                {
                    if (next() == 'r' && next() == 'u' && next() == 'e') 
                    {
                        next() ;
                        return true ;
                    }
                    break;
                }
                case 'f' :
                {
                    if (next() == 'a' && next() == 'l' && next() == 's' && next() == 'e') 
                    {
                        next() ;
                        return false ;
                    }
                    break;
                 }
                 case 'n':
                 {
                    if (next() == 'u' && next() == 'l' && next() == 'l') 
                    {
                        next() ;
                        return null ;
                    }
                    break;
                }
            }
            
            error( strings.syntaxError );
              
            return null ;
            
        }
    
    }

}
