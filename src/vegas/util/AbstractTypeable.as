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

package vegas.util
{
    import system.Reflection;
    
    import vegas.core.CoreObject;
    import vegas.core.ITypeable;
    import vegas.core.IValidator;
    import vegas.errors.TypeMismatchError;	

    /**
     * This abstract class is used to create concrete <code class="prettyprint">ITypeable</code> implementations.
     * @author eKameleon
     * @see ITypeable
     * @see IValidator
     */
    public class AbstractTypeable extends CoreObject implements ITypeable, IValidator
    {
        
        /**
         * Creates a new AbstractTypeable instance.
         * @param type the Type of this ITypeable object.
         */ 
        public function AbstractTypeable(type:*)
        {
            super();
       		
       		if (type == null) 
            {
    			throw new ArgumentError("Argument 'type' must not be 'null' or 'undefined'.") ;
	    	}
		    _type = type ;
            
        }
        
	    /**
    	 * Returns the type of the ITypeable object.
    	 * @return the type of the ITypeable object.
    	 */
        public function getType():*
        {
    		return _type ;
        }

	    /**
    	 * Sets the type of the ITypeable object.
    	 */
        public function setType(type:*):void
        {
    	    _type = type ;
        }
        
       	/**
	     * Returns <code class="prettyprint">true</code> if the IValidator object validate the value.
    	 * @return <code class="prettyprint">true</code> is this specific value is valid.
	     */
        public function supports(value:*):Boolean
        {
        	return value is _type ;
        }
        
       	/**
	     * Evaluates the condition it checks and updates the IsValid property.
	     */
        public function validate(value:*):void
        {
    		if (!supports(value)) 
        	{
    		    throw new TypeMismatchError( Reflection.getClassName(this) + ".validate('value' : " + value + ") is mismatch.") ;
    		}
        }
        
       	/**
	     * The internal type function.
	     */
    	private var _type:* ;
        
    }
}