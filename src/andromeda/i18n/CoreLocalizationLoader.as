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
package andromeda.i18n
{
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
    
    import andromeda.process.ActionURLLoader;
    
    import system.Reflection;    

    /**
     * This skeletal class provides an easy implementation of the ILocalizationLoader interface. 
     * @author eKameleon
     */
    public class CoreLocalizationLoader extends ActionURLLoader implements ILocalizationLoader
    {
        
        /**
         * Creates a new CoreLocalizationLoader instance.
         * @param localization The Localization singleton reference of this loader.
       	 * @param loader The URLLoader object to load.
	     * @param bGlobal the flag to use a global event flow or a local event flow.
     	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function CoreLocalizationLoader( localization:Localization = null , loader:URLLoader = null, bGlobal:Boolean = false, sChannel:String = null )
        {
            super( loader , bGlobal, sChannel ) ;
           	this.localization = localization || Localization.getInstance() ;
            parsing = true ;
        }

        /**
         * Indicates the lang of the current Localization to load.
         */
        public function get lang():*
        {
            return _lang || default_lang ; 
		}
        
        /**
         * @private
         */
        public function set lang( lang:* ):void
        {
           	_lang = ( Lang.validate( lang ) ) ? lang : null ;
        }

        /**
         * Returns the localization reference of this loader.
         * @return the localization reference of this loader.
         */
        public function get localization():Localization
        {
            return _localization || Localization.getInstance() ;    
        }
        
        /**
         * @private
         */
        public function set localization( localization:Localization ):void
        {
            _localization = localization ;    
        }
        
        /**
         * Defines the defaut lang of the localization file.
         */
        public var default_lang:String = "en" ;        
        
        /**
         * Defines the defaut path of the localization file.
         */
        public var default_file_path:String = "" ;
        
        /**
         * Defines the defaut prefix of the localization file.
         */
        public var default_file_prefix:String = "localize_" ;
        
        /**
         * Defines the defaut file suffix of the localization file.
         */
        public var default_file_suffix:String = ".txt" ;

        /**
         * The path of the localization file.
         */
        public function get path():String 
        {
            return _path || default_file_path || "" ;
        }
        
        /**
         * @private
         */
        public function set path( value:String ):void
        {
            _path = value ;
        }

        /**
         * The prefix of the localization file.
         */
        public function get prefix():String 
        {
            return _prefix || default_file_prefix || "" ;
        }
        
        /**
         * @private
         */
        public function set prefix( value:String ):void
        {
            _prefix = value ;
        }

		/**
		 * Indicates the URLRequest object who captures all of the information in a single HTTP request.
		 */
		public override function get request():URLRequest
		{
			return _request || new URLRequest( ( path || "" ) + ( prefix || "" ) + ( lang || "" ) + ( suffix || "" ) ) ;
		}

        /**
         * The suffix of the config file with datas.
         */
        public function get suffix():String 
        {
            return _suffix || default_file_suffix || "" ;
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
            var loader:* = new clazz() ;
            if (loader != null)
            {
                loader.data     = data ;
                loader.path     = path ;
                loader.prefix   = prefix ;
                loader.suffix   = suffix ;
            }
            return loader ;
        }
    
        /**
         * Sends and loads data from the specified passed-in lang value (the passed-in argument must be a Lang reference or a valid string).
         * @param lang The localization Lang value.
         */
        public function loadLang( lang:* ):void
        {
			if ( lang != null )
			{
				this.lang = lang ;
			}
			run() ;
        }

        /**
         * Parse your datas when loading is complete.
         */
        public override function parse():void
        {
        	if ( data != null )
        	{
                var current:Lang  = Lang.get( lang.toString() ) ;
                if ( current != null )
                {
                    localization.append( current.value , data ) ;
                    localization.current = current ;
                }
                else
                {
                    getLogger().warn(this + " parse error : append the current Localization failed, the current Lang value not must be 'null' or 'undefined'.")	;
                }
        	}
        	else
        	{
        		getLogger().warn(this + " parse error : append the current Localization failed, the external object date value not must be 'null' or 'undefined'.")   ;
        	}
        }

		/**
		 * @private
		 */
        private var _lang:* ;
        
        /**
         * @private
         */
        protected var _localization:Localization ;

        /**
         * @private
         */
        protected var _path:String ;

        /**
         * @private
         */
        protected var _prefix:String ;

        /**
         * @private
         */
        protected var _suffix:String ;
        
    }

}