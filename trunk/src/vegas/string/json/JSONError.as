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

package vegas.string.json
{
	import vegas.errors.FatalError;

    /**
     * This JSONError is throw in the JSON static methods.
     * @author eKameleon
     */
	public class JSONError extends FatalError
	{

    	/**
    	 * Creates a new JSONError instance.
    	 */
		public function JSONError(message:String, at:uint, source:String)
		{
			super(message);
			this.at = at ;
			this.source = source ;
		}
		
		/**
		 * The position of char with an error parsing in the JSON String representation.
		 */
		public var at:uint ;
		
		/**
		 * The String source representation with a bad parsing.
		 */
		public var source:String ;
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public override function toString():String 
        {
            var msg:String = "## " + name + " : " + message + " ##" ;
            if (!isNaN(at)) msg += ", at:" + at ;
			if (source) msg += " in \"" + source + "\"";
		    log(msg) ;
		    return msg ;
            
        }

	}
}