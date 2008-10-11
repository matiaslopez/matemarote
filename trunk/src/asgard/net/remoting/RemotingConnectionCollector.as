/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard AS3 Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.net.remoting
{
    import asgard.net.remoting.RemotingConnection;
    
    import vegas.data.map.HashMap;
    import vegas.errors.Warning;    

    /**
	 * This collector use a Map to register all RemotingConnection in the application.
 	 * @author eKameleon
	 */
	public class RemotingConnectionCollector
	{

		/**
		 * Removes all RemotingConnection reference in the collector.
	 	 */
		public static function clear():void
		{
			_map.clear() ;	
		}
		
		/**
	 	 * Returns <code class="prettyprint">true</code> if the collector contains the RemotingConnection register with the name passed in argument.
	 	 * @return <code class="prettyprint">true</code> if the collector contains the RemotingConnection register with the name passed in argument.
	 	 */
		public static function contains( sName:String ):Boolean 
		{
			return _map.containsKey( sName ) ;	
		}

		/**
		 * Returns the RemotingConnection reference with the name passed in argument.
		 * @return the RemotingConnection reference with the name passed in argument.
		 */
		public static function get( name:String ):RemotingConnection 
		{
			if (!contains(name) ) 
			{
				throw new Warning("[RemotingConnectionCollector].get(\"" + name + "\"). Can't find RemotingConnection instance." ) ;
			}
			return RemotingConnection(_map.get(name)) ;	
		}
		
		/**
		 * Insert a RemotingConnection in the collector and indexed it with the string name in the first parameter.
		 * @param name the name of the RemotingConnection object to register it.
		 * @param rc the RemotingConnection reference. 
		 */
		public static function insert( name:String, rc:RemotingConnection ):Boolean 
		{
			try 
			{
				if ( contains(name) ) 
				{
					throw new Warning("[RemotingConnectionCollector].insert(). A RemotingConnection instance is already registered with '" + name + "' name." ) ;
				}
			}
			catch (e:Warning) 
			{
				e.toString() ;
			}
			return Boolean( _map.put(name, rc) )   ;	
			
		}
	
		/**
	 	 * Returns <code class="prettyprint">true</code> if the collector is empty.
		 * @return <code class="prettyprint">true</code> if the collector is empty.
		 */
		public static function isEmpty():Boolean 
		{
			return _map.isEmpty() ;	
		}
	
		/**
		 * Removes the RemotingConnection in the collector specified by the argument <code class="prettyprint">sName</code>.
	 	 */
		public static function remove(sName:String):void
		{
			_map.remove(sName) ;
		}

		/**
		 * Returns the number of elements in the collector.
		 * @return the number of elements in the collector.
		 */
		public static function size():uint
		{
			return _map.size() ;
		}
		
		/**
		 * @private
		 */
		private static var _map:HashMap = new HashMap() ;	
		
	}


}