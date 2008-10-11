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
package andromeda.vo 
{
    import flash.net.registerClassAlias;
    
    import andromeda.vo.SimpleValueObject;
    
    import system.Reflection;
    
    import vegas.util.Serializer;

    /**
     * This class provides a binary filter value object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import andromeda.vo.FilterVO ;
     * 
     * var VIDEO :uint = 1 ;
     * var MP3   :uint = 2 ; 
     * 
     * var filter:FilterVO = new FilterVO() ;
     * 
     * trace( "filter : " +  filter ) ;
     * 
     * filter.toggleFilter( VIDEO , true ) ;
     * 
     * trace( "filter : " +  filter ) ;
     * 
     * trace( "filter.toggleFilter( MP3, true ) : " + filter.toggleFilter( MP3, true ) ) ;
     * trace( "filter.toggleFilter( MP3, true ) : " + filter.toggleFilter( MP3, true ) ) ;
     * 
     * trace("filter : " +  filter ) ;
     * 
     * filter.toggleFilter( VIDEO , false ) ;
     * 
     * trace( "filter : " +  filter ) ;
     * 
     * trace( "filter.contains( VIDEO ) : " + filter.contains( VIDEO ) ) ;
     * trace( "filter.contains( MP3 )   : " + filter.contains( MP3 ) ) ;
     * </pre>
     * @author eKameleon
     */
    public class FilterVO extends SimpleValueObject 
    {

        /**
         * Creates a new FilterVO instance. 
         * @param filter (optional) The default filter value of this value object.
         * @param init A generic object containing properties with which to populate the newly instance. If this argument is null, it is ignored
         */    
        public function FilterVO( init:Object = null )
        {
            super(init) ;
            setFilter(filter) ;    
        }
        
        /**
         * The default filter value of the filter value objects.
         */
        public static var NONE:Number = 0 ;
            
        /**
         * The filter value of this object.
         */
        public var filter:Number ;
            
        /**
          * Clear the filter value.
         */
        public function clear():void
        {
            filter = NONE ;
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the filter number value contains the option number value.
         * @return <code class="prettyprint">true</code> if the filter number value contains the option number value.
         */
        public function contains( value:Number ) : Boolean
        {
            return Boolean( value & getFilter() ) ;
        }    
        
        /**
         * Returns the current filter value of this object.
         * @return the current filter value of this object.
         */
        public function getFilter():Number
        {
            return isNaN( filter ) ? NONE : filter ;
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the filter is NONE.
         * @return <code class="prettyprint">true</code> if the filter is NONE.
         */
        public function isNone():Boolean
        {
            return getFilter() == NONE ;
        }

        /**
         * Preserves the class (type) of an object when the object is encoded in Action Message Format (AMF). 
         */
        public static function register( aliasName:String="FilterVO" ):void
        {
            registerClassAlias( aliasName , FilterVO ) ;
        }

        /**
         * Sets the current filter value of this object.
         */
        public function setFilter( n:Number ):void
        {
            filter = isNaN(n) ? NONE : n ;
        }
        
        /**
         * Toggle a filter value in this filter object.
         */
        public function toggleFilter( value:Number, b:Boolean ):Boolean
        {
            var old:Number = filter ;
            filter = b ? ( filter | value ) : ( filter & ~value ) ;
            return old != filter ;
        }
            
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object
        {
            return { filter:filter } ;
        }    
        
        /**
         * Returns a Eden represensation of the object.
         * @return a string representing the source code of the object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            return Serializer.getSourceOf( this, [ Serializer.toSource( filter ) ]  ) ;
        }
            
        /**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
        public override function toString():String
        {
            return "[" + Reflection.getClassName(this) + ":" + filter + "]" ;
        }
        
    }
}
