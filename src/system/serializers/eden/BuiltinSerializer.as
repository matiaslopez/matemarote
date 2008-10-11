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
    import system.Environment;
    import system.Arrays;
    import system.eden;
    
	/**
	 * The BuiltinSerializer class.
	 */    
    public class BuiltinSerializer
        {
        
		/**
		 * Returns the serialized string representation of the specified array argument.
		 * @return the serialized string representation of the specified array argument.
		 */
        public static function emitArray( value:Array ):String
            {
            var source:Array = [];
			var size:uint    = value.length ;                
            for( var i:int = 0 ; i < size ; i++ )
                {
                
                if( value[i] === undefined )
                    {
                    source.push( "undefined" );
                    continue;
                    }
                
                if( value[i] === null )
                    {
                    source.push( "null" );
                    continue;
                    }
                
                eden.prettyIndent++;
                source.push( eden.serialize( value[i] ) );
                eden.prettyIndent--;
                }
            
            if( !eden.prettyPrinting )
                {
                return( "[" + source.join( "," ) + "]" );
                }
            
            var decal:String = Environment.newLine + Arrays.initialize( eden.prettyIndent, eden.indentor ).join( "" );
            return decal + "[" + decal + source.join( "," + decal ) + decal + "]";
            }        
        
		/**
		 * Returns the serialized string representation of the specified date argument.
		 * @return the serialized string representation of the specified date argument.
		 */
        public static function emitDate( value:Date ):String
            {
            var data:Array;
            
            var y:Number   = value.getFullYear();
            var m:Number   = value.getMonth();
            var d:Number   = value.getDate();
            var h:Number   = value.getHours();
            var mn:Number  = value.getMinutes();
            var s:Number   = value.getSeconds();
            var ms:Number  = value.getMilliseconds();
            
            data = [ y, m, d, h, mn, s, ms ];
            data.reverse();
            
            while( data[0] == 0 )
                {
                data.splice( 0, 1 );
                }
            
            data.reverse();
            
            return "new Date(" + data.join( "," ) + ")";
            }
        
		/**
		 * Returns the serialized string representation of the specified object argument.
		 * @return the serialized string representation of the specified string argument.
		 */
        public static function emitObject( value:Object ):String
            {
            var source:Array = [];
            
            for( var member:String in value )
                {
                if( value.hasOwnProperty( member ) )
                    {
                    if( value[member] === undefined )
                        {
                        source.push( member + ":" + "undefined" );
                        continue;
                        }
                    
                    if( value[member] === null )
                        {
                        source.push( member + ":" + "null" );
                        continue;
                        }
                    
                    eden.prettyIndent++;
                    source.push( member + ":" + eden.serialize( value[member] ) );
                    eden.prettyIndent--;
                    }
                }
            
            if( !eden.prettyPrinting )
                {
                return( "{" + source.join( "," ) + "}" );
                }
            
            var decal:String = Environment.newLine + Arrays.initialize( eden.prettyIndent, eden.indentor ).join( "" );
            return decal + "{" + decal + source.join( "," + decal ) + decal + "}";
            }
            
		/**
		 * Returns the serialized string representation of the specified array argument.
		 * @return the serialized string representation of the specified array argument.
		 */        
        public static function emitString( value:String ):String
            {
            var quote:String = "\"";
            var str:String   = "";
            var ch:String    = "";
            var pos:int      = 0;
            var code:int;
            
            var _toUnicodeNotation:Function = function( num:int ):String
                {
                var hex:String = num.toString( 16 );
                while( hex.length < 4 )
                    {
                    hex = "0"+hex;
                    }
                return hex;
                };
            
            while( pos < value.length )
                {
                ch   = value.charAt( pos );
                code = value.charCodeAt( pos );
                
                if( code > 0xFF )
                    {
                    str += "\\u" + _toUnicodeNotation( code );
                    pos++;
                    continue;
                    }
                
                switch( ch )
                    {
                    case "\u0008": //backspace
                    str += "\\b";
                    break;
                    
                    case "\u0009": //horizontal tab
                    str += "\\t";
                    break;
                    
                    case "\u000A": //line feed
                    str += "\\n";
                    break;
                    
                    case "\u000B": //vertical tab
                    str += "\\v";
                    /* TODO: check the VT bug */
                    //str += "\\u000B";
                    break;
                    
                    case "\u000C": //form feed
                    str += "\\f";
                    break;
                    
                    case "\u000D": //carriage return
                    str += "\\r";
                    break;
                    
                    case "\u0022": //double quote
                    str += "\\\"";
                    break;
                    
                    case "\u0027": //single quote
                    str += "\\\'";
                    break;
                    
                    case "\u005c": //backslash
                    str += "\\\\";
                    break;
                    
                    default:
                    str += ch;
                    }
                
                pos++;
                }
            
            return quote + str + quote;
            }
    
        }
    }
