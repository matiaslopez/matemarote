/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package vegas.data.array
{
    import vegas.events.BasicEvent;
    import vegas.events.CoreEventDispatcher;
    import vegas.util.Serializer;	

    /**
     * This filter contains all constants and methods to sort the Arrays in the application.
     * <p><b>Example : </b></p>
     * <pre class="prettyprint">
     * import vegas.data.array.ArrayFilter ;
     * 
     * import vegas.events.BasicEvent ;
     * 
     * var debug:Function = function ():Void
     * {
     *     trace("filter : " + af.filter ) ;
     *     trace("is NONE               : " + af.isNone() )
     *     trace("is CASEINSENSITIVE    : " + af.isCaseInsensitive() ) ;
     *     trace("is DESCENDING         : " + af.isDescending() ) ;
     *     trace("is NUMERIC            : " + af.isNumeric() ) ;
     *     trace("is RETURNINDEXEDARRAY : " + af.isReturnIndexedArray() ) ;
     *     trace("is UNIQUESORT         : " + af.isUniqueSort() ) ;
     *     trace("---") ;
     * }
     * 
     * var change:Function = function ( e:BasicEvent ):Void
     * {
     *     trace( e ) ;
     * }
     * 
     * var af:ArrayFilter = ArrayFilter.getInstance() ;
     * af.addEventListener( ArrayFilter.CHANGE, change ) ;
     * 
     * debug() ;
     * 
     * af.setCaseInsensitive( true ) ;
     * af.setDescending( true ) ;
     * af.setNumeric( true ) ;
     * af.setReturnIndexedArray( true ) ;
     * af.setUniqueSort( true ) ;
     * debug() ;
     * 
     * af.setCaseInsensitive( false ) ;
     * debug() ;
     * 
     * af.setDescending( false ) ;
     * debug() ;
     * 
     * af.setNumeric( false ) ;
     * debug() ;
     * 
     * af.setReturnIndexedArray( false) ;
     * debug() ;
     * 
     * af.setUniqueSort( false ) ;
     * debug() ;
     * </pre>
     * @author eKameleon
     */
    public class ArrayFilter extends CoreEventDispatcher
    {
        
        /**
          * Creates a new ArrayFilter instance.
          * @param value the default filter value of this instance. If this argument is null the filter value is ArrayFilter.NONE(0). 
          * @param bGlobal the flag to use a global event flow or a local event flow.
          * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
          */
        public function ArrayFilter( value:uint=0, bGlobal:Boolean=false, sChannel:String=null)
        {
            super(bGlobal, sChannel);
            setFilter( value ) ;
            _eChange = new BasicEvent( CHANGE , this ) ;
        }

        /**
         * Specifies case-insensitive sorting for the Array class sorting methods. You can use this constant
         * for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. 
         * <p>The value of this constant is 1.</p>
         */
        public static var CASEINSENSITIVE:uint = Array.CASEINSENSITIVE ;
        
        /**
         * The change event occurs when the filter value is changed.
         */
        public static var CHANGE:String = "change" ;
        
        /**
         * Specifies descending sorting for the Array class sorting methods. 
         * You can use this constant for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code>
         * or <code class="prettyprint">sortOn()</code> method. 
         * <p>The value of this constant is 2.</p>
         */
        public static var DESCENDING:uint = Array.DESCENDING ;
        
        /**
         * Specifies the default numeric sorting value for the Array class sorting methods.
         * <p>The value of this constant is 0.</p>
         */
        public static var NONE:uint = 0;
        
        /**
         * Specifies numeric (instead of character-string) sorting for the Array class sorting methods. 
         * Including this constant in the <code class="prettyprint">options</code>
         * parameter causes the <code class="prettyprint">sort()</code> and <code class="prettyprint">sortOn()</code> methods 
         * to sort numbers as numeric values, not as strings of numeric characters.  
         * Without the <code class="prettyprint">NUMERIC</code> constant, sorting treats each array element as a 
         * character string and produces the results in Unicode order. 
         *
         * <p>For example, given the array of values <code class="prettyprint">[2005, 7, 35]</code>, if the <code class="prettyprint">NUMERIC</code> 
         * constant is <strong>not</strong> included in the <code class="prettyprint">options</code> parameter, the 
         * sorted array is <code class="prettyprint">[2005, 35, 7]</code>, but if the <code class="prettyprint">NUMERIC</code> constant <strong>is</strong> included, 
         * the sorted array is <code class="prettyprint">[7, 35, 2005]</code>. </p>
         * 
         * <p>This constant applies only to numbers in the array; it does 
         * not apply to strings that contain numeric data such as <code class="prettyprint">["23", "5"]</code>.</p>
         * 
         * <p>The value of this constant is 16.</p>
         */
        public static var NUMERIC:uint = Array.NUMERIC ;
        
        /**
         * Specifies that a sort returns an array that consists of array indices as a result of calling
         * the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. You can use this constant
         * for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> 
         * method, so you have access to multiple views on the array elements while the original array is unmodified. 
         * <p>The value of this constant is 8.</p>
         */
        public static var RETURNINDEXEDARRAY:uint = Array.RETURNINDEXEDARRAY ;

        /**
         * Specifies the unique sorting requirement for the Array class sorting methods. 
         * You can use this constant for the <code class="prettyprint">options</code> parameter in the <code class="prettyprint">sort()</code> or <code class="prettyprint">sortOn()</code> method. 
         * The unique sorting option terminates the sort if any two elements or fields being sorted have identical values. 
         * <p>The value of this constant is 4.</p>
         */
        public static var UNIQUESORT:uint = Array.UNIQUESORT ;
        
        /**
         * Returns the current filter value of this object.
         * @return the current filter value of this object.
         */
        public function get filter():uint 
        {
            return getFilter() ;
        }
        
        /**
         * Sets the current filter value of this object.
         */
        public function set filter(n:uint):void
        {
            setFilter(n) ;    
        }
        
        /**
         * Indicates if the change event is notify or not when the filter value change.
         */
        public var useEvent:Boolean = true ;
        
        /**
         * Returns <code class="prettyprint">true</code> if the filter number value contains the option number value.
         * @return <code class="prettyprint">true</code> if the filter number value contains the option number value.
         */
        public static function contains( nFilter:uint, nOption:uint ) : Boolean
        {
            return Boolean(nOption & nFilter) ;
        }
        
        /**
         * Returns the event name of the change event of this object.
         * @return the event name of the change event of this object.
         */
        public function getEventTypeCHANGE():String
        {
            return _eChange.type ;
        }
        
        /**
         * Returns the singleton reference of this class.
         * @return the singleton reference of this class.
         */
        public static function getInstance():ArrayFilter
        {
            if (_instance == null)
            {
                _instance = new ArrayFilter() ;    
            }    
            return _instance ;
        }
        
        /**    
         * Returns the current filter value of this object.
         * @return the current filter value of this object.
         */
        public function getFilter():uint
        {
            return isNaN(_filter) ? NONE : _filter ;
        }
    
        /**
         * Returns <code class="prettyprint">true</code> if the CASEINSENSITIVE option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the CASEINSENSITIVE option value exist in the current filter.
        */
        public function isCaseInsensitive():Boolean
        {
            return contains( getFilter() , CASEINSENSITIVE ) ;    
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the DESCENDING option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the DESCENDING option value exist in the current filter.
         */
        public function isDescending():Boolean
        {
            return contains( getFilter() , DESCENDING ) ;    
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
         * Returns <code class="prettyprint">true</code> if the NUMERIC option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the NUMERIC option value exist in the current filter.
         */
        public function isNumeric():Boolean
        {
            return contains( getFilter() , NUMERIC ) ;    
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the RETURNINDEXEDARRAY option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the RETURNINDEXEDARRAY option value exist in the current filter.
         */
        public function isReturnIndexedArray():Boolean
        {
            return contains( getFilter() , RETURNINDEXEDARRAY ) ;    
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the UNIQUESORT option value exist in the current filter.
         * @return <code class="prettyprint">true</code> if the UNIQUESORT option value exist in the current filter.
         */
        public function isUniqueSort():Boolean
        {
            return contains( getFilter() , UNIQUESORT ) ;    
        }
        
        /**
         * Notify a change in this object.
         */
        public function notifyChange():void
        {
            if ( useEvent == true )
            {
                dispatchEvent( _eChange ) ;
            }    
        }
        
        /**
         * Sets the CASEINSENSITIVE option value in the current filter.
         */
        public function setCaseInsensitive(b:Boolean):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | CASEINSENSITIVE : _filter & ~CASEINSENSITIVE ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }
        
        /**
         * Sets the DESCENDING option value in the current filter.
         */
        public function setDescending( b:Boolean ):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | DESCENDING : _filter & ~DESCENDING ;
            if (_filter != old)
            {
                notifyChange() ;
            }
        }

        /**
         * Sets the event name of the change event of this object.
         */
        public function setEventTypeCHANGE( type:String ):void
        {
            _eChange.type = type || CHANGE ;
        }

        /**
         * Sets the current filter value of this object.
         */
        public function setFilter( n:uint ):void
        {
            var old:uint = _filter ;
            _filter = isNaN(n) ? NONE : n ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }

        /**
         * Sets the NONE option value in the current filter.
         */
        public function setNone():void
        {
            var old:uint = _filter ;
            _filter = NONE ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }

        /**
         * Sets the NUMERIC option value in the current filter.
         */
        public function setNumeric( b:Boolean ):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | NUMERIC : _filter & ~NUMERIC ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }

        /**
         * Sets the RETURNINDEXEDARRAY option value in the current filter.
         */
        public function setReturnIndexedArray( b:Boolean ):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | RETURNINDEXEDARRAY : _filter & ~RETURNINDEXEDARRAY ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }

        /**
         * Sets the UNIQUESORT option value in the current filter.
         */
        public function setUniqueSort( b:Boolean ):void
        {
            var old:uint = _filter ;
            _filter = b ? _filter | UNIQUESORT : _filter & ~UNIQUESORT ;
            if (_filter != old)
            {
                notifyChange() ;
            }    
        }

		/**
		 * Returns a eden String representation of the object.
		 * @return a string representation the source code of the object.
		 */
        public override function toSource( indent:int = 0 ):String 
        {
            return Serializer.getSourceOf( this, [ _filter ] ) ;
        }

        /**
         * The internal change event reference.
         */
        private var _eChange:BasicEvent ;
        
        /**
         * The internal singleton reference.
         */
        private static var _instance:ArrayFilter ;
    
        /**
         * The filter value of this object.
         */
        private var _filter:uint ;
	}
}

