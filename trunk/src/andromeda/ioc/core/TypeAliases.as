/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.ioc.core 
{
    import vegas.core.CoreObject;
    import vegas.data.Map;
    import vegas.data.iterator.Iterator;
    import vegas.data.map.HashMap;    

    /**
     * This object is an helper who contains type aliases. 
     * <p>This helper is used in a ioc container (<code class="prettyprint">ObjectFactory</code>) to map the type class of an object.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import andromeda.ioc.core.TypeAliases ;
     * import vegas.data.iterator.Iterator ;
     * 
     * var aliases:TypeAliases = new TypeAliases() ;
     * 
     * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
     * aliases.put( "CoreObject"       , "vegas.core.CoreObject" ) ;
     * aliases.put( "ObjectFactory"    , "andromeda.factory.ObjectFactory" ) ;
     * aliases.put( "vegas.HashMap"    , "vegas.data.map.HashMap" ) ; // can use custom alias
     * 
     * trace("-------- aliases.containsAlias('DropShadowFilter')") ;
     * 
     * trace( aliases.containsAlias('DropShadowFilter') ) ;
     * trace( aliases.containsAlias('noAlias') ) ;
     * 
     * trace("-------- aliases.containsValue()") ;
     * 
     * trace( aliases.containsValue('vegas.core.CoreObject') ) ;
     * trace( aliases.containsAlias('noValue') ) ;
     * 
     * trace("-------- aliases.getAliases()") ;
     * 
     * trace( aliases.getAliases() ) ;
     * 
     * trace("-------- aliases.getValue('CoreObject')") ;
     * 
     * trace( aliases.getValue("CoreObject") ) ;
     * 
     * trace("-------- aliases.getValues()") ;
     * 
     * trace( aliases.getValues() ) ;
     * 
     * trace("-------- iterator") ;
     * 
     * var it:Iterator = aliases.iterator() ;
     * while( it.hasNext() )
     * {
     *     var next:String = it.next() as String ;
     *     var key:String  = it.key()  as String ;
     *     trace( aliases + " alias : '" + key + "' -> value : '" + next + "'" ) ;
     * }
     * 
     * trace("-------- clear and isEmpty") ;
     * 
     * trace( aliases.isEmpty() ) ;
     * aliases.clear() ;
     * trace( aliases.isEmpty() ) ;
     * </pre>
     * @author eKameleon
     */
    public class TypeAliases extends CoreObject
    {
        
        /**
         * Creates a new TypeAliases instance.
         */
        public function TypeAliases()
        {
            _map = new HashMap() ;
        }
        
        /**
         * Clear all alias in the internal map of this object.
         */
        public function clear():void
        {
            _map.clear() ;
        }
        
        /**
         * Indicates if the collector contains the passed-in alias expression.
         * @return <code class="prettyprint">true</core> if the collector contains the passed-in alias expression.
         */
        public function containsAlias( alias:String ):Boolean
        {
            if ( alias == null || alias.length == 0)
            {
                return false ;
            }
            return _map.containsKey( alias ) ;
        }
        
        /**
         * Indicates if the collector contains the passed-in type value expression.
         * @return <code class="prettyprint">true</core> if the collector contains the passed-in type value expression.
         */        
        public function containsValue( value:String ):Boolean
        {
            if ( value == null || value.length == 0)
            {
                return false ;
            }
            return _map.containsValue( value ) ;  
        }        
        
        /**
         * Returns the Array representation of all aliases registered in this collector.
         * <pre class="prettyprint">
         * import andromeda.ioc.core.TypeAliases ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * 
         * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
         * aliases.put( "CoreObject"       , "vegas.core.CoreObject" ) ;
         * 
         * trace( aliases.getAliases() ) ; // DropShadowFilter,CoreObject
         * </pre>
         * @return the Array representation of all aliases registered in this collector.
         */
        public function getAliases():Array 
        {
            return _map.getKeys() ;
        }        
        
        /**
         * Returns the internal Map reference of this collector.
         * @return the internal Map reference of this collector.
         */
        public function getMap():Map
        {
            return _map ;
        }        
        
        /**
         * Returns the value of the specified alias.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import andromeda.ioc.core.TypeAliases ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * aliases.put( "CoreObject" , "vegas.core.CoreObject" ) ;
         * 
         * trace( aliases.getValue("CoreObject") ) ; // vegas.core.CoreObject
         * </pre>
         * @return the value of the specified alias.
         */
        public function getValue( alias:String ):String 
        {
            return _map.get( alias ) ;
        }
        
        /**
         * Returns the <code class="prettyprint">Array</code> representation of all type values registered in this collector.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import andromeda.ioc.core.TypeAliases ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
         * aliases.put( "CoreObject"       , "vegas.core.CoreObject" ) ;
         * 
         * trace( aliases.getValues() ) ; // flash.filters.DropShadowFilter,vegas.core.CoreObject
         * </pre>
         * @return the <code class="prettyprint">Array</code> representation of all type values registered in this collector.
         */
        public function getValues():Array 
        {
            return _map.getValues() ;
        }           
        
        /**
         * Returns <code class="prettyprint">true</code> if the collector is empty.
         * @return <code class="prettyprint">true</code> if the collector is empty.
         */
        public function isEmpty():Boolean
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Returns the <code class="prettyprint">Iterator</code> of the object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import andromeda.ioc.core.TypeAliases ;
         * import vegas.data.iterator.Iterator ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * 
         * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
         * aliases.put( "CoreObject"       , "vegas.core.CoreObject" ) ;
         * aliases.put( "ObjectFactory"    , "andromeda.factory.ObjectFactory" ) ;
         * aliases.put( "vegas.HashMap"    , "vegas.data.map.HashMap" ) ; // can use custom alias
         * 
         * var it:Iterator = aliases.iterator() ;
         * while( it.hasNext() )
         * {
         *     var next:String = it.next() as String ;
         *     var key:String  = it.key()  as String ;
         *     trace( aliases + " alias : '" + key + "' -> value : '" + next + "'" ) ;
         * }
         * </pre>
         * @return the <code class="prettyprint">Iterator</code> of the object.
         */
        public function iterator():Iterator
        {
            return _map.iterator() ;
        }
                
        /**
         * Inserts an alias in the collector. If the alias already exist the value in the collector is replaced.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * import andromeda.ioc.core.TypeAliases ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * 
         * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
         * aliases.put( "CoreObject"       , "vegas.core.CoreObject" ) ;
         * aliases.put( "ObjectFactory"    , "andromeda.factory.ObjectFactory" ) ;
         * aliases.put( "vegas.HashMap"    , "vegas.data.map.HashMap" ) ; // can use custom alias
         * </pre>
         * @param alias The alias name, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @param value The value of the alias type, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @return <code class="prettyprint">true</core> if the alias can be registered.
         */
        public function put( alias:String, value:String ):Boolean
        {
            if ( alias == null || value == null || alias.length == 0  || value.length == 0 )
            {
                return false ;
            }
            _map.put( alias , value ) ;
            return true ;
        }
        
        /**
         * Returns the number of alias registered in the collector.
         * @return the number of alias registered in the collector.
         */
        public function size():uint
        {
            return _map.size() ;
        }        
        
        /**
         * @private
         */
        private var _map:HashMap ;
        
    }
}
