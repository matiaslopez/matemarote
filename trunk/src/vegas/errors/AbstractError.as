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

package vegas.errors
{
    import system.Reflection;
    
    import vegas.core.HashCode;
    import vegas.core.IHashable;
    import vegas.logging.ILogable;
    import vegas.logging.ILogger;
    import vegas.logging.Log;
    import vegas.logging.LogEventLevel;	

    /**
	 * This class provides a Abstract implementation to creates Error classes with an internal logging model. 
	 * @author eKameleon
 	 */
    internal class AbstractError extends Error implements IHashable, ILogable
    {
        
		/**
		 * Creates a new AbstractError only if you inherit this class.
		 */
        public function AbstractError(message:String="", id:int=0)
        {
            super(message, id);
            name    = Reflection.getClassName(this) ;
            _logger = Log.getLogger( Reflection.getClassPath(this) ) ;
            
        }
		
		/**
		 * Returns the category value of the internal ILogger of this object.
		 * @return the category value of the internal ILogger of this object.
		 */
    	public function getCategory():String 
    	{
		    return _logger.category ;
    	}
    	
   		/**
		 * Returns the internal LogEventLevel used in the constructor of this instance.
	 	 * You can overrides this method if you want change the internal LogEventLevel of the error.
		 */
		public function getLevel():LogEventLevel
		{
			return LogEventLevel.ERROR ;	
		}
	    
		/**
		 * Returns the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">ILogable</code> object.
		 * @return the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">ILogable</code> object.
		 */
		public function getLogger():ILogger
	    {
		    return _logger ;
    	}
    	
		/**
		 * Returns a hashcode value for the object.
		 * @return a hashcode value for the object.
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
		 * Launch the external log of this error.
		 * @param msg The optional message to log in the internal ILogger of this ILogable object.
	 	 */
		public function log( msg:String=null ):void
		{
		    if ( getLogger() != null )
	        {
			    getLogger().log( getLevel() , (msg != null) ? msg : name + " : " + message ) ;
	        }
		}

		/**
		 * Sets the internal <code class="prettyprint">ILogger</code> reference of this <code class="prettyprint">ILogable</code> object.
		 */
		public function setLogger( log:ILogger=null ):void 
		{
			_logger = log || Log.getLogger( Reflection.getClassPath(this) ) ;
		}

		/**
		 * Returns the string representation of this instance.
		 * @return the string representation of this instance
	 	 */
	    public function toString( ):String 
	    {
            log() ;
		    return name + " " + message ;
    	}

		/**
		 * @private
		 */
		private var __hashcode__:Number = NaN ;
		
		/**
		 * @private
		 */
    	private var _logger:ILogger ;

    }
}