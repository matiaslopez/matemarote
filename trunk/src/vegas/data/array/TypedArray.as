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
    import system.Reflection;
    import system.serializers.eden.BuiltinSerializer;
    
    import vegas.core.ITypeable;
    import vegas.core.IValidator;
    import vegas.errors.TypeMismatchError;    

    /**
     * <code class="prettyprint">TypedArray</code> acts like a normal array but assures that only objects of a specific type are added to the array.
     * <p>Example :
     * <pre class="prettyprint">
     * import vegas.data.array.TypedArray ;
     * 
     * var ta:TypedArray = new TypedArray(String, ["item1", "item2", "item3"]) ;
     * trace ("ta : " + ta) ; // output : ta : item1,item2,item3
     * ta.push(2) ; // [TypeMismatchError] TypedArray.validate('value':2) is mismatch
     * </pre>
     * @author eKameleon 
     */
    public class TypedArray extends ProxyArray implements ITypeable, IValidator
    {
        
        /**
         * Creates a new TypedArray instance.
         * @throw TypeError if the 'type' argument is not a valid Class object (not must be 'null' or 'undefined').
         */
        public function TypedArray( ...arguments:Array )
        {
            _type = arguments[0] as Class ;
            var ar:Array = arguments[1] as Array ;
            if (ar != null)
            {
                var l:uint = ar.length ;
                if (l > 0) 
                {
                    for (var i:Number = 0 ; i<l ; i++) 
                    {
                        var value:* = ar[i] ;
                        if (supports(value)) 
                        {
                        	_ar[i] = value ;
                        }
                    }
                }
            }
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         */    
        public override function clone():*
        {
            return new TypedArray(_type, _ar.slice()) ;
        }

        /**
         * Creates and returns a deep copy of the object.
         */    
        public override function copy():*
        {
            return new TypedArray(_type, _ar.slice()) ;
        }

        /**
         * Concatenates the elements specified in the parameter list with the elements of this array and returns a new array containing these element.
         * @return a new array that contains the elements of this array as well as the passed-in elements.
         */
        public function concat( ...arguments:Array ):TypedArray 
        {
            var r:TypedArray = new TypedArray(_type) ;
            var i:uint = _ar.length ;
            while(--i>-1) 
            {
                r[i] = _ar[i];
            }
            var l2:uint ;
            var k:int ;
            var l1:uint = arguments.length ;
            var j:int = -1 ;
            while(++j < l1) 
            {
                
                var cur:* = arguments[j] ;
                
                if (cur is Array) 
                {
                    l2 = (cur as Array).length ;
                    k = -1 ;
                    while (++k < l2) 
                    {
                        _ar.push( cur[k] );
                    }
                } 
                else 
                {
                    _ar.push(cur);
                }
            }
            return r ;
        }
        
        /**
         * Returns the type of the ITypeable object.
         * @return the type of the ITypeable object.
         */
        public function getType():*
        {
            return _type;
        }

        /**
         * Adds one or more elements to the end of this array and returns the new length of this array.
         * @return the new length of this array
         * @throws TypeMismatchError 
         */
        public function push( ...arguments:Array ):uint 
        {
            if (arguments.length > 1) 
            {
                var l:uint = arguments.length;
                var i:uint = 0 ;
                while (++i < l)
                {
                    validate(arguments[i]) ;
                }
            }
            else
            {
                validate(arguments[0]) ;
            }
            return Number( _ar.push.apply(_ar, arguments) ) ;
        }

        /**
         * Sets the type of the ITypeable object.
         */
        public function setType(type:*):void
        {
            _type = type ;
            _ar.length = 0 ;
        }
    
        /**
         * Returns true if the IValidator object validate the value.
         */
        public function supports(value:*):Boolean 
        {
            return value is _type ;
        }
        
        /**
         * Returns a eden String representation of the object.
         * @return a string representation the source code of the object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "(" + Reflection.getClassPath(_type) + "," + BuiltinSerializer.emitArray( _ar ) + ")" ;
        }        
        
        /**
         * Adds one or more elements to the beginning of an array and returns the new length of the array. 
         * The other elements in the array are moved from their original position, i, to i+1. 
         */
        public function unshift( ...arguments:Array ):uint
        {
            if (arguments.length > 1) {
                
                var l:uint = arguments.length ;
                var i:int = -1 ;
                while (++i < l ) 
                {
                    validate(arguments[i]);
                }
            }
            else 
            {
                validate(arguments[0]) ;
            }
            return _ar.unshift.apply(_ar, arguments) as uint ;
        }
  
        /**
         * Evaluates the condition it checks and updates the IsValid property.
         * @throws TypeMismatchError 
         */
        public function validate(value:*):void
        {
            if (!supports(value)) 
            {
                throw new TypeMismatchError("TypedArray.validate('value':" + value + ") is mismatch") ;
            }
        }
                
        /**
         * @private
         */
        private var _type:Class ;
    }
}

