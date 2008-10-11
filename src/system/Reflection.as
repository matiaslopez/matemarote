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
  Marc Alcaraz <ekameleon@gmail.com>.

*/
    
package system
{
    import flash.system.ApplicationDomain;
    import flash.utils.*;
    
    import system.reflection.*;    

    /* 
           TODO:
           - add options to return
             - class methods
             - static methods
             - prototype methods
             etc.
     */

    /**
	 * Provides a basic reflection mecanisms on the language.
	 */
    public class Reflection
        {
        	
		/**
		 * @private
		 */
		private static function _formatName( path:String ):String 
			{
			var a:Array = path.split( "." ) ;
			return (a.length > 1) ? a.pop( ) : path ;
			}
        
		/**
		 * @private
		 */
		private static function _formatPackage( path:String ):String 
			{
			var a:Array = path.split( "." ) ;
			if (a.length > 1) 
				{
				a.pop() ;
				return a.join( "." ) ;
				}
			else 
				{
				return null ;
				}
			}
        
		/**
		 * @private
		 */
		private static function _formatPath( path:String ):String 
			{
			return (path.split( "::" )).join( "." ) ;
			}        	
        
		/**
		 * Returns the class reference from a string class name.
		 * The string name notation can be either "flash.system::Capabilities" or "flash.system.Capabilities" 
		 * but you have to provide the full qualified path of the class "Capabilities" alone will not work.
		 * @return the class reference from a string class name.
		 */
        public static function getClassByName( name:String ):Class
            {
            return ApplicationDomain.currentDomain.getDefinition( name ) as Class;
            }
        
        /**
         * Returns the ClassInfo object of the specified object.
         * @return the ClassInfo object of the specified object.
         */
        public static function getClassInfo( o:*, ...filters ):ClassInfo
            {
            var filter:FilterType = FilterType.none; //default
            var value:int  = 0;
            var len:int    = filters.length ;
            for( var i:int = 0 ; i<len ; i++ )
            	{
            	value |= int(filters[i]);
            	}
            
            if( value > 0 )
            	{
            	filter = new FilterType( value );
            	}
            
            return new _ClassInfo( o, filter );
            }
        
		/**
		 * Returns an array of public methods defined in the class of an object.
		 * @return an array of public methods defined in the class of an object.
		 */
        public static function getClassMethods( o:*, inherited:Boolean = false ):Array
            {
            var type:XML = describeType( o );
            var fullname:String = getClassName( o, true );
            var member:XML;
            var members:Array = [];
            
            for each( member in type.method )
                {
                if( inherited )
                    {
                    members.push( String( member.@name ) );
                    }
                else if( String( member.@declaredBy ) == fullname )
                    {
                    members.push( String( member.@name ) );
                    }
                }
            
            return members;
            }
        
		/**
		 * Returns the class name as string of an object.
		 * @return the class name as string of an object.
		 */
        public static function getClassName( o:*, path:Boolean = false ):String
            {
            return ( path == true ) ? getQualifiedClassName( o ) : _formatName(  getClassPath( o ) ) ;
            }
        
		/**
		 * Returns the package string representation of the specified instance passed in arguments.
		 * @param o the reference of the object to apply reflexion.
		 * @return the package string representation of the specified instance passed in arguments.
		 */
		public static function getClassPackage( o:* ):String 
			{
			return _formatPackage( getClassPath( o ) ) ;
			}	

		/**
		 * Returns the full path string representation of the specified instance passed in arguments (package + name).
		 * @param instance the reference of the object to apply reflexion.
		 * @return the full path string representation of the specified instance passed in arguments (package + name).
		 */
		public static function getClassPath( o:* ):String 
			{
			return _formatPath( getQualifiedClassName( o ) ) ;
			}
                
		/**
		 * Returns the instance of a public definition in the current Domain.
		 * The definition can be a class, namespace, function or object.
		 * @return the instance of a public definition in the current Domain.
		 */
        public static function getDefinitionByName( name:String ):Object
            {
            return ApplicationDomain.currentDomain.getDefinition( name );
            }        
        
		/**
		 * Returns the method reference of the specified object with the passed-in property name.
		 * @return the method reference of the specified object with the passed-in property name.
		 */
        public static function getMethodByName( o:*, name:String ):Function
            {
            var methods:Array = getClassMethods( o );
            if( methods.indexOf( name ) > -1 )
                {
                return o[name] as Function ;
                }
            
            return null;
            }
        
		/**
		 * Returns the super class name as string of an object.
		 * @return the super class name as string of an object.
		 */
		public static function getSuperClassName(o:*):String 
			{
			return _formatName( getSuperClassPath( o ) ) ;
			}
        
		/**
		 * Returns the super class package string representation of the specified instance passed in arguments.
		 * @param o the reference of the object to apply reflexion.
		 * @return the super class package string representation of the specified instance passed in arguments.
		 */
		public static function getSuperClassPackage(o:*):String 
			{
			return _formatPackage( getSuperClassPath( o ) ) ;
			}
        
		/**
		 * Returns the super class path string representation of the specified instance passed in arguments.
		 * @param o the reference of the object to apply reflexion.
		 * @return the super class path string representation of the specified instance passed in arguments.
		 */
		public static function getSuperClassPath(o:*):String 
			{
			return _formatPath( getQualifiedSuperclassName( o ) ) ;
			}
        
        /**
         * Returns the TypeInfo object of the specified object.
         * @return the TypeInfo object of the specified object.
         */
        public static function getTypeInfo( o:* ):TypeInfo
            {
            return new _TypeInfo( o );
            }
        
		/**
		 * Returns a boolean telling if the class exists from a string name.
		 * @return a boolean telling if the class exists from a string name.
		 */
        public static function hasClassByName( name:String ):Boolean
            {
            try
                {
                var c:Class = getClassByName( name );
                }
            catch( e:Error )
                {
                return false;
                }
            
            return true;
            }
        
        /**
         * Wrapping method which select which build method use according to the argument count (32 max).
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.Arrays ;
         * import system.Reflection ;
         * 
         * Array.prototype.toString = function():String
         * {
         *     return "[" + this.join(",") + "]" ;
         * }
         * 
         * var ar:Array
         * 
         * // test with no argument
         * ar = Reflection.invokeClass( Array ) ;
         * trace( ar ) ;
         * //output: []
         * 
         * // test with 0 argument
         * ar = Reflection.invokeClass( Array , [] ) ;
         * trace( ar ) ;
         * //output: []
         * 
         * // test with 2 arguments
         * ar = Reflection.invokeClass( Array , Arrays.initialize(2,0) ) ;
         * trace( ar ) ;
         * //output: [0,0]
         * 
         * // test with 32 arguments
         * ar = Reflection.invokeClass( Array , Arrays.initialize(32,0) ) ;
         * trace( ar ) ;
         * //output: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
         * 
         * // test with 33 arguments
         * ar = Reflection.invokeClass( Array , Arrays.initialize(33,0) ) ;
         * trace( ar ) ;
         * 
         * //output:
         * // ArgumentError: Reflection.invokeClass() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments.
         * </pre>
         * @param c The Class of the instance to build.
         * @param args The array of all arguments to passed-in the constructor of the specified class.
         */
        public static function invokeClass( c:Class, args:Array=null ):*
            {
            if ( args != null && args.length > 0 )
                {
                var a:Array = args ;
                switch( a.length )
                    {
                    case  1 : return new c(a[0]) ;
                    case  2 : return new c(a[0],a[1]) ;
                    case  3 : return new c(a[0],a[1],a[2]) ;                
                    case  4 : return new c(a[0],a[1],a[2],a[3]) ;
                    case  5 : return new c(a[0],a[1],a[2],a[3],a[4]) ;
                    case  6 : return new c(a[0],a[1],a[2],a[3],a[4],a[5]) ;
                    case  7 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6]) ;
                    case  8 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7]) ;
                    case  9 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8]) ;
                    case 10 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9]) ;
                    case 11 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10]) ;
                    case 12 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11]) ;
                    case 13 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12]) ;
                    case 14 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13]) ;
                    case 15 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14]) ;
                    case 16 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15]) ;
                    case 17 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16]) ;
                    case 18 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17]) ;
                    case 19 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18]) ;
                    case 20 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19]) ;
                    case 21 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20]) ;
                    case 22 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21]) ;
                    case 23 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22]) ;
                    case 24 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23]) ;
                    case 25 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24]) ;
                    case 26 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25]) ;
                    case 27 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26]) ;
                    case 28 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27]) ;
                    case 29 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28]) ;
                    case 30 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29]) ;
                    case 31 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29],a[30]) ;
                    case 32 : return new c(a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29],a[30],a[31]) ;
                    default :
                        {
                        throw new ArgumentError( "Reflection.invokeClass() method failed : arguments limit exceeded, you can pass a maximum of 32 arguments.") ; 
                        }
                    }
                }
            else
                {
                return new c() ;
                }
            }        
            
        }
    
    }

