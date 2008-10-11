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
package system.reflection
    {
    import system.Enum;
    
    /**
     * The filter type enumeration class.
     * <p><b>Description :</p>
     * <pre class="prettyprint">
     * 0x000000
     *      |||_  0: both, 1: only prototype, 2: only trait
     *      ||__  0: both declared and inherited, 1: declared only
     *      |___  0: ignore static, 1: include static
     * </pre>
     */
    public class FilterType extends Enum
        {
    
        /**
         * Creates a new FilterType instance.
         * @param value The value of the enumeration.
         * @param name The name key of the enumeration.
         */
        public function FilterType( value:int=0, name:String="")
            {
            super( value, name);
            }
        

        
        /**
         * Indicates if use prototype information.
         */
        public function get usePrototypeInfo():Boolean
            {
            var value:uint = valueOf() & 0x00000f;
            
            if( value < 2 )
                {
                return true;
                }
            
            return false;
            }
        
        /**
         * Indicates if use trait information.
         */          
        public function get useTraitInfo():Boolean
            {
            var value:uint = valueOf() & 0x00000f;
            
            if( value == 1 )
                {
                return false;
                }
            
            return true;
            }
        
        /**
         * Indicates if the declared class are showed.
         */        
        public function get showDeclared():Boolean
            {
            var value:uint = (valueOf() & 0x0000f0) >>> 4;
            
            if( value > 1 )
                {
                return false; //should never happen
                }
            
            return true;
            }
        
        /**
         * Indicates if the inherited class are showed.
         */
        public function get showInherited():Boolean
            {
            var value:uint = (valueOf() & 0x0000f0) >>> 4;
            
            if( value == 0 )
                {
                return true;
                }
            
            return false;
            }
        
        /**
         * Indicates if the static members are showed.
         */
        public function get showStatic():Boolean
            {
            var value:uint = (valueOf() & 0x000f00) >>> 8;
            
            if( value == 0 )
                {
                return false;
                }
            
            return true;
            }
        
        /**
         * Default filter type value.
         * <li>use both prototype and trait</li>
         * <li>both declared and inherited</li>
         * <li>ignore static</li>
         */
        public static const none:FilterType           = new FilterType( 0x000, "none" );
        
        /**
         * Trait members will not be searched. 
         */
        public static const prototypeOnly:FilterType  = new FilterType( 0x001, "prototypeOnly" );
        
        /**
         * Prototype members will not be searched. 
         */
        public static const traitOnly:FilterType      = new FilterType( 0x002, "traitOnly" );
        
        /**
         * Inherited members will not be searched.
         * <p><b>Note:</b></p>
         * <p>For Trait this will apply only to methods and accessors not to variables and constants reason : 
         * variables and constants does not have a declaredBy attribute (from describeType), but that's normal 
         * because "inherited properties are copied down from superclasses into the traits object of subclasses" 
         * (cf: OOP in ActionScript/Advanced Topics/The Trait Object).</p>
         * <p>For prototype this will apply both to properties and methods.</p>
         */
        public static const declaredOnly:FilterType   = new FilterType( 0x010, "declaredOnly" );
        
        /**
         * Static members will be searched too. 
         */
        public static const includeStatic:FilterType  = new FilterType( 0x100, "includeStatic" );
        
        }
    
    }

