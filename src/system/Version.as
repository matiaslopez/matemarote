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
package system
    {
    
    /**
     * A basic Version class which is composed by four fields: major, minor, build and revision.
     * <p>implementation note:</p>
     * <p>internaly we stock the value of a version (the total of each fields) 
     * as a uint which max value is 4294967295 (0xFFFFFFFF) this is done to be able to use operators 
     * <pre class="prettyprint">
     * var v1:Version = new Version( 1, 0 );
     * var v2:Version = new Version( 2, 0 );
     * trace( v1 < v2 ); //true
     * </pre>
     * by default operators in ECMAScript will use the valueOf of the class and this is neat because 
     * we can use operators without the need to really implement them.
     * 
     * But this cause some little limitations on how much data each fields of a version object can stock
     * <pre class="prettyprint">
     * > 0x  F F FF FFFF
     * >     | |  |   |
     * >     | |  |   \revision (max 65535)
     * >     | |  \build (max 255)
     * >     | \minor (max 15)
     * >     \major (max 15)
     * </pre>
     * Here the choice has been to favorise a lot the revision field,
     * favorise a little the build  field, and well give the rest to 
     * the major and minor fields.
     * 
     * The logic behind that is:
     * - revision should be able to cover the full cycle of a project during all its life
     * - build should be able to cover all the different builds between two minor update
     * - major and minor should cover all the different versions of a project considering you don't update them that much
     * 
     * So the max version you can have is v15.15.255.65535
     * 
     * This logic and these limitations can change later.
     */
    public class Version implements Equatable
        {
        
        /**
         * @private
         */
        private var _build:uint;        
        
        /**
         * @private
         */
        private var _major:uint;
        
        /**
         * @private
         */
        private var _maxBuild:uint    = 0xff;
        
        /**
         * @private
         */
        private var _maxMajor:uint    = 0xf;
        
        /**
         * @private
         */
        private var _maxMinor:uint    = 0xf;
                
        /**
         * @private
         */
        private var _maxRevision:uint = 0xffff;        
        
        /**
         * @private
         */
        private var _minor:uint;
                
        /**
         * @private
         */
        private var _revision:uint;
                
        /**
         * @private
         */
        private var _separator:String = ".";
        
        /**
         * @private
         */
        private function getFields():int
            {
            var f:int = 4;
            
            if( revision == 0 )
                {
                f--;
                }
            
            if( (f == 3) && (build == 0) )
                {
                f--;
                }
            
            if( (f == 2) && (minor == 0) )
                {
                f--;
                }
            
            return f; //we always have a minimum field of 1, the major field
            }
        
        
        /**
         * Creates a new Version instance.
         * @param major The major value of the version.
         * @param minor The minor value of the version.
         * @param build The build value of the version.
         * @param revision The revision value of the version.
         */
        public function Version( major:uint = 0,
                                 minor:uint = 0,
                                 build:uint = 0,
                                 revision:uint = 0 )
            {
            
            if( (major > _maxMajor) && (minor == 0)
                                    && (build == 0)
                                    && (revision == 0) )
                {
                var v:Version = Version.fromNumber( major );
                major    = v.major;
                minor    = v.minor;
                build    = v.build;
                revision = v.revision;
                }
            
            this.major    = major;
            this.minor    = minor;
            this.build    = build;
            this.revision = revision;
            
            }
        
        /**
         * Constructs a Version object from a string.
         */
        public static function fromString( value:String = "", separator:String = "." ):Version
            {
            var v:Version = new Version();
            
            if( (value == "") || (value == null) )
                {
                return v;
                }
            
            if( value.indexOf( separator ) > -1 )
                {
                var values:Array = value.split( separator );
                v.major    = parseInt( values[0] );
                v.minor    = parseInt( values[1] );
                v.build    = parseInt( values[2] );
                v.revision = parseInt( values[3] );
                }
            else
                {
                v.major = parseInt( value );
                }
            
            return v;
            }
        
        /**
         * Constructs a Version object from a number.
         * If the number is zero or negative, or is NaN or Infity returns an empty version object.
         */
        public static function fromNumber( value:Number = 0 ):Version
            {
            var v:Version = new Version();
            
            if( isNaN(value) || (value == 0) || (value < 0)
                || (value == Number.MAX_VALUE)
                || (value == Number.POSITIVE_INFINITY)
                || (value == Number.NEGATIVE_INFINITY) )
                {
                return v;
                }
            
            //this is like the inverse of valueOf
            //(major << 28) | (minor << 24) | (build << 16) | revision
            //but be carefull to NOT preserve the bit sign, so use >>> instead of >>
            v.major    = (value >>> 28);
            v.minor    = (value & 0x0f000000) >>> 24;
            v.build    = (value & 0x00ff0000) >>> 16;
            v.revision = (value & 0x0000ffff);
            
            return v;
            }
        
        /**
         * Indicates the build value of this version.
         */
        public function get build():uint
            {
            return _build;
            }
         
        /**
         * @private
         */
        public function set build( value:uint ):void
            {
            _build = Math.min( value, _maxBuild );
            }        
        
        /**
         * Indicates the major value of this version.
         */        
        public function get major():uint
            {
            return _major;
            }
        
        /**
         * @private
         */        
        public function set major( value:uint ):void
            {
            _major = Math.min( value, _maxMajor );
            }

        /**
         * Indicates the minor value of this version.
         */
        public function get minor():uint
            {
            return _minor;
            }
      
        /**
         * @private
         */ 
        public function set minor( value:uint ):void
            {
            _minor = Math.min( value, _maxMinor );
            }
        


        /**
         * Indicates the revision value of this version.
         */
        public function get revision():uint
            {
            return _revision;
            }

        /**
         * @private
         */
        public function set revision( value:uint ):void
            {
            _revision = Math.min( value, _maxRevision );
            }
        
        /**
         * We don't really need an equals method as we override the valueOf, we can do something as
         * <pre class="prettyprint">
         * var v1:Version = new Version( 1,0,0,0 );
         * var v2:Version = new Version( 1,0,0,0 );
         * trace( int(v1) == int(v2) ); //true
         * </pre>
         * A cast to Number/int force the valueOf, not ideal but sufficient, and the same for any other operators.
         * But as we keep IEquatable for now, then we have no reason to not use it.
         */
        public function equals( o:* ):Boolean
            {
            if( !(o is Version) )
                {
                return false;
                }
            
            if( (o.major == major) &&
                (o.minor == minor) &&
                (o.build == build) &&
                (o.revision == revision) )
                {
                return true;
                }
            
            return false;
            }
         
        /**
         * Returns a string representation of the object.
         * By default, the format returned will include only the fields greater than zero
         * <pre class="prettyprint">
         * var v:Version = new Version( 1, 5 );
         * trace( v ); // "1.5"
         * </pre>
         * note :
         * the fields parameter allow you to force or limit the output format
         * <pre class="prettyprint">
         * var v:Version = new Version( 1, 5 );
         * trace( v.toString( 1 ) ); // "1"
         * trace( v.toString( 4 ) ); // "1.5.0.0"
         * </pre>
         * <p>format :</p>
         * <li>major.minor.build.revision</li>
         * <li>major.minor.build</li>
         * <li>major.minor</li>
         * <li>major</li>
         */
        public function toString( fields:int = 0 ):String
            {
            var arr:Array;
            
            if( (fields <= 0) || (fields > 4) )
                {
                fields = getFields(); //get the default fields
                }
            
            switch( fields )
                {
                case 1 :
                    {
                    arr = [ major ];
                    break;
                    }                
                case 2 :
                    {
                    arr = [ major, minor ];
                    break;
                    }
                
                case 3:
                    {
                    arr = [ major, minor, build ];
                    break;
                    }
                
                case 4:
                default:
                    {
                        arr = [ major, minor, build, revision ];
                    }
                }
            
            return arr.join( _separator );
            }
                 
        /**
         * Returns the primitive value of the object.
         * @return the primitive value of the object.
         */
        public function valueOf():uint
            {
            /* 0xF F FF FFFF
            */
            return (major << 28) | (minor << 24) | (build << 16) | revision;
            }

        }   
    
    }