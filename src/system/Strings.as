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
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  - Marc Alcaraz <ekameleon@gmail.com>.
*/

package system
    {
    import system.evaluators.EdenEvaluator;
    
    /**
     * A static class for String utilities.
     */
    public class Strings
        {

        /**
         * Helper method for the padLeft and padRight method.
         * @private
         */
        private static function _padHelper( str:String, totalWidth:int, paddingChar:String = " ", isRightPadded:Boolean = true ):String
            {
            if( (totalWidth < str.length) || (totalWidth < 0) )
                {
                return str;
                }
            
            /* note:
            we want to limit the string to ONLY ONE char
               
            for now we do that but perharps it would better
            to throw an Error
             */
            if( paddingChar.length > 1 )
                {
                paddingChar = paddingChar.charAt( 0 );
                }
            
            while( str.length != totalWidth )
                {
                if( isRightPadded == true )
                    {
                    str += paddingChar;
                    }
                else
                    {
                    str = paddingChar + str;
                    }
                }
            
            return str;
            }

        /**
         * Helper method used by trim, trimStart and trimEnd methods.
         * @private
         */
        private static function _trimHelper( str:String, trimChars:Array, trimStart:Boolean = false, trimEnd:Boolean = false ):String
            {
            var iLeft:int;
            var iRight:int;
            
            if( trimStart )
                {
                for( iLeft = 0; (iLeft < str.length) && (trimChars.indexOf( str.charAt( iLeft ) ) > -1) ; iLeft++ )
                    {
                    }
                
                str = str.substr( iLeft );
                }
            
            if( trimEnd )
                {
                for( iRight = str.length - 1; (iRight >= 0) && (trimChars.indexOf( str.charAt( iRight ) ) > -1) ; iRight-- )
                    {            
                    }
                
                str = str.substring( 0, iRight + 1 );
                }
            
            return str;
            }

        /**
         * Returns the center String representation of the specified String value.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * trace( Strings.center("hello world", 0) )         ; // hello world
         * trace( Strings.center("hello world", 20) )        ; //     hello world
         * trace( Strings.center("hello world", 20, "_" ) )  ; // ____hello world_____
         * </pre>
         * @param str The String to center.
         * @param size The number of character to center the String expression. (default 0)
         * @param separator The optional separator character use before and after the String to center. (default " ")
         * @return the center String representation of the specified String value.
         */
        public static function center( str:String, size:uint=0 , separator:String=" " ):String 
        {
            var n:uint = str.length ;
            if (size <= n)
            {
                return str ;
            }
            var m:int = Math.floor( ( size - n ) / 2 ) ;
            return repeat(separator, m) + str + repeat(separator, size - n - m) ;
        }
        
        /**
         * Compares the two specified String objects.
         * @param o1 first string to compare with the second string.
         * @param o2 second string to compare with the first string.
         * @param strict (optionnal) useCase boolean, default to false.
         * allows to take into account the string case for comparison. 
         */    
        public static function compare( o1:String, o2:String, strict:Boolean = false ):int
            {
            
            if( !strict )
                {
                o1 = o1.toLowerCase( );
                o2 = o2.toLowerCase( );
                }
            
            if( o1 == o2 )
                {
                return 0;
                }
            else if( o1.length == o2.length )
                {
                /* info:
                   localCompare return the char difference so we reuse that
                */
                
                var localcomp:Number = o1.localeCompare( o2 );
                
                /* note:
                   by default we want an ascending alphabetic order
                   with minuscule weighting less than majuscule
                   but as char value of majuscule are smaller
                   we have to inverse the negative/positive to obtain
                   the right order
                   
                   ex:
                   "a".charAt(0) = 97
                   "A".charAt(0) = 65
                   that means that "a" weight more than "A"
                   "a".localeCompare( "A" ) -> 32
                   but in our case we want a negative, because we consider
                   that "a" weight less than "A"
                   so to get the correct result we need to negate the result
                   -("a".localeCompare( "A" )) -> -32
                */
                if( localcomp == 0 )
                    {
                    return 0;
                    }
                else if( localcomp < 0 )
                    {
                    return 1;
                    }
                
                return -1;
                }
            else if( o1.length > o2.length )
                {
                return 1;
                }
            else
                {
                return -1;
                }
            }

        /**
         * Determines whether the end of this instance matches the specified String.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * var result:* ;
         * 
         * result = Strings.endsWith( "hello world", "world" );
         * trace("> " + result) ; // true
         * 
         * result = Strings.endsWith( "hello world", "hello" );
         * trace("> " + result) ; // false
         * </pre>
         */
        public static function endsWith( str:String, value:String ):Boolean
            {
            if( (str == null) || (value == null) || (str.length < value.length) )
                {
                return false;
                }
            
            return compare( str.substr( str.length - value.length ), value ) == 0;
            }
        
        /**
        * Contain a list of evaluators to be used in Strings.format
        * 
        * ex:
        * Strings.evaluators = { math: new MathEvaluator() };
        * Strings.format( "my result is ${2+3}math$" ); // "my result is 5"
        * 
        * note:
        * property names in the evaluators object can only contains
        * lower case alphabetical chars and digit chars
        */
        public static var evaluators:Object = {};
        
        /* internal:
           Strings.format can take index from 0 to infinity
           {0}, {1}, ..., {99}, etc.
           
           but _evaluate need to sync its indexes with the _format _indexes
           so we pick an arbitrary number: 100
           
           officially indexed token can go from {0} to {99}
           to avoid a conflict with that arbitrary number
        */
        private static var _hiddenIndex:uint = 100;
        
        /* internal:
           supported format
           ${...}$ default to EdenEvaluator
           ${...}name1,name2,...$
           
           TODO:
           there are no test for }...$ sequence
           so yeah it's weak and yeah you could break it with something like
           ${{a:1,b:"}",c:"$"}}$
        */
        private static function _evaluate( value:String ):Object
            {
            var obj:Object  = {};
                obj.format  = "";
                obj.indexes = [];
            
            var defaultEvaluator:EdenEvaluator = new EdenEvaluator();
            var evaluators:Array = [];
            
            var evaluate:Function = function( expression:* ):String
                {
                for( var i:uint = 0; i< evaluators.length; i++ )
                    {
                    expression = evaluators[i].eval( expression );
                    }
                return String( expression );
                };
            
            var evalSequence:String = "";
            var evalString:String   = "";
            // var evalValue:String    = "" ; // FIXME not use this variable for the moment
            var inBetween:String    = "";
            var pos1:int;
            var pos2:int;
            var lpos:int;
            
            var isValidChar:Function = function( c:String ):Boolean
                {
                if( (("a" <= c) && (c <= "z")) || (("0" <= c) && (c <= "9")) || (c == ",") )
                    {
                    return true;
                    }
                return false;
                };
            
            var isValid:Function = function( str:String ):Boolean
                {
                if( str == "" )
                    {
                    return true;
                    }
                var test:Array = str.split( "" );
                for( var i:uint = 0; i<test.length; i++ )
                    {
                    if( !isValidChar( test[i] ) )
                        {
                        return false;
                        } 
                    }
                return true;
                };
            
            while( value.indexOf( "${" ) > -1 )
                {
                pos1 = value.indexOf( "${" );
                pos2 = value.indexOf( "$", pos1+2 );
                if( pos2 == -1 )
                    {
                    throw new Error( "malformed evaluator, could not find [$] after [}]." );
                    }
                evalSequence = value.slice( pos1+2, pos2 );
                lpos = evalSequence.lastIndexOf( "}" );
                inBetween = evalSequence.substring( lpos+1 );
                
                while( !isValid(inBetween) )
                    {
                    pos2 = value.indexOf( "$", pos1+2+pos2 );
                    if( pos2 == -1 )
                        {
                        throw new Error( "malformed evaluator, could not find [$] after [}]." );
                        }
                    evalSequence = value.slice( pos1+2, pos2 );
                    lpos = evalSequence.lastIndexOf( "}" );
                    inBetween = evalSequence.substring( lpos+1 );
                    }
                
                if( lpos != evalSequence.length-1 )
                    {
                    var tmp:String = evalSequence.substring( lpos+1 );
                    var evaluatorsAlias:Array;
                    
                    if( tmp.indexOf(",") > -1 )
                        {
                        evaluatorsAlias = tmp.split( "," );
                        }
                    else
                        {
                        evaluatorsAlias = [ tmp ];
                        }
                    
                    for( var i:uint = 0; i<evaluatorsAlias.length; i++ )
                        {
                        if( Strings.evaluators[ evaluatorsAlias[i] ] )
                            {
                            evaluators.push( Strings.evaluators[ evaluatorsAlias[i] ] );
                            }
                        else
                            {
                            /* TODO:
                               throw an error here ?
                            */
                            trace( "## Warning: \"" +evaluatorsAlias[i]+ "\" is not a valid evaluator ##"  );
                            }
                        }
                    
                    }
                
                if( evaluators.length == 0 )
                    {
                    evaluators = [ defaultEvaluator ];
                    }
                
                evalString = evalSequence.substring( 0, lpos );
                
                obj.indexes.push( evaluate( evalString ) );
                value = value.split( "${"+evalSequence+"$" ).join( "{" + (_hiddenIndex+ (obj.indexes.length-1)) + "}" );
                }
            
            obj.format = value;
            return obj;
            }
        
        /* internal:
           supported format
           {0} {1}
           {0,5} {0,-5}
           {0,5:_} {0,-5:_}
           {toto} {titi}
           {toto,5} {toto,-5}
           {titi,5:_} {titi,-5:_}
           
           TODO:
           to {0,5} {0,-5} add something like {0,~5} to support padding to center
        */
        private static function _format( stringvalue:String, indexed:Array, named:Object, paddingChar:String = " " ):String
            {
            
            var parseExpression:Function = function( expression:String ):String
                {
                var value:String = "";
                var spaceAlign:int = 0;
                var isAligned:Boolean = false;
                var padding:String = paddingChar; 
                
                if( indexOfAny( expression, [ ",", ":" ] ) > -1 )
                    {
                    var vPos:int = expression.indexOf( "," );
                    if( vPos == -1 )
                        {
                        throw new Error( "malformed format, could not find [,] before [:]." );
                        }
                    
                    var fPos:int = expression.indexOf( ":" );
                    
                    if( fPos == -1 )
                        {
                        spaceAlign = int( expression.substr( vPos + 1 ) );
                        }
                    else
                        {
                        spaceAlign = int( expression.substring( vPos + 1, fPos ) );
                        padding = expression.substr( fPos + 1 );
                        }
                    
                    isAligned = true;
                    expression = expression.substring( 0, vPos );
                    }
                
                var c:String = expression.split( "" )[0];
                if( (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z")) )
                    {
                    value = String( named[ expression ] );
                    }
                else if( ("0" <= c) && (c <= "9") )
                    {
                    value = String( indexed[ int( expression ) ] );
                    }
                
                if( isAligned )
                    {
                    if( (spaceAlign > 0) && (value.length < spaceAlign) )
                        {
                        value = padLeft( value, spaceAlign, padding );
                        }
                    else if ( spaceAlign < -value.length )
                        {
                        value = padRight( value, -spaceAlign, padding );
                        }
                    }
                
                return value;
                };
            
            var expression:String = "";
            var formated:String   = "";
            var ch:String         = "";
            var pos:int           = 0;
            var len:int           = stringvalue.length;
            
            var next:Function = function():String
                {
                ch = stringvalue.charAt( pos );
                pos++;
                return ch;
                };
            
            while( pos < len )
                {
                next();
                if( ch == "{" )
                    {
                    expression = next();
                    while( next( ) != "}" )
                        {
                        expression += ch;
                        }
                    formated += parseExpression( expression );
                    }
                else
                    {
                    formated += ch;
                    }
                }
            
            return formated;
            }
        
        /** 
         * Format a string using indexed, named and/or evaluated parameters.
         * <p>Method call :</p>
         * <li>StringUtil.format(pattern:String, ...arguments:Array):String</li>
         * <li>StringUtil.format(pattern:String, [arg0:*,arg1:*,arg2:*, ...] ):String</li>
         * <li>StringUtil.format(pattern:String, [arg0:*,arg1:*,arg2:*, ...], ...args:Array ):String</li>
         * <li>StringUtil.format(pattern:String, {name0:value0,name1:value1,name2:value2, ...} ):String</li>
         * <li>StringUtil.format(pattern:String, {name0:value0,name1:value1,name2:value2, ...} , ...args:Array ) :String</li>
         * <p>Replaces the pattern item in a specified String with the text equivalent of the value of a specified Object instance.</p>
         * <p>Formats item : {token[,alignment][:paddingChar]}</p>
         * <p>If you want to escape the "{" and "}" chars use "{{" and "}}"
         * <li>"some {{formatitem}} to be escaped" -> "some {formatitem} to be escaped"</li>
         * <li>"some {{format {0} item}} to be escaped", "my" -> "some {format my titem} to be escaped"</li>
         * </p>
         * </p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * var result:String ;
         * 
         * // indexed from the arguments
         * 
         * result = Strings.format( "hello {1} {0} world", "big", "the" ); 
         * trace("> " + result) ; //"hello the big world"
         *
         * result = Strings.format("Brad's dog has {0,6:#} fleas.", 41) ;
         * trace("> " + result) ;
         *
         * result = Strings.format("Brad's dog has {0,-6} fleas.", 12) ;
         * trace("> " + result) ;
         *
         * result = Strings.format("{3} {2} {1} {0}", "a", "b", "c", "d") ;
         * trace("> " + result) ;
         * 
         * // named from an object
         * 
         * result = Strings.format( "hello I'm {name}", {name:"HAL"} );
         * trace("> " + result) ; //"hello I'm HAL"
         * 
         * // indexed from an array
         * 
         * var names:Array = ["A","B","C","D"];
         * var scores:Array = [16,32,128,1024];
         * for( var i:int=0; i<names.length; i++ )
         * {
         *     trace( Strings.format( "{0} scored {1,5}", [names[i], scores[i]] ) );
         * }
         * // "A scored    16"
         * // "B scored    32"
         * // "C scored   128"
         * // "D scored  1024"
         * 
         * // resolve toString
         * var x:Object = {};
         * x.toString = function() { return "john doe"; } ;
         * trace( Strings.format( "Who is {0} ?", x ) ) ; //"Who is john doe ?"
         * 
         * // you can off course reuse the index
         * var fruits:Array = ["apple", "banana", "pineapple"] ;
         * trace( Strings.format( "I like all fruits {0},{1},{2}, etc. but still I prefer above all {0}", fruits ) ); // "I like all fruits apple,banana,pineapple, etc. but still I prefer above all apple"
         * 
         * // indexed from an array + the arguments
         * var fruits:Array = ["apple", "banana", "pineapple"];
         * trace( Strings.format( "fruits: {0}, {1}, {2}, {3}, {4}, {5}", fruits, "grape", "tomato" ) ); //"fruits: apple, banana, pineapple, grape, tomato, undefined"
         * 
         * // passing reference and padding
         * var what = "answer" ;
         * result = Strings.format( "your {0} is within {answer,20:.}", {answer:"my answer"}, what ) ; 
         * trace("> " + result ) // "your answer is within ...........my answer"
         * 
         * // using evaluated parameters
         * Strings.evaluators = { math: new MathEvaluator() };
         * Strings.format( "my result is ${2+3}math$" ); // "my result is 5"
         * 
         * //by default evaluated parameters use EdenEvaluator with serialized result
         * Strings.format( "here some object '${ {a:1,b:2} }$'" ); //"here some object '{a:1,b:2}'"
         * 
         * //use EdenEvaluator with stringified result
         * Strings.evaluators = { math: new EdenEvaluator(false) };
         * Strings.format( "here some object '${ {a:1,b:2} }eden$'" ); //"here some object '[object Object]'"
         * Strings.format( "the host is ${system.Environment.host}eden$" ); //"the host is Flash 9.0.115.0"
         * 
         * //use chained evaluators
         * Strings.evaluators = { eden: new EdenEvaluator(false), date: new DateEvaluator() ];
         * Strings.format( "my date is ${new Date(2007,4,22,13,13,13)}eden,date$" ); //"my date is 22.05.2007 13:13:13"
         * 
         * </pre>
         */
        public static function format( format:String, ...args ):String
            {
            var indexedValues:Array = [];
            var namedValues:Object  = {};
            
            if( format == "" )
                {
                return format;
                }
            
            var evaluated:Object = _evaluate( format );
            
            if( (evaluated.indexes.length == 0) && ((args == null) || (args.length == 0)) )
                {
                return format; //nothing to format
                }
            
            format = evaluated.format;
            
            if( args.length >= 1 )
                {
                if( args[0] is Array )
                    {
                    indexedValues = indexedValues.concat( args[0] );
                    args.shift();
                    }
                else if( (args[0] is Object) && (String( args[0] ) == "[object Object]") )
                    {
                    var prop:String;
                    for( prop in args[0] )
                        {
                        namedValues[ prop ] = args[0][ prop ];
                        }
                    args.shift();
                    }
                }
            
            indexedValues = indexedValues.concat( args );
            
            if( indexedValues.length-1 >= _hiddenIndex )
                {
                /* TODO:
                   throw an error here ?
                */
                trace( "## Warning : indexed tokens are too big ##" );
                }
            
            for( var i:uint = 0; i< evaluated.indexes.length; i++ )
                {
                indexedValues[ (_hiddenIndex + i) ] =  evaluated.indexes[i];
                }
            
            var ORC1:String = "\uFFFC"; //Object Replacement Character
            var ORC2:String = "\uFFFD"; //Object Replacement Character
            
            if( indexOfAny( format, [ "{{", "}}" ] ) > -1 )
                {
                /* note:
                little limitation here
                we cover the case of {{{0}}} -> to be able
                to escape and inject within the escaped
                Strings.format( "{{{0}}}", "hello" ) -> "{hello}"
                but in more complex cases as {{{{{0}}}}} this scenario will fail
                
                workaround:
                if you really really really need to escape
                as much as {{{{ and }}}} do that
                Strings.format( "{left}{0}{right}", {left:"{{{{", "}}}}"}, "hello" ) -> "{{{{hello}}}}"
                   
                TODO:
                use regexp once String.format for JS/AS1 is stable
                 */
                format = format.split( "{{{" ).join( ORC1 + "{" );
                format = format.split( "{{" ).join( ORC1 );
                format = format.split( "}}}" ).join( "}" + ORC2 );
                format = format.split( "}}" ).join( ORC2 );
                }
            
            var formated:String = _format( format, indexedValues, namedValues );
            
            if( indexOfAny( format, [ ORC1, ORC2 ] ) > -1 )
                {
                formated = formated.split( ORC1 ).join( "{" );
                formated = formated.split( ORC2 ).join( "}" );
                }
            
            return formated;
            }

         /**
         * Reports the index of the first occurrence in this instance of any character in a specified array of Unicode characters.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings;
         * 
         * Strings.indexOfAny("hello world", [2, "hello", 5]); // 1
         * Strings.indexOfAny("Five = 5", [2, "hello", 5]); // 2
         * Strings.indexOfAny("actionscript is good", [2, "hello", 5]); // -1
         * </pre>
         * @return the index of the first occurrence in this instance of any character in a specified array of Unicode characters.
         */
        public static function indexOfAny( str:String, anyOf:Array, startIndex:int = 0, count:int = -1 ):int
            {
            var i:int;
            var endIndex:int;
            
            if( (str == null) || (str == "") )
                {
                return -1;
                }
            
            if( startIndex < 0 )
                {
                startIndex = 0;
                }
            
            if( (count < 0) || (count > anyOf.length - startIndex) )
                {
                endIndex = anyOf.length - 1;
                }
            else
                {
                endIndex = startIndex + count - 1;
                }
            
            for( i = startIndex; i <= endIndex ; i++ )
                {
                if( str.indexOf( anyOf[i] ) > -1 )
                    {
                    return i;
                    }
                }
            
            return -1;
            }

        /**
         * Inserts a specified instance of String at a specified index position in this instance.
         * note :
         * if index is null, we directly append the value to the end of the string.
         * if index is zero, we directly insert it to the begining of the string.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings;
         * 
         * var result:String;
         * 
         * result = Strings.insert("hello", 0, "a" );  // ahello
         * trace(result) ;
         * 
         * result = Strings.insert("hello", -1, "a" ); // hellao
         * trace(result) ;
         * 
         * result = Strings.insert("hello", 10, "a" ); // helloa
         * trace(result) ;
         * 
         * result = Strings.insert("hello", 1, "a" );  // haello
         * trace(result) ;
         * </pre>
         * @return the string modified by the method.
         */
        public static function insert( str:String, startIndex:int, value:String ):String
            {
            var strA:String = "";
            var strB:String = "";
            
            if( startIndex == 0 )
                {
                return value + str;
                }
            else if( startIndex == str.length )
                {
                return str + value;
                }
            
            /* TODO:
               review the logic when startIndex == -1
            */
            strA = str.substr( 0, startIndex );
            strB = str.substr( startIndex );
            
            return strA + value + strB;
            }

        /**
         * Reports the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint"> 
         * trace( Strings.lastIndexOfAny("hello world", ["2", "hello", "5"]) ); // 0
         * trace( Strings.lastIndexOfAny("Five 5 = 5 and not 2" , ["2", "hello", "5"]) ); // 19
         * trace( Strings.lastIndexOfAny("Five 5 = 5 and not 2" , ["5", "hello", "2"]) ); // 9
         * trace( Strings.lastIndexOfAny("Five 5 = 5 and not 2" , ["5", "hello", "2"] , 8) ); // 5
         * trace( Strings.lastIndexOfAny("Five 5 = 5 and not 2" , ["5", "hello", "2"] , 8 , 3) ); // -1
         * </pre> 
         * @param str The String to ckeck.
         * @param anyOf The Array of Unicode characters to find in the String.
         * @param startIndex The init position of the search process.
         * @param count The number of elements to check.
         * @return the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
         * @throws ArgumentError if the anyOf argument is 'null' or 'undefined'.
         */
        public static function lastIndexOfAny( str:String, anyOf:Array, startIndex:int = 0x7FFFFFFF, count:int = 0x7FFFFFFF ):int 
            {
            var i:int;
            var index:int ;
            
            if ( anyOf == null )
                {
                throw new ArgumentError( "Strings.lastIndexOfAny failed with an empty 'anyOf' Array.") ;
                }
            
            if( str == null || str.length == 0 )
                {
                return -1;
                }
            
            if ( isNaN(count) || count < 0 )
                {
                count = 0x7FFFFFFF ;    
                }
            
            if ( isNaN(startIndex) || startIndex > str.length )
                {
                startIndex = str.length ;
                }
            else if( startIndex < 0 )
                {
                return -1 ;
                }
            
            var endIndex:int = startIndex - count + 1 ;
            
            if ( endIndex < 0 )
                {
                endIndex = 0 ;    
                }
            
            str = str.slice( endIndex , startIndex+1 ) ;
            
            var len:uint = anyOf.length ;
            for ( i = 0 ; i < len ; i ++ )
                {
                index = str.lastIndexOf( anyOf[i] , startIndex ) ;
                if (index > -1) 
                    {
                    return index + endIndex;
                    }
                }
            
            return -1 ;
            }    

        /**
         * Right-aligns the characters in this instance, padding on the left with a specified Unicode character for a specified total length.
         * <pre class="prettyprint">
         * import system.Strings;
         * 
         * var result:String;
         * 
         * result = Strings.padLeft("hello", 8);
         * trace(result); //  "   hello"
         * 
         * result = Strings.padLeft("hello", 8, ".") ;
         * trace(result); //  "...hello" 
         * </pre>
         * @return The right-aligns the characters in this instance, padding on the left with a specified Unicode character for a specified total length.
         */
        public static function padLeft( str:String, totalWidth:int, paddingChar:String = " " ):String
            {
            var isRightPadded:Boolean = false;
            
            if( totalWidth < 0 )
                {
                totalWidth    = -totalWidth;
                isRightPadded = true;
                }
            
            return _padHelper( str, totalWidth, paddingChar, isRightPadded );
            }

        /**
         * Left-aligns the characters in this string, padding on the right with a specified Unicode character, for a specified total length.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * var result:String ;
         * 
         * result = Strings.padRight("hello", 8) ;
         * trace(result) ; //  "hello   "
         * 
         * result = Strings.padRight("hello", 8, ".") ;
         * trace(result) ; //  "hello..." 
         * </pre>
         * @return The left-aligns the characters in this string, padding on the right with a specified Unicode character, for a specified total length.
         */
        public static function padRight( str:String, totalWidth:int, paddingChar:String = " " ):String
            {
            var isRightPadded:Boolean = true;
            
            if( totalWidth < 0 )
                {
                totalWidth    = -totalWidth;
                isRightPadded = false;
                }
            
            return _padHelper( str, totalWidth, paddingChar, isRightPadded );
            }

        /**
         * Returns a new String value who contains the specified String characters repeated count times.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * trace( Strings.repeat("hello", 0) ) ; // hello
         * trace( Strings.repeat("hello", 3) ) ; // hellohellohello
         * </pre>
         * @return a new String value who contains the specified String characters repeated count times.
         */
        public static function repeat( str:String="" , count:uint=0 ):String
        {
            var result:String = "" ;
            if ( count > 0 )
            {
                for( var i:uint = 0 ; i<count ; i++)
                {
                    result = result.concat(str) ;
                }
            }
            else
            {
                result = str ;    
            }
            return  result ;
        }

        /**
         * Determines whether a specified string is a prefix of the current instance. 
         * <p><b>Example : </b></p>
         * <pre class="prettyprint">
         * import system.Strings ;
         * 
         * trace( Strings.startsWith("hello world", "h") ) ; // true
         * trace( Strings.startsWith("hello world", "hello") ) ; // true
         * trace( Strings.startsWith("hello world", "a") ) ; // false
         * </pre>
         * @return <code class="prettyprint">true</code> if the specified string is a prefix of the current instance.
         */
        public static function startsWith( str:String, value:String ):Boolean
            {
            //special case
            if( (value == "") && (str != null) )
                {
                return true;
                }
            
            if( (str == "") || (str == null) || (value == null) || (str.length < value.length) )
                {
                return false;
                }
            
            //shortcut
            if( str.charAt( 0 ) != value.charAt( 0 ) )
                {
                return false;
                }
            
            return compare( str.substr( 0, value.length ), value ) == 0;
            }

        /**
         * Removes all occurrences of a set of specified characters (or strings) from the beginning and end of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace( Strings.trim("\r\t   hello world   \t ") ); // hello world
         * </pre>
         * @param str The string to trim.
         * @param trimChars The optional array of characters to trim. If this argument is null the <code class="prettyprint">Strings.whiteSpaceChars</code> static array is used.
         * @return The new trimed string.
         */
        public static function trim( str:String, trimChars:Array = null ):String
            {
            if( trimChars == null )
                {
                trimChars = whiteSpaceChars;
                }
            
            return _trimHelper( str, trimChars, true, true );
            }

        /**
         * Removes all occurrences of a set of characters specified in an array from the end of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace( Strings.trimEnd("---hello world---" , Strings.whiteSpaceChars.concat("-") ) ); // ---hello world
         * </pre>
         * @param str The string to trim.
         * @param trimChars The optional array of characters to trim. If this argument is null the <code class="prettyprint">Strings.whiteSpaceChars</code> static array is used.
         * @return The new trimed string.
         */
        public static function trimEnd( str:String, trimChars:Array = null ):String
            {
            if( trimChars == null )
                {
                trimChars = whiteSpaceChars;
                }
            
            return _trimHelper( str, trimChars, false, true );
            }

        /**
         * Removes all occurrences of a set of characters specified in an array from the beginning of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace( Strings.trimStart("---hello world---" , Strings.whiteSpaceChars.concat("-") ) ); // hello world---
         * </pre>
         * @param str The string to trim.
         * @param trimChars The optional array of characters to trim. If this argument is null the <code class="prettyprint">Strings.whiteSpaceChars</code> static array is used.
         * @return The new trimed string.
         */
        public static function trimStart( str:String, trimChars:Array = null ):String
            {
            if( trimChars == null )
                {
                trimChars = whiteSpaceChars;
                }
            
            return _trimHelper( str, trimChars, true, false );
            }

        // TODO We maybe could also define 0xFFEF and/or 0x2060, but not completely sure of all the implication, 
        // 0xFFEF in byte order mark etc.
        
        /**
         * Contains a read-only list of white space chars.
         * <p><b>Note :</b></p>
         * <ul>
         * <li>http://developer.mozilla.org/es4/proposals/string.html</li>
         * <li>http://www.fileformat.info/info/unicode/category/Zs/list.htm</li>
         * <li>http://www.fileformat.info/info/unicode/category/Zl/list.htm</li>
         * <li>http://www.fileformat.info/info/unicode/category/Zp/list.htm</li>
         * <li>http://www.fileformat.info/info/unicode/char/200b/index.htm</li>
         * <li>http://www.fileformat.info/info/unicode/char/feff/index.htm</li>
         * <li>http://www.fileformat.info/info/unicode/char/2060/index.htm</li>
         * </ul>
         */
        public static const whiteSpaceChars:Array = [ "\u0009" /*Horizontal tab*/,
                                                      "\u000A" /*Line feed or New line*/,
                                                      "\u000B" /*Vertical tab*/,
                                                      "\u000C" /*Formfeed*/,
                                                      "\u000D" /*Carriage return*/,
                                                      "\u0020" /*Space*/,
                                                      "\u00A0" /*Non-breaking space*/,
                                                      "\u1680" /*Ogham space mark*/,
                                                      "\u180E" /*Mongolian vowel separator*/,
                                                      "\u2000" /*En quad*/,
                                                      "\u2001" /*Em quad*/,
                                                      "\u2002" /*En space*/,
                                                      "\u2003" /*Em space*/,
                                                      "\u2004" /*Three-per-em space*/,
                                                      "\u2005" /*Four-per-em space*/,
                                                      "\u2006" /*Six-per-em space*/,
                                                      "\u2007" /*Figure space*/,
                                                      "\u2008" /*Punctuation space*/,
                                                      "\u2009" /*Thin space*/,
                                                      "\u200A" /*Hair space*/,
                                                      "\u200B" /*Zero width space*/,
                                                      "\u2028" /*Line separator*/,
                                                      "\u2029" /*Paragraph separator*/,
                                                      "\u202F" /*Narrow no-break space*/,
                                                      "\u205F" /*Medium mathematical space*/,
                                                      "\u3000" /*Ideographic space*/ ];
        }
    }

