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
package asgard.net 
{
    import flash.display.DisplayObjectContainer;
    
    import system.evaluators.MultiEvaluator;    

    /**
     * This manager register the reference of the <code class="prettyprint">parameters</code> object of the root of your application.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package
     * { 
     *      
     *      import asgard.net.FlashVars ;
     *      
     *      import flash.display.Sprite ;
     * 
     *      // Main class of your application.
     *      public class Main extends Sprite
     *      {
     *      	
     *      	// constructor
     *      	public function Main()
     *      	{
     *      	
     *      		flashVars = new FlashVars( this ) ; // register the FlashVars of the application
     *      		
     *      		trace( flashVars.contains( "test" ) ) ; // true if the flash vars exist
     *      		
     *      		trace( flashVars.getValue("test") ) ; // The value of the FlashVars or null if not exist.
     *      	
     *      	}
     *      	
     *      	// The static reference of all FlashVars in the application.
     *      	public static var flashVars:FlashVars ;
     *      		
     *      }
     *      
     * }
     * </pre>
     * @author eKameleon
     */
    public class FlashVars 
    {
    	
    	/**
    	 * Creates a new FlashVars instance.
    	 * @param root The root of the application to resolve the FlashVars generic object (in the loaderInfo.parameters in AS3 main class).
    	 */
    	public function FlashVars( root:DisplayObjectContainer ):void
    	{
    		parameters            = root.loaderInfo.parameters || null ;
    		_evaluators           = new MultiEvaluator() ;
    		_evaluators.autoClear = true ;
        }
    	
    	/**
    	 * Defines the flashvars parameters object of the application. 
    	 */
    	public function get parameters():Object
    	{
    		return _parameters ;
    	}
    	
    	/**
    	 * Defines the flashvars parameters object of the application. 
    	 */
    	public function set parameters( o:Object ):void
    	{
    		_parameters = o ;
    	}    	
    	
    	/**
    	 * Indicates if the FlashVars manager contains the specified variable. 
    	 */
    	public function contains( name:String ):Boolean
    	{
    		return 	( _parameters != null ) && ( name in _parameters ) && ( _parameters[name] != null ) ;
    	}
    	
    	/**
    	 * Returns the value of the specified variable in the FlashVars of the application.
    	 * @param name The name of the variable to resolve in the parameters object of the application.
    	 * @param ...rest (optional) All <code class="prettyprint">IEvaluator</code> objects used to evaluate and initialize the value of the specified FlashVars.
    	 * <p><b>Example :</b></p>
    	 * <pre class="prettyprint">
    	 * import asgard.net.FlashVars ;
    	 * import system.evaluators.* ;
    	 *  
    	 * var value:String = flashVars.getValue("date", new EdenEvaluator(false), new DateEvaluator()) ;
    	 * trace( "result : " + value ) ; // result : "12.06.2006 16:12:24" with the original "date" flashvars value : "new Date(2006,5,12,16,12,24)"
    	 * </pre>
    	 * @return the value of the specified variable in the FlashVars of the application.
    	 */
    	public function getValue( name:String , ...rest:Array ):*
    	{
    		if ( contains(name) )
    		{
    			_evaluators.add( rest ) ;
    			return _evaluators.eval(_parameters[name]) ;
    		}
    		else
    		{
    			return null ;	
    		}
    	}
    	
        /**
         * @private
         */
        private var _evaluators:MultiEvaluator ;    	
    	
    	/**
    	 * @private
    	 */
    	private var _parameters:Object ;
    	
    }
}
