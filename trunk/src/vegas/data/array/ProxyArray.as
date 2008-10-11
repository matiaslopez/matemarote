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
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    
    import system.Cloneable;
    import system.Reflection;
    import system.Serializable;
    import system.serializers.eden.BuiltinSerializer;
    
    import vegas.core.HashCode;
    import vegas.core.ICopyable;
    import vegas.core.IHashable;
    import vegas.data.iterator.ArrayIterator;
    import vegas.data.iterator.Iterable;
    import vegas.data.iterator.Iterator;
    import vegas.util.Copier;    

    /**
     * The ProxyArray class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import vegas.data.array.ProxyArray ;
     * 
     * var a1:ProxyArray = new ProxyArray() ;
     * 
     * a1.push("item1") ;
     * a1.push("item2") ;
     * a1.push("item3") ;
     * a1.push("item4") ;
     * 
     * for (var prop:String in a1)
     * {
     *     trace( prop + " : " + a1[prop] ) ;
     * }
     * 
     * trace("----") ;
     * 
     * for each( var item:* in a1)
     * {
     *     trace(  item ) ;
     * }
     * 
     * trace("----") ;
     * 
     * trace("proxy array toString : " + a1) ;
     * trace("proxy array toSource : " + a1.toSource()) ;
     * 
     * var a2:ProxyArray = new ProxyArray( [[1, 2], [0, 4]] ) ;
     * 
     * var copy:ProxyArray = a2.copy() ;
     * copy[1][0] = 3 ;
     * copy[2] = [5,6] ;
     * copy[3] = [7,8] ;
     *
     * trace(a2 + " : " + copy) ;
     * </pre>
     * @author eKameleon
     */
    public dynamic class ProxyArray extends Proxy implements Cloneable, ICopyable, IHashable, Iterable, Serializable
    {
        
		/**
		 * Creates a new ProxyArray instance.
		 */        
        public function ProxyArray( datas:Array = null )
        {
            _ar = (datas == null) ? [] : [].concat(datas)  ;
        }
		
        /**
         * Overrides the behavior of an object property that can be called as a function. 
         * When a method of the object is invoked, this method is called. 
         * While some objects can be called as functions, some object properties can also be called as functions. 
         */
        flash_proxy override function callProperty( methodName:*  , ...rest:Array ):* 
        {
            var res:* ;
            switch ( methodName.toString() ) 
            {
                default :
                {
                    res = _ar[methodName].apply(_ar, rest);
                    break;
                }
            }
            return res ;
        }
		
		/**
		 * Creates and returns a shallow copy of the object.
		 * @return a shallow copy of the object.
		 */	
        public function clone():*
        {
            return new ProxyArray(_ar.slice()) ;
        }
		
		/**
		 * Creates and returns a deep copy of the object.
		 * @return a deep copy of the object.
		 */	
        public function copy():*
        {
            return new ProxyArray(Copier.copy(_ar)) ;
		}
		
		/**
         * Overrides any request for a property's value. 
         * If the property can't be found, the method returns undefined. 
         * For more information on this behavior, see the ECMA-262 Language Specification, 3rd Edition. 
         */
        flash_proxy override function getProperty( name:* ):* 
        {
            return _ar[name];
        }
		
		/**
		 * Returns a hashcode value for the object.
		 */
        public function hashCode():uint
        {
			if ( isNaN( __hashcode__ ) ) 
			{
				__hashcode__ = HashCode.next() ;
			}
			return __hashcode__ ;
		}

		/**
		 * Returns the iterator of the object.
		 * @return the iterator of the object.
		 */
    	public function iterator():Iterator 
    	{
		    return new ArrayIterator(_ar) ;
	    }
	    
	    /**
	     * Allows enumeration of the proxied object's properties by index number to retrieve property names. 
	     * However, you cannot enumerate the properties of the Proxy class themselves. 
	     * This function supports implementing for...in and for each..in loops on the object to retrieve the desired names. 
	     */
	    flash_proxy override function nextName( index:int ):String 
        {
            return _index.toString() ;
        }
	    
	    /**
	     * Allows enumeration of the proxied object's properties by index number. 
	     * However, you cannot enumerate the properties of the Proxy class themselves. 
	     * This function supports implementing for...in and for each..in loops on the object to retrieve property index values.
	     */ 
	    flash_proxy override function nextNameIndex ( index:int ):int 
	    {
	        _index = index ;
            return (index < _ar.length) ? index + 1 : 0 ;
        }
                
        /**
         * Allows enumeration of the proxied object's properties by index number to retrieve property values. 
         * However, you cannot enumerate the properties of the Proxy class themselves. 
         * This function supports implementing for...in and for each..in loops on the object to retrieve the desired values. 
         */
        flash_proxy override function nextValue(index:int):* 
        {
            return _ar[index-1] ;
        } 
        
        /**
         * Overrides a call to change a property's value. 
         * If the property can't be found, this method creates a property with the specified name and value.
         * @param name The name of the property to modify.
         * @param value The value to set the property to.
         */
        flash_proxy override function setProperty( name:* , value:* ):void 
        {
            _ar[name] = value ;
        }
        
		/**
		 * Returns a eden String representation of the object.
		 * @return a string representation the source code of the object.
		 */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "(" + BuiltinSerializer.emitArray( _ar ) + ")" ;
        }

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance
		 */
        public function toString():String
        {
            return _ar.toString() ;
        }
        		
		/**
		 * Internal array used in the proxy pattern.
		 */        
        protected var _ar:Array ;

		/**
		 * @private
		 */
		private var __hashcode__:Number ;
		
        /**
         * @private
         */
        private var _index:int ;		
        		
    }
}

