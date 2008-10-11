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
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
    
    import andromeda.process.ActionURLLoader;
    
    import system.Reflection;    

    /**
     * This skeletal class provides an easy implementation of the IConfigLoader interface. 
     * @author eKameleon
     */
    public class CoreConfigLoader extends ActionURLLoader implements IConfigLoader
    {
        
        /**
         * Creates a new CoreConfigLoader instance.
       	 * @param loader The URLLoader object to load.
	     * @param bGlobal the flag to use a global event flow or a local event flow.
     	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function CoreConfigLoader( loader:URLLoader, bGlobal:Boolean = false, sChannel:String = null )
        {
            super( loader , bGlobal, sChannel ) ;
            parsing = true ;
            _config = Config.getInstance() ;
        }
        
        /**
         * Returns the config object.
         * @return the config object.
         */
        public function get config():Config 
    	{
    		return _config ;	
    	}
    	
        /**
         * Defines the defaut file name ('config').
         */
    	public var default_file_name:String = "config" ;
        
        /**
         * Defines the defaut file suffix ('.eden').
         */
    	public var default_file_suffix:String = ".txt" ;
        
        /**
         * The name of the config file with datas.
         */
        public function get fileName():String 
        {
		    return (_fileName == null) ? default_file_name : _fileName ;	
    	}

        /**
         * The name of the config file with datas.
         */
    	public function set fileName( value:String ):void 
    	{
    		_fileName = value ;	
    	}

        /**
         * The path of the config file with datas.
         */
    	public function get path():String 
    	{
		    return _path ;
        }
        
        /**
         * The path of the config file with datas.
         */
        public function set path( value:String ):void
        {
		    _path = value ;
    	}

		/**
		 * Indicates the URLRequest object who captures all of the information in a single HTTP request.
		 */
		public override function get request():URLRequest
		{
			return _request || new URLRequest( ( path || "" ) + ( fileName || "" ) + ( suffix || "" ) ) ;
		}

        /**
         * The suffix of the config file with datas.
         */
    	public function get suffix():String 
    	{
	    	return (_suffix == null) ? default_file_suffix : _suffix ;
    	}
 
        /**
         * The suffix of the config file with datas.
         */
	    public function set suffix( value:String ):void
	    {
		    _suffix = value ;
    	}

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            var cName:String = Reflection.getClassPath(this) ;
            var clazz:Class = ( getDefinitionByName( cName ) as Class ) ;
            var cloader:* = new clazz(_name) ;
            if (cloader != null)
            {
                cloader.data     = data ;
                cloader.fileName = fileName ;
                cloader.path     = path ;
                cloader.suffix   = suffix ;
            }
            return cloader ;
        }

        /**
         * Parse your datas when loading is complete.
         */
        public override function parse():void
        {
            var o:* = data ;
		    var c:* = config ;
		    for ( var prop:String in o ) 
		    {
    			c[ prop ] = o[prop] ;
	    	}
        }
		
        /**
         * @private
         */
        protected var _config:Config = null ;

        /**
         * @private
         */
        protected var _fileName:String = null ;

        /**
         * @private
         */
        protected var _name:String ;

        /**
         * @private
         */
        protected var _path:String = null ;

        /**
         * @private
         */
        protected var _suffix:String = null ;

    }

}