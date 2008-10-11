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
  - Marc Alcaraz <ekameleon@gmail.com>
*/

package system.evaluators
    {
    import system.Strings;    

    /**
     * Evaluates mathematical string expressions.
     * <p><b>The MathEvaluator implementation</b>, support all of the following :</p>
     * <p><b>Decimal, hexadecimal, octal notation :</b></p>
     * <pre class="prettyprint">
     * 1 + 1
     * 0.5 + 0.7
     * 0xff + 0xbb
     * 010 + 5
     * etc.
     * </pre>
     * <p>operators : </p>
     * <pre class="prettyprint">
     * % / &#8727; + - << >> >>> & ^ | ~
     * </pre>
     * <p>functions :</p>
     * <pre class="prettyprint">
     * abs acos asin atan atan2 ceil cos exp
     * floor log max min pow random round
     * sin sqrt tan 
     * </pre>
     * Those functions replicate exactly what you can find in the Math object.
     * <p>operators priority : from higher to lower priority</p>
     * <p><b>Example :</b> multiplication is performed before addition</p>
     * <pre class="prettyprint">
     * (14) fcn(...) (...)
     * </pre>
     * <p>function call and expression grouping</p>
     * <p><b>example :</b> <code class="prettyprint">sin(4) + 25</code></p>
     * <p>sin(4) will be evaluated first</p>
     * <p><b>example :</b> <code class="prettyprint">5 &#8727; (4 + 0.5)</code></p>
     * <p>the expression within the parenthesis will occurs first</p>
     * <pre class="prettyprint">
     * (13) ~ + - 
     * </pre>
     * <p>unary operators</p>
     * <p>ex: <code class="prettyprint">+5 - +5</code> translate to <code class="prettyprint">(+5) - (+5)</code></p>
     * <p>ex: <code class="prettyprint">-5 + -5</code> translate to <code class="prettyprint">(-5) + (-5)</code></p>
     * <p>ex: <code class="prettyprint">~3 - 7</code>  translate to <code class="prettyprint">(~3) - 7</code></p>
     * <p>any unary operators will be evaluated first</p>
     * <pre class="prettyprint">
     * (12) &#8727; / %
     * </pre>
     * <p><b>multiplication, division, modulo division</p></b>
     * <p>ex: 5 &#8727; 3 + 1 translate to (5 &#8727; 3) + 1</p>
     * <p>ex: 2 % 8 - 4 translate to (2 % 8) - 4</p>
     * <pre class="prettyprint">
     * (11) + -
     * </pre>
     * <p><b>addition, subtraction</b></p>
     * <pre class="prettyprint">
     * (10) << >> <<<
     * </pre>
     * <p><b>bit shifting</b></p>
     * <pre class="prettyprint">
     * (7)  &
     * </pre>
     * <p><b>bitwise AND</b></p>
     * <pre class="prettyprint">
     * (6)  ^
     * </pre>
     * <p><b>bitwise XOR</b></p>
     * <pre class="prettyprint">
     * (5)  |
     * </pre>
     * <p><b> bitwise OR</b></p>
     * <p>context</p>
     * <p>When instanciating the MathEvaluator you can pass a context containing either variables or functions</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * var me:MathEvaluator = new MathEvaluator( {x:100, test:function(a:Number):Number {return a*a;} );
     * trace( me.eval( "test(100) + 1" ) ); //return 10001
     * </pre>
     * <p>but there are some limitations</p>
     * <li>your variable or function name must me lowercase</li>
     * <li>your variable or function name must contains only letter from a to z and can end with only one digit</li>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * test()  //OK
     * test2() //OK
     * 2test() //BAD
     * te2st() //BAD
     * etc.
     * </pre>
     * <li>your function can only have one argument<\li>
     * <li>your function name can not override default math functions as cos, sin, etc.<\li>
     * <p>we do not support logical ( || && !) or assignement operators (= == += etc.)</p>
     * <p><b>reasons:</b></p>
     * <p>logical operators deal with boolean, here we want to deal only with numbers and math expression we do not support variables nor variable assignation</p>
     * <p>Parenthesis are used to alter the order of evaluation determined by operator precedence.</p>
     * <p>Operators with the same priority are evaluated left to right.</p>
     * <p><b>How the parser work :</b></p>
     * <p><b>1)</b> we first filter some multiple char operators to single chars</p>
     * <p><b>ex:</b> << translate to « and other filtering</p>
     * <p><b>2)</b> then we parse char by char (top to bottom parsing) to generate tokens in postfix order(reverse polish notation)</p>
     * <p>the expression 5 + 4 become <code class="prettyprint">[5,4,+]</code> but while doing that we also do a lot of other things</p>
     * <li>evaluate function call</li>
     * <li>remove space chars</li>
     * <li>re-order tokens by operators priority</li>
     * <li>evaluate  hexadecimal notation to decimal</li>
     * <li>etc.</li>
     * <p>3) finally we iterate trough our tokens and evaluate them by operators</p>
     * <p><b>ex:</b> [5,4,+]</p>
     * <p>we find the op +, then addition the 2 values, etc.</p>
     * <p>till the end of the tokens list</p>
     * </p>
     */
    public class MathEvaluator implements Evaluable
        {
        	
        use namespace mathparser;
        
        /**
         * Creates a new MathsEvaluator instance.
         * @param context When instanciating the MathEvaluator you can pass a context containing either variables or functions.
         */
        public function MathEvaluator( context:Object = null )
            {
            if( context != null )
                {
                _context = context;
                }
            }
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
            {
            return parse( o );
            }
                
        /**
         * @private
         */
        private namespace mathparser;
        
        /**
         * @private
         */
        private var _context:Object = {};
        
        /**
         * The max hexadecimal value.
         */
        mathparser const maxHexValue:Number = 0xFFFFFF;
        
        /**
         * The expression value.
         */
        mathparser var expression:String;
        
        /**
         * The current position.
         */
        mathparser var currentPos:uint;
        
        /**
         * The Array representation of the tokens of this evaluator.
         */
        mathparser var tokens:Array;
        
        /**
         * Adds the specified value to the last token.
         */
        mathparser function addToLastToken( value:String ):void
            {
            tokens[ tokens.length-1 ] += value;
            }          
        
        /**
         * Adds the specified value to the next token.
         */
        mathparser function addToNextToken( value:String ):void
            {
            tokens.push( value );
            }
                
        /**
         * Indicates if the passed-in value is a alpha character.
         */
        mathparser function isAlpha( c:String ):Boolean
            {
            return (("A" <= c) && (c <= "Z")) || (("a" <= c) && (c <= "z"));
            }        
        
        /**
         * Indicates if the passed-in string value is a digit.
         */
        mathparser function isDigit( c:String ):Boolean
            {
            return ("0" <= c) && (c <= "9");
            }

        /**
         * Indicates if the passed-in string value is a hexadecimal digit.
         */
        mathparser function isHexDigit( c:String ):Boolean
            {
            return isDigit( c ) || (("A" <= c) && (c <= "F")) || (("a" <= c) && (c <= "f"));
            }
        
        /**
         * Indicates if the passed-in string value is a octal digit.
         */
        mathparser function isOctalDigit( c:String ):Boolean
            {
            return ("0" <= c) && (c <= "7");
            }
       
        /**
         * Indicates if the passed-in string value is a operator digit.
         */
        mathparser function isOperator( c:String ):Boolean
            {
            switch( c )
                {
                case "*": case "/": case "%":
                case "+": case "-":
                case "«": case "»": case "›":
                case "&": case "^": case "|":
                return true;
                
                default:
                return false;
                }
            }
        
        /**
         * Indicates if has more char.
         */
        mathparser function hasMoreChar():Boolean
            {
            return currentPos < expression.length;
            }
        
        /**
         * Returns the char with the specified position.
         * @return the char with the specified position.
         */
        mathparser function getChar( pos:int = -1 ):String
            {
            if( pos < 0 )
                {
                pos = currentPos;
                }
            
            return expression.charAt( pos );
            }
        
        /**
         * Returns the next char.
         * @return the next char.
         */
        mathparser function getNextChar():String
            {
            currentPos++;
            return getChar();
            }

        /**
         * Returns the last token string.
         * @return the last token string.
         */
        mathparser function getLastToken():String
            {
            return tokens[ tokens.length-1 ];
            }
        
        /**
         * Returns the value of the specified numeric expression.
         * @return the value of the specified numeric expression.
         */
        mathparser function getValue( num:String ):Number
            {
            var ch0:String;
            var ch1:String;
            var isBitNot:Boolean = false;
            var isNeg:String     = "";
            
            if( num.charAt(0) == "~" )
                {
                num      = num.substr(1);
                isBitNot = true;
                }
            
            if( num.charAt(0) == "-" )
                {
                num   = num.substr(1);
                isNeg = "-";
                }
            
            ch0 = num.charAt(0);
            ch1 = num.charAt(1);
            
            if( (ch0 == "0") && num.length > 1 )
                {
                if( isOctalDigit( ch1 ) && (num.indexOf(".") == -1) && (num.indexOf("e") == -1) )
                    {
                    if( isBitNot )
                        {
                        return ~parseInt( isNeg + num );
                        }
                    else
                        {
                        return parseInt( isNeg + num );
                        }
                    }
                }
            
            if( isBitNot )
                {
                return ~Number( isNeg + num );
                }
            else
                {
                return Number( isNeg + num );
                }
            
            }
        
        /**
         * Returns The string function value representation.
         * @param name The name of the function.
         * @param expressions The arguments as math expression.
         * @return The result string of the evaluated function.
         */
        mathparser function getFunctionValue( name:String, expressions:Array ):String
            {
            var args:Array = [];
            var me:MathEvaluator = new MathEvaluator( _context );
            
            for( var i:uint = 0; i<expressions.length; i++ )
                {
                if( expressions[i] != "" )
                    {
                    args.push( me.eval( expressions[i] ) );
                    }
                }
            
            switch( name )
                {
                case "abs":
                return String( Math.abs( args[0] ) );
                break;
                
                case "acos":
                return String( Math.acos( args[0] ) );
                break;
                
                case "asin":
                return String( Math.asin( args[0] ) );
                break;
                
                case "atan":
                return String( Math.atan( args[0] ) );
                break;
                
                case "atan2": //2
                return String( Math.atan2( args[0], args[1] ) );
                break;
                
                case "ceil":
                return String( Math.ceil( args[0] ) );
                break;
                
                case "cos":
                return String( Math.cos( args[0] ) );
                break;
                
                case "exp":
                return String( Math.exp( args[0] ) );
                break;
                
                case "floor":
                return String( Math.floor( args[0] ) );
                break;
                
                case "log":
                return String( Math.log( args[0] ) );
                break;
                
                case "max": //2
                return String( Math.max( args[0], args[1] ) );
                break;
                
                case "min": //2
                return String( Math.min( args[0], args[1] ) );
                break;
                
                case "pow": //2
                return String( Math.pow( args[0], args[1] ) );
                break;
                
                case "random": //0
                return String( Math.random() );
                break;
                
                case "round":
                return String( Math.round( args[0] ) );
                break;
                
                case "sin":
                return String( Math.sin( args[0] ) );
                break;
                
                case "sqrt":
                return String( Math.sqrt( args[0] ) );
                break;
                
                case "tan":
                return String( Math.tan( args[0] ) );
                break;
                
                default:
                if( _context[ name ] )
                    {
                    return _context[ name ]( args[0] );
                    }
                }
            
            return "";
            }
        
        /**
         * Returns the variable value with the internal context of the evaluator.
         * @return the variable value with the internal context of the evaluator.
         */
        mathparser function getVariableValue( name:String ):String
            {
            if( _context[ name ] )
                {
                return _context[ name ];
                }
            
            return "";
            }
        
        /**
         * Filters and returns special char passed-in argument.
         * @return special char passed-in argument.
         */
        mathparser function filterSpecialChars( expression:String ):String
            {
            /* note:
               for case 1E5, SIN(4), 0Xff, etc.
            */
            expression = expression.toLowerCase();
            
            /* note:
               optimize multi char to single char
            */
            expression = expression.split( "<<" ).join( "«" );
            expression = expression.split( ">>>" ).join( "›" );
            expression = expression.split( ">>" ).join( "»" );
            
            /* note:
               for case +5 - +5 -> +5 - 5
            */
            expression = expression.split( "- +" ).join( "- " );
            
            /* note:
               for case +-5 * -+10 -> -5 * -10 
            */
            expression = expression.split( "+-" ).join( "-" );
            expression = expression.split( "-+" ).join( "-" );
            
            return expression;
            }
        
        /**
         * Returns the array representation of all elements in a parenthesis block.
         * @return the array representation of all elements in a parenthesis block.
         */
        mathparser function getParenthesisBlock():Array
            {
            var startNode:uint = 0;
            var endNode:uint   = 0;
            
            var expressions:Array = ["",""];
            var num:uint  = 0;
            var ch:String = "";
            
            for( ;; )
                {
                ch = getNextChar();
                
                switch( ch )
                    {
                    case "(":
                    startNode++;
                    expressions[num] += ch;
                    break;
                    
                    case ")":
                    endNode++;
                    expressions[num] += ch;
                    break;
                    
                    case ",":
                    num++;
                    break;
                    
                    default:
                    expressions[num] += ch;
                    }
                
                if( startNode == endNode )
                    {
                    break;
                    }
                
                }
            
            currentPos++;
            expressions[0] = expressions[0].substr( 1 ); //remove the first (
            expressions[num] = expressions[num].substr( 0, expressions[num].length-1 ); //remove the last ) 
            return expressions;
            }
        
        /**
         * Returns the operator priority value.
         * @return the operator priority value.
         */
        mathparser function getOperatorPriority( op:String ):uint
            {
            /* note:
               function call and expression grouping priorities
               and unary priorities
               are dealt inside toPostfixNotation().
            */
            switch( op )
                {
                case "*":
                case "/":
                case "%":
                return 12;
                
                case "+":
                case "-":
                return 11;
                
                case "«": // <<
                case "»": // >>
                case "›": // >>>
                return 10;
                
                case "&": //bitwise AND
                return 7;
                
                case "^": //bitwise XOR
                return 6;
                
                case "|": //bitwise OR
                return 5;
                
                default:
                return 0;
                }
            }
        
        /**
         * The toPostfixNotation method.
         */
        mathparser function toPostfixNotation():void
            {
            var ch:String;
            var ch2:String;
            var bitNot:String;
            var neg:String;
            var opr:String;
            var hex:String;
            var dot:Boolean;
            var exp:Boolean;
            var digit:String;
            
            var stack:Array = [];
            
            while( hasMoreChar() )
                {
                ch = getChar();
                
                bitNot = "";
                neg    = "";
                
                switch( ch )
                    {
                    case " ":
                    case "\t":
                    case "\r":
                    case "\n":
                    currentPos++;
                    break;
                    
                    case "(":
                    stack.push( ch );
                    currentPos++;
                    break;
                    
                    case ")":
                    opr = stack.pop();
                    
                    while( opr != "(" )
                        {
                        addToNextToken( opr );
                        opr = stack.pop();
                        }
                    
                    currentPos++;
                    break;
                    
                    case "*": case "/": case "%":
                    case "+": case "-":
                    case "«": case "»": case "›": // << >> >>>
                    case "&": case "^": case "|":
                    if( stack.length != 0 )
                        {
                        opr = stack.pop();
                        
                        while( getOperatorPriority( opr ) >= getOperatorPriority( ch ) )
                            {
                            addToNextToken( opr );
                            opr = stack.pop();
                            }
                        
                        stack.push( opr );
                        stack.push( ch );
                        addToNextToken( "" );
                        }
                    else
                        {
                        stack.push( ch );
                        addToNextToken( "" );
                        }
                    
                    currentPos++;
                    break;
                    
                    case "0": case "1": case "2": case "3": case "4":
                    case "5": case "6": case "7": case "8": case "9":
                    case "~":
                    if( tokens.length == 0 )
                        {
                        addToNextToken( "" );
                        }          
                    
                    /* note:
                       unary priorities
                    */
                    if( ch == "~" )
                        {
                        bitNot = "~";
                        ch = getNextChar();
                        }
                    
                    if( ch == "+" )
                        {
                        ch = getNextChar();
                        }
                    
                    if( ch == "-" )
                        {
                        neg = "-";
                        ch  = getNextChar();
                        }
                    
                    if( ch == "0" )
                        {
                        while( ch == "0" )
                            {
                            ch = getNextChar();
                            }
                        
                        currentPos--;
                        ch = getChar();
                        }
                    
                    ch2 = getChar( currentPos + 1 );
                    
                    if( (ch == "0") && (ch2 == "x") )
                        {
                        hex         = "";
                        currentPos += 2;
                        ch          = getChar();
                        
                        while( isHexDigit( ch ) )
                            {
                            hex += ch;
                            ch   = getNextChar();
                            }
                        
                        if( hex.length > maxHexValue )
                            {
                            hex = hex.substr( 0, maxHexValue );
                            }
                        
                        if( hex == "" )
                            {
                            hex = "0";
                            }
                        
                        addToLastToken( bitNot + neg + "0x" + hex );
                        }
                    else
                        {
                        dot   = false;
                        exp   = false;
                        digit = "";
                        
                        while( isDigit( ch ) || (ch == ".") || (ch == "e") )
                            {
                            if( ch == "e" )
                                {
                                if( exp )
                                    {
                                    ch = getNextChar();
                                    continue;
                                    }
                                
                                exp    = true;
                                digit += ch;
                                ch     = getNextChar();
                                
                                if( (ch == "+") || (ch == "-") )
                                    {
                                    digit += ch;
                                    ch     = getNextChar();
                                    }
                                
                                continue;
                                }
                            
                            if( ch == "." )
                                {
                                if( dot )
                                    {
                                    ch = getNextChar();
                                    continue;
                                    }
                                
                                dot = true;
                                }
                            
                            digit += ch;
                            ch     = getNextChar();
                            }
                        
                        addToLastToken( bitNot + neg + digit );
                        }
                    
                    break;
                    
                    case "a": //abs, acos, asin, atan, atan2
                    case "b":
                    case "c": //ceil, cos
                    case "d":
                    case "e": //exp
                    case "f": //floor
                    case "g":
                    case "h":
                    case "i":
                    case "j":
                    case "k":
                    case "l": //log
                    case "m": //max, min
                    case "n":
                    case "o":
                    case "p": //pow
                    case "q":
                    case "r": //random, round
                    case "s": //sin, sqrt
                    case "t": //tan
                    case "u":
                    case "v":
                    case "w":
                    case "x":
                    case "y":
                    case "z":
                    
                    var name:String = ch;
                    
                    while( isAlpha( ch ) )
                        {
                        ch = getNextChar();
                        if( isAlpha( ch ) || isDigit( ch ) )
                            {
                            name += ch;
                            }
                        else
                            {
                            currentPos--;
                            }
                        }
                    
                    if( tokens.length == 0 )
                        {
                        addToNextToken( "" );
                        }
                    
                    var peek:String = getChar( currentPos + 1 );
                    
                    if( Strings.endsWith( peek, "(" ) )
                        {
                        addToLastToken( getFunctionValue( name , getParenthesisBlock() ) );
                        }
                    else
                        {
                        addToLastToken( getVariableValue( name ) );
                        currentPos++;
                        }
                    
                    break;
                    
                    
                    default:
                    /* note: by default we ignore anyother chars */
                    currentPos++;
                    }
                
                }
            
            while( stack.length != 0 )
                {
                opr = stack.pop();
                
                if( opr != "" )
                    {
                    addToNextToken( opr );
                    }
                }
            
            if( (getLastToken() == "") || (getLastToken() == null) )
                {
                tokens.pop();
                }
            
            if( tokens.length%2 == 0 )
                {
                tokens.unshift( "0" );
                }
            
            //trace( "RPN: ["+this.tokens+"]" );
            }
        
        /**
         * Launchs the evaluation process.
         */
        mathparser function evaluate():Number
            {
            var op:String;
            var value:*;
            var valueA:*;
            var valueB:*;
            
            for( var i:uint = 0; i < tokens.length; i++ )
                {
                op    = tokens[i];
                value = null;
                
                if( isOperator( op ) )
                    {
                    valueA = getValue( tokens[ i-2 ] );
                    valueB = getValue( tokens[ i-1 ] );
                    
                    switch( op )
                        {
                        case "+":
                        value = valueA + valueB;
                        break;
                        
                        case "-":
                        value = valueA - valueB;
                        break;
                        
                        case "*":
                        value = valueA * valueB;
                        break;
                        
                        case "/":
                        value = valueA / valueB;
                        break;
                        
                        case "%":
                        value = valueA % valueB;
                        break;
                        
                        case "^":
                        value = valueA ^ valueB;
                        break;
                        
                        case "&":
                        value = valueA & valueB;
                        break;
                        
                        case "|":
                        value = valueA | valueB;
                        break;
                        
                        case "«": // <<
                        value = valueA << valueB;
                        break;
                        
                        case "»": // >>
                        value = valueA >> valueB;
                        break;
                        
                        case "›": // >>>
                        value = valueA >>> valueB;
                        break;
                        
                        default:
                        /* NOTE: this CANNOT happen */
                        trace( "## ERROR : unsupported operator \"" + op + "\" ##" );
                        }
                    }
                
                if( value != null )
                    {
                    tokens.splice( i-2, 3, value );
                    return evaluate();
                    }
                }
            
            if( tokens.length > 1 )
                {
                return evaluate();
                }
            else
                {
                return getValue( tokens[0] );
                }
            }
        
        /**
         * Parses the specified expression.
         */
        mathparser function parse( expression:String ):Number
            {
            reset();
            this.expression = filterSpecialChars( expression );
            toPostfixNotation();
            return evaluate();
            }
        
        /**
         * Resets the evaluator.
         */
        mathparser function reset():void
            {
            expression = "";
            currentPos =  0;
            tokens     = [];
            }
        
        }    

    }

