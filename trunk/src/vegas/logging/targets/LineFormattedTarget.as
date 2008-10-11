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

package vegas.logging.targets
{
	import vegas.logging.AbstractTarget;
	import vegas.logging.LogEvent;
	import vegas.logging.LogEventLevel;    

	/**
	 * All logger target implementations that have a formatted line style output should extend this class. It provides default behavior for including date, time, category, and level within the output.
	 * @author eKameleon
	 */
    public class LineFormattedTarget extends AbstractTarget
    {
        
		/**
		 * Creates a new LineFormattedTarget instance.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
        public function LineFormattedTarget( bGlobal:Boolean = false , sChannel:String = null )
        {
			super( bGlobal , sChannel );
        }
        
    	/**
         * Indicates if the category for this target should added to the trace.
         */
	    public var includeCategory:Boolean = false ;
	    
    	/**
         * Indicates if the date should be added to the trace.
         */
    	public var includeDate:Boolean = false;
    	
    	/**
         * Indicates if the level for the event should added to the trace.
         */
	    public var includeLevel:Boolean = false ;
	    
    	/**
         * Indicates if the line for the event should added to the trace.
         */
    	public var includeLines:Boolean = false ; 

	  	/**
		 * Indicates if the milliseconds should be added to the trace. Only relevant when includeTime is <code class="prettyprint">true</code>.
	     */
  		public var includeMilliseconds:Boolean = false ;

    	/**
         * Indicates if the time should be added to the trace.
         */
	    public var includeTime:Boolean = false ;

        /**
         * The separator string.
         */
        public var separator:String = " " ;

	   	/**
    	 * Descendants of this class should override this method to direct the specified message to the desired output.
    	 *
    	 * @param message String containing preprocessed log message which may include time, date, category, etc. 
    	 *        based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeCategory</code>, etc.
	     */
	    public function internalLog( message:* , level:LogEventLevel ):void
	    {
	        // override this method.
	    }
	    
        /**
         *  This method handles a <code class="prettyprint">LogEvent</code> from an associated logger.
         *  A target uses this method to translate the event into the appropriate
         *  format for transmission, storage, or display.
         *  This method will be called only if the event's level is in range of the target's level.
         */		
		public override function logEvent(event:LogEvent):void
        {
           
            var message:* = event.message ;
            var level:String = LogEvent.getLevelString(event.level) ;
            var category:String = event.currentTarget.category ;
            
            message = formatMessage(message, level, category, new Date() ) ;
            internalLog ( message , event.level ) ;
        
        }

		/**
		 * This method format the passed Date in arguments.
		 */
	    protected function formatDate( d:Date ):String 
	    {
		    var date:String = "" ;
        	date += getDigit(d.getDate()) ;
		    date += "/" + getDigit(d.getMonth() + 1) ;
		    date += "/" + d.getFullYear();
		    return date ;
	    }
	    
   		/**
		 * This method format the passed level in arguments.
		 */
	    protected function formatLevel(level:String):String 
	    {
		    return '[' + level + ']' ;
	    }	

		/**
		 * This method format the current line value.
		 */
	    protected function formatLines():String 
	    {
		    return "[" + __lineNumber++ + "]" ; 
	    }	

		/**
		 * This method format the log message.
		 */
    	protected function formatMessage(message:*, level:String, category:String, date:Date):String 
    	{
	    	
	    	var msg:String = "" ;
       		
       		var d:Date = date || new Date ;
    		
    		if (includeLines) 
    		{
    		    msg += formatLines() + separator ; // lines
    		}
    		
    		if (includeDate) 
    		{
    		    msg += formatDate(d) + separator ; // date
    	    }
    		
    		if (includeTime) 
    		{
    		    msg += formatTime(d) + separator ; // time
    		}
    		
    		if (includeLevel)
    		{
    		    msg += formatLevel(level || "" ) + separator ; // level  
    		} 
    		
    		if (includeCategory) 
    		{
        		msg += (category || "") + separator ; // category
    		}
    		
    		msg += message.toString() ;
	    	
	    	return msg ;
	    	
    	}

		/**
		 * This method format the current Date passed in argument.
		 */
    	protected function formatTime(d:Date):String 
    	{
		    var time:String = "" ;
    		time += getDigit(d.getHours()) ;
    		time += ":" + getDigit(d.getMinutes()) ;
    		time += ":" + getDigit(d.getSeconds()) ;
			if( includeMilliseconds ) 
			{
	      		time += ":" + getDigit(d.getMilliseconds()) ;
	    	}
    		return time ;
    	}

		/**
		 * Returns the string representation of a number and use digit conversion.
		 */
	    protected function getDigit(n:Number):String 
	    {
		    if (isNaN(n)) return "00" ;
    		return ((n < 10) ? "0" : "") + n ;
    	}
        
        /**
         * @private
         */
	    private var __lineNumber:Number = 1 ;
        
    }
}