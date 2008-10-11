/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  - Marc Alcaraz <ekameleon@gmail.com>
*/

package system.serializers.eden
    {
    import system.Configurator;
    import system.eden;
    
	/**
	 * The configurator object of the eden parser.
	 */
    public class EdenConfigurator extends Configurator
        {
        
		/**
		 * Creates a new EdenConfigurator instance.
		 * @param config This argument initialize the configurator with a generic object.
		 */
        public function EdenConfigurator( config:Object )
            {
            super( config );
            }
        
		/**
		 * Allows to execute function call. if set to false it blocks any functrion call and return undefined.
		 * <p><b>Example:</b></p>
		 * <pre class="prettyprint">
		 * "titi = \"hello world\";
		 * toto = titi.toUpperCase();"
		 * 
		 * // allowFunctionCall = true
		 * toto = "HELLO WORLD"
		 * 
		 * // allowFunctionCall = false
		 * toto = undefined
		 * </code>
		 */
        public function get allowFunctionCall():Boolean
            {
            return _config.allowFunctionCall;
            }

		/**
		 * @private
		 */
        public function set allowFunctionCall( value:Boolean ):void
            {
            _config.allowFunctionCall = value;
            }
        
		/**
		 * When set to false array index are evaluated without bracket eval( test.0 ) for Flash ActionScript
		 * When set to true array index are evaluated with bracket eval( test[0] ) for JavaScript, JScript, JSDB etc.
		 */
        public function get arrayIndexAsBracket():Boolean
            {
            return _config.arrayIndexAsBracket; // TODO : may become obsolete for AS3/ES4 but let's keep it for now for configuration file backward compatibility
            }
        
		/**
		 * @private
		 */
        public function set arrayIndexAsBracket( value:Boolean ):void
            {
            _config.arrayIndexAsBracket = value;
            }
            
		/**
		 * List of authorized keywords, objects path and constructors that the parser is allowed to interpret.
		 * <p>Note: you can add full path</p>
		 * <p><b>ex:</b> "blah.foobar"</p>
		 * <p>and/or starting path</p>
		 * <p><b>ex:</b> "toto.titi.*"</p>
		 * <p>The difference is with a full path you can only <b>create/use/define/assign</b> value to this exact path and
		 * with a starting path you can create/use/define/assign value to this path and its child paths.</p> 
		 * <p><b>Attention:</b> special values as NaN, true, false, null, undefined are always authorized.</p>
		 */
        public function get authorized():Array
            {
            return _config.authorized;
            }
        
		/**
		 * @private
		 */
        public function set authorized( value:Array ):void
            {
            _config.authorized = value;
            }
		
		/**
		 * Determinates if the add scope process is automatic or not.
		 */
        public function get autoAddScopePath():Boolean
            {
            return _config.autoAddScopePath;
            }
        
		/**
		 * @private
		 */
        public function set autoAddScopePath( value:Boolean ):void
            {
            _config.autoAddScopePath = value;
            }

        
		/**
		 * Parameter to remove (true) or add (false) all unecessary spaces, tabs, carriages returns, lines feeds etc. 
		 * to optimize (more or less) packets of datas when they are transfered.
		 * <p><b>Note 1 :</b> use "compress = false" when you want to have a better view or debug packets of datas.</p>
		 * <p><b>Note 2 :</b> this property is in sync with eden.prettyPrint</p>
		 */
        public function get compress():Boolean
            {
            return _config.compress;
            }
        
		/**
		 * @private
		 */
        public function set compress( value:Boolean ):void
            {
            _config.compress = value;
            eden.prettyPrinting = value;
            }
        
		/**
		 * Parameter allowing to copy objects by value if true or by reference if false.
		 * <p><b>Example :</b></p>
		 * <code class="prettyprint">
		 * foo = {a:1, b:2, c:3};
		 * bar = foo;
		 * </code>
		 * In this case with copyObjectByValue = false
		 * bar will be a reference to the foo object
		 * but if copyObjectByValue = true
		 * bar will be an exact copy of foo object 
		 */
        public function get copyObjectByValue():Boolean
            {
            return _config.copyObjectByValue;
            }
		/**
		 * @private
		 */
        public function set copyObjectByValue( value:Boolean ):void
            {
            _config.copyObjectByValue = value;
            }
        
		/**
		 * Allows to define the case-sensitivy of the parsers.
		 * If true, variable names that differ only in case are considered different.
		 */
        public function get strictMode():Boolean
            {
            return _config.strictMode;
            }
		/**
		 * @private
		 */
        public function set strictMode( value:Boolean ):void
            {
            _config.strictMode = value;
            }
        
		/**
		 * Value assigned to a variable	when this one is not found or not authorized.
		 * Depending on your environment you can override it with a more suitable one for exemple on C# you could set it to null.
		 */
        public function get undefineable():*
            {
            return _config.undefineable;
            }
       
		/**
		 * @private
		 */
        public function set undefineable( value:* ):void
            {
            _config.undefineable = value;
            }
        
		/**
		 * Parameter allowing to trace messages in the console if the environment permit it.
		 */
        public function get verbose():Boolean
            {
            return _config.verbose;
            }
        
		/**
		 * @private
		 */
        public function set verbose( value:Boolean ):void
            {
            _config.verbose = value;
            }
        
		/**
		 * Parameter setting on (true) or off (false) the security.
		 * If true, all object path, function or constructor will be scanned at interpretation time against the authorized list.
		 * @see system.serializers.eden.config.authorized.
		 */
        public function get security():Boolean
            {
            return _config.security;
            }
        
		/**
		 * @private
		 */
        public function set security( value:Boolean ):void
            {
            _config.security = value;
            }
        
   		/**
		 * Inserts an authorized path in the white list of the parser.
		 */
	    public function addAuthorized( ...arguments:Array ):void
        	{
			var a:Array = _config.authorized as Array ;
			if ( a != null )
				{
    	    	var l:uint  = arguments.length ;
        		for( var i:Number = 0 ; i<l; i++ )
            		{
	            	if( ! a.indexOf( arguments[i] ) > -1 )
                		{
		                a.push( arguments[i] );
                		}
            		}
        		}
        	else
	        	{
        		throw new Error( this + " addAuthorized failed with a null 'authorized' Array to configurate the eden parser.") ;
				}
        	}        
        
   		/**
		 * Removes an authorized path in the white list of the parser.
		 */
	    public function removeAuthorized( ...arguments:Array ):void
        	{
    	    var paths:* ;
    	    var i:uint ;
    	    var found:* ;
    	    
	        paths = [].concat(arguments) ;
			
        	var l:uint = paths.length ;
        	for( i=0; i < l ; i++ )
           	 {
	            found = _config.authorized.indexOf( paths[i] );
	            if( found > -1 )
                	{
    	           _config.authorized.splice( found, 1 );
                	}
            	}
        	}
        
        }
    
    }

