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
	import vegas.core.CoreObject;
	import vegas.util.Serializer;	

	/**
	 * Defines the information object in a onStatus callback method.
	 * @author eKameleon
	 * @version 1.0.0.0
	 */	
	public class NetServerInfo extends CoreObject
	{
		
		/**
		 * Creates a new NetServerInfo object.
		 * @param oInfo a primitive object with the properties 'code', 'level', 'description' and 'application'.
		 */
		public function NetServerInfo( oInfo:* = null )
		{

			if ( oInfo != null )
			{

				description  = oInfo.description || null ;
				code         = oInfo.code ;
				level        = oInfo.level ;
				application  = oInfo.application || null ;
			}
		
			_oInfo = toObject() ;
		
		}

		/**
		 * This object exist if the server return an application error object. 
		 * This property exist with FMS when the SSAS <code class="prettyprint">application.rejectConnection()</code> method is invoked. 
	  	 */
		public var application:* ;

		/**
		 * The code of this information object.
		 */
		public var code:String = null ;

		/**
		 * The description of this information object.
		 */
		public var description:String = null ;

		/**
		 * The level of this information object.
		 */
		public var level:String = null ;

        /**
         * Returns an object representation of this instance.
         * @return an object representation of this instance.
         */ 	
		public function toObject():Object 
		{
			return { description:description, code:code, level:level , application:application } ;
		}

        /**
         * Returns a Eden represensation of the object.
         * @return a string representing the source code of the object.
         */
		public override function toSource( indent:int = 0 ):String 
		{
			return "new asgard.net.NetServerInfo(" + Serializer.toSource(toObject()) + ")" ;
		}

		/**
		 * Returns the String representation of this object.
		 * @return the String representation of this object.
		 */
		public override function toString():String
		{
			var s:String = "[NetServerInfo" ;
			if (code != null)
			{
				s += ",code:'" + code + "'" ;	
			}
			if (level != null)
			{
				s += ",level:'" + level + "'" ;	
			}
			if (description != null)
			{
				s += ",description:'" + description + "'" ;	
			}
			if (application != null)
			{
				s += ",application:" + application  ;	
			}
			s += "]" ;
			return s ;
		}
	
		private var _oInfo:Object ;
		
	}
}