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
package andromeda.ioc.io 
{
    import andromeda.ioc.core.ObjectAttribute;
    import andromeda.model.AbstractModel;
    
    import system.Reflection;
    
    import vegas.data.map.HashMap;    

    /**
     * This tool class is a helper to create an ObjectResource object with a generic object in the IoC context.
     */
    internal class ObjectResourceModel extends AbstractModel
    {
		    	
    	/**
    	 * Creates a new ObjectResourceModel instance.
    	 */
    	public function ObjectResourceModel( id:* = null , bGlobal:Boolean = false , sChannel:String = null )
        {
            super( id, bGlobal , sChannel ) ;
   			_map = new HashMap() ;
    	}
		    	
    	/**
    	 * Inserts a new ObjectResource class reference with the specified type in the builder.
    	 */
    	public function addObjectResource( type:String , clazz:Class ):Boolean
    	{
            if ( Reflection.getClassInfo(clazz).inheritFrom(ObjectResource) )  
    		{
    			_map.put( type, clazz ) ;
    			return true ;
    		}
    		else
    		{
    			return false ;
    		}
    	}
		    	
        /**
         * Creates the ObjectAttribute object with the specified generic object.
         * @param o The object definition to create an ObjectAttribute instance.
         */
        public function get( o:Object ):ObjectResource
        {
            if ( ObjectAttribute.RESOURCE in o )
            {
                var type:String = o[ ObjectAttribute.TYPE ] as String ;
                if ( _map.containsKey( type ) )
                {
                	var clazz:Class = _map.get( type ) as Class ;
                	if ( clazz != null )
                	{
                		return new clazz( o ) as ObjectResource ;
                	}
                }   
            }
            return null ;	
        }
    	
    	/**
    	 * Removes the ObjectResource class reference with the specified type in the builder.
    	 */
    	public function removeObjectResource( type:String ):Boolean
    	{
    		return _map.remove( type ) != null ;
    	}    	
    	
    	/**
    	 * @private
    	 */
    	private var _map:HashMap ;    	
    	
	}

}
