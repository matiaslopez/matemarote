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
package andromeda.config
{
    import vegas.core.Identifiable;
    import vegas.events.CoreEventDispatcher;	

    /**
     * This core class extend the CoreObject class and implement the IConfigurable interface.
     * A IConfigurable object handle a notification of the ConfigCollector class with the method setup(), you must override this method in your concrete class.
     * The IConfigurable objects are registered in the ConfigCollector to launch the setup of all IConfigurable object one time with the <code class="prettyprint">ConfigCollector.run()</code> method when the Config is loaded for example. 
     * @author eKameleon
     */
	public class ConfigurableObject extends CoreEventDispatcher implements IConfigurable, Identifiable
    {
       
    	/**
    	 * Creates a new ConfigurableObject instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
    	 */
        public function ConfigurableObject( id:*=null, isConfigurable:Boolean = false, bGlobal:Boolean = false , sChannel:String = null )
        {
            super( bGlobal , sChannel ) ;	
			if ( id != null )
			{
				this.id = id ;
			}
            this.isConfigurable = isConfigurable ;
        }

		/**
		 * Returns the id of this object.
		 * @return the id of this object.
		 */
		public function get id():*
		{
			return _id ;
		}
	
		/**
	 	 * @private
	 	 */
		public function set id( id:* ):void
		{
			_setID( id ) ;
		}

    	/**
	     * (read-write) Returns <code class="prettyprint">true</code> if the object is configurable and receive the notification of the ConfigCollector in the setup() method.
	     * @return <code class="prettyprint">true</code> if the object is configurable and receive the notification of the ConfigCollector.
    	 */
    	public function get isConfigurable():Boolean
    	{
    		return _isConfigurable ;
    	}

    	/**
    	 * (read-write) Sets if the object is configurable and receive the notification of the ConfigCollector in the setup() method.
    	 * @param b the flag boolean value to define if the object is configurable.
	     */
    	public function set isConfigurable(b:Boolean):void
    	{
    		_isConfigurable = (b == true) ;
    		if (_isConfigurable)
    		{
    			ConfigCollector.insert(this) ;	
    		}
    		else
    		{
    			ConfigCollector.remove(this) ;
    		}
    	}
 
     	/**
    	 * Invoked when this object when the ConfigCollector is run.
    	 */
       	public function setup():void
        {
        	if ( id != null )
        	{
				Config.getInstance().init( this , id , update ) ;
        	}
        }
	
		/**
		 * Update the display.
		 * You must override this method. This method is launch by the setup() method when the Config is checked.
		 */	
		public function update():void
		{
			// overrides this method.
		}
	
		/**
		 * The internal id of this object.
		 * @private
		 */
		private var _id:* ; 
 
 	    /**
         * Determinates if the object is configurable.
    	 */
    	private var _isConfigurable:Boolean ;
    	
		/**
		 * Sets the id of the object with a custom method.
		 */
		protected function _setID( id:* ):void 
		{
			this._id = id ;
		}
        
    }

}