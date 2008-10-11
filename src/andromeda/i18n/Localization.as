/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.i18n 
{
    import flash.errors.IllegalOperationError;
    
    import andromeda.events.LocalizationEvent;
    
    import system.Reflection;
    import system.evaluators.PropertyEvaluator;
    
    import vegas.core.Identifiable;
    import vegas.data.map.HashMap;
    import vegas.events.CoreEventDispatcher;    

    /**
     * The Localization class allows to manage via textual files with 'JSON' or 'eden' format to charge the textual contents 
     * of an application according to the parameters of languages chosen by the users.
     * <p>It is possible to define several singletons of the Localization class to manage several elements in the application, but for this it's necessary to use the static property getInstance(sName). 
     * Thus all the authorities become of Singletons reusable a little everywhere in the application rather quickly.</p>
     * @example
     * <pre class="prettyprint">
     * import andromeda.events.ActionEvent ;
     * 
     * import andromeda.i18n.EdenLocalizationLoader ;
     * import andromeda.i18n.Lang ;
     * import andromeda.i18n.Locale ;
     * import andromeda.i18n.Localization ;
     * 
     * import andromeda.events.LocalizationEvent ;
     * 
     * var debug:Function = function( e:Event ):void
     * {
     *     trace("------- " + e.type ) ;
     * }
     * 
     * var change:Function = function( e:LocalizationEvent )
     * {
     *     var target:Localization = e.getTarget() ;
     *     var current:Lang  = e.getCurrent() ;
     *     var locale:Locale = e.getLocale() ;
     *     trace("# change current " + current ) ;
     *     trace("# change locale  " + locale  ) ;
     *     for (var each:String in locale)
     *     {
     *         trace("  * " + each + " : " + locale[each]) ;
     *         for (var prop:String in locale[each])
     *         {
     *             trace("    * " + prop + " : " + locale[each][prop]) ;
     *         }
     *     }
     * }
     * 
     * var localization:Localization  = Localization.getInstance() ;
     * localization.addEventListener( LocalizationEvent.CHANGE , change ) ;
     * 
     * var loader:EdenLocalizationLoader = localization.loader as EdenLocalizationLoader ;
     * loader.addEventListener( ActionEvent.START , debug ) ;
     * loader.addEventListener( ActionEvent.FINISH , debug ) ;
     * loader.path = "locale/" ;
     * 
     * localization.current = Lang.FR ;
     * 
     * var onKeyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     var code:uint = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.UP :
     *         {
     *             localization.current = Lang.EN ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *             localization.current = "fr" ;
     *             break ;
     *         }
     *     }
     * }
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , onKeyDown ) ; 
	 * </pre> 
     * @author eKameleon
     * @see andromeda.i18n.Lang
     * @see andromeda.i18n.Locale
     */
    public class Localization extends CoreEventDispatcher implements Identifiable
    {

        /**
         * Creates a new Localization instance.
         * @param id the id of the object.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function Localization( id:*=null , bGlobal:Boolean = false, sChannel:String = null )
        {
            super(bGlobal, sChannel) ;
            _setID( id ) ;
            _evaluator = new PropertyEvaluator() ;
            _map       = new HashMap() ;
            _loader    = new EdenLocalizationLoader(this) ;
        }
        
        /**
         * The name of the event when the localization is changed.
         */
        public static var CHANGE:String = LocalizationEvent.CHANGE  ;

        /**
         * The default singleton name of the Localization singletons.
         */
        public static var DEFAULT_ID:String = "default" ;

        /**
         * (read-write) Indicates the current <code class="prettyprint">Lang</code> object selected in the current localization.
         */
        public function get current():* 
        {
            return _current ;
        }
            
        /**
         * @private
         */
        public function set current( lang:* ):void
        {
            if ( Lang.validate(lang) ) 
            {
                _current = Lang.get(lang) ;
                if ( contains( _current ) ) 
                {
                    notifyChange() ;
                }
                else 
                {
                    loader.loadLang( _current ) ;
                }
            }
        }    

        /**
         * (read-write) Returns the id of this object.
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
         * Returns the internal ILocalizationLoader reference of the Localization singleton.
         * @return the internal ILocalizationLoader reference of the Localization singleton.
         */
        public function get loader():ILocalizationLoader
        {
            return _loader ;    
        }
        
        /**
         * @private
         */
        public function set loader( loader:ILocalizationLoader ):void
        {
            _loader = loader || new EdenLocalizationLoader() ; // default eden parser
            _loader.localization = this ;    
        }
        
        /**
         * Indicates if the class throws errors or return null when an error is throwing.
         */        
        public function get throwError():Boolean
        {
            return _evaluator.throwError ;	
        }
        
        /**
         * @private
         */        
        public function set throwError( b:Boolean ):void
        {
            _evaluator.throwError = b ;  
        }        
        
        /**
         * Append the specified dynamic object values with the specificied lang value.
         * If no exist a Locale Object with the specified lang id, a Locale Object is created.
         * @param lang The language id, must be a String (valid in the Lang class) or a Lang object.
         * @param o The dynamic object used to append the Locale object of the specified lang.
         * @return <code class="prettyprint">true</code> if the append process is done.
         */
        public function append( lang:* , o:* ):Boolean 
        {
            if ( Lang.validate( lang ) && Reflection.getClassInfo(o).isDynamic() )
            {
            	var id:* = _getID( lang ) ;
            	if (  contains( id ) )
            	{
                    var locale:Locale =  _map.get( _getID( lang ) ) as Locale ;
                    for ( var prop:String in o ) 
                    {
                        locale[ prop ] = o[prop] ;
                    }
            	}
            	else
            	{
            		_map.put( id , new Locale( o ) ) ;
            	}
                return true ;
            }
            else
            {
                return false  ;    
            }
        }        
        
        /**
         * Removes all singletons in the internal map of this object..
         */
        public function clear():void 
        {
            _map.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this Localization contains the specified Lang.
          * @return <code class="prettyprint">true</code> if this Localization contains the specified Lang.
         */
        public function contains( lang:* ):Boolean 
        {     
            if ( Lang.validate( lang ) )
            {
                return _map.containsKey( _getID( lang ) ) ;
            }
            else
            {
                return false ;    
            }
        }
    
        /**
         * Returns the current <code class="prettyprint">Locale</code> object defines with the specified <code class="prettyprint">Lang</code> object in argument.
         * @return the current <code class="prettyprint">Locale</code> object defines with the specified <code class="prettyprint">Lang</code> object in argument.
         */
        public function get( lang:* ):Locale 
        {
            if ( Lang.validate( lang ) )
            {
                return _map.get( _getID( lang ) ) as Locale ;
            }
            else
            {
                return null ;
            }
        }
        
        /**
         * Returns the event name use in the notifyChange method.
         * @return the event name use in the notifyChange method.
         */
        public function getEventTypeCHANGE():String
        {
            return _sTypeCHANGE ;
        }
        
        /**
         * Returns a <code class="prettyprint">Localization</code> singleton reference with the specified name passed-in argument.
         * @return a <code class="prettyprint">Localization</code> singleton reference with the specified name passed-in argument.
         */
        public static function getInstance( id:String=null ):Localization 
        {
            id = id || Localization.DEFAULT_ID  ;
            if (!__mInstances.containsKey(id)) 
            {
                __mInstances.put(id, new Localization(id)) ;
            }
            return __mInstances.get(id) as Localization  ;
        }    
        
        /**
          * Returns the locale object with all this properties.
          * @param sID (optional) if this key is specified the method return the value of the specified key in the current locale object.  
          * @return the locale object with all this properties.
          */
        public function getLocale( id:String=null ):* 
        {
            if ( id != null && _current != null ) 
            {
            	var item:* = this.get( _current ) ;
           		if ( item != null ) 
           		{
           			_evaluator.target = item ;
                    return _evaluator.eval(id) ;
           		}
           		else
           		{
           		   return null ;	
           		}
            }
            else 
            {
                return this.get( _current ) || null ;
            }
        }
        
        /**
         * Apply the current localization over the specified object.
         * @param o The object to fill with the current localization in the application.
         * @param sID (optional) if this key is specified the method return the value of the specified key in the current locale object.
         * @param callback (optional) The optional method to launch after the initialization over the specified object. 
         */
        public function init( o:Object , sID:String=null , callback:Function=null ):void
        {
            var init:* = getLocale( sID ) ;
			if ( init != null )
			{
            	for (var prop:String in init)
            	{
	                o[prop] = init[prop] ;    
            	}
			}
            if ( callback != null )
            {
                callback.call(o) ;    
            }
        } 
        
        /**
         * Returns <code class="prettyprint">true</code> if the Localization model is empty.
         * @return <code class="prettyprint">true</code> if the Localization model is empty.
         */
        public function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }

        /**
         * Notify when the Localization change.
         */
        public function notifyChange():void 
        {
        	if ( !isLocked() )
        	{
            	dispatchEvent( new LocalizationEvent( _sTypeCHANGE , this ) ) ;
        	}
        }
        
        /**
         * Puts the specified Locale object with the passed-in Lang reference.
         */
        public function put( lang:* , oL:Locale ):* 
        {
            if ( Lang.validate( lang ) )
            {
                return _map.put( _getID( lang ) , oL ) ;
            }
            else
            {
                return null ;    
            }
        }

        /**
         * Releases the specified <code class="prettyprint">Localization</code> singleton with the specified name in argument.
         * @return the reference of the removed Localization object.
         */
        public static function release( id:String ):Localization 
        {
            if (id == null) 
            {
                id = Localization.DEFAULT_ID ;
            }
            return Localization.__mInstances.remove(id) ;
        }

        /**
         * Removes the specified Lang in the Localization model.
         * @param lang a valid Lang object. This argument is valid if the Lang.validate method return <code class="prettyprint">true</code>.
         * @return The removed Locale object or null.
         */
        public function remove( lang:* ):* 
        {
            if ( Lang.validate(lang) ) 
            {
                return _map.remove( _getID( lang ) ) ;
            }
            else
            {
                return null ;    
            }
        }
        
        /**
         * Returns the event type use in the notifyChange ethod.
         * @return the event type use in the notifyChange method.
         */
        public function setEventTypeCHANGE( type:String ):void
        {
           _sTypeCHANGE = type || CHANGE ;
        }
        
        /**
         * Returns the number of Lang elements in the Localization singleton.
         * @return the number of Lang elements in the Localization singleton.
         */
        public function size():uint 
        {
            return _map.size() ;
        }
        
        /**
          * Returns the <code class="prettyprint">String</code> representation of this object.
          * @return the <code class="prettyprint">String</code> representation of this object.
          */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( this.id != null )
            {
                str += " " + this.id ;    
            } 
            str += "]" ;
            return str ;
        }    

        /**
         * @private
         */
        private var _current:Lang = null ;
        
        /**
         * @private
         */
        private var _evaluator:PropertyEvaluator ;
        
        /**
         * @private
         */
        private var _id:* ;
        
        /**
         * @private
         */
        private var _loader:ILocalizationLoader ;        

        /**
         * @private
         */
        private var _map:HashMap = null ;
        
        /**
         * @private
         */
        private static var __mInstances:HashMap = new HashMap() ;
        
        /**
         * @private
         */
        private var _sTypeCHANGE:String = LocalizationEvent.CHANGE ;
        
        /**
         * Returns the id of the specified argument.
         * @return the id of the specified argument.
         * @private 
         */
        private function _getID( lang:* ):String
        {
            var id:String ;
            if ( lang is Lang )
            {
                id = lang.value ;
            }
            else if ( lang is String )
            {
                id = lang as String ;    
            }
            else
            {
                id = null ;    
            }
            return id ;
        }
        
		/**
		 * Internal method to register the Localization object in the static singleton HashMap of the class.
		 * @see ModelCollector.
		 * @private
		 */
		private function _setID( id:* ):void 
		{
			
			if ( id == null )
			{
				id = DEFAULT_ID ;
			}
			
			if ( __mInstances.containsKey(id) )
			{
				throw new IllegalOperationError( this + " a Localization reference with the specified id '" + id + "' is already register." ) ;
			}
			
            _id = id ;
			
			if ( this._id != null )
			{
				__mInstances.put(id, this) ;
			}
			
		}        
    }
}

