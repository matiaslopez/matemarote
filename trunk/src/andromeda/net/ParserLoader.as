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

package andromeda.net
{
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    
    import system.Serializer;    

    /**
	 * This loader use a parse external data and deserialize it. 
	 * @author eKameleon
	 */
	public class ParserLoader extends URLLoader
	{
		
        /**
         * Creates a new ParserLoader instance.
         * @param request The URLRequest of the file to load.
         */ 
		public function ParserLoader( request:URLRequest=null )
		{
			super( request );
			addEventListener( Event.COMPLETE, complete ) ;
		}

		/**
		 * Use a Sserializer object to deserialize the external data if this property is <code class='prettyprint'>true</code>.
		 */
		public var isDeserialize:Boolean = true ;	

		/**
		 * Indicates the ISerializer object use to deserialize the external datas.
		 */
		public function get serializer():Serializer
		{
            return _serializer ;	
		}
		
		/**
		 * @private
		 */
        public function set serializer( serializer:Serializer ):void
        {
            _serializer = serializer ;  
        }		
		
		/**
		 * Invoked when the loader process is complete to parse the datas.
		 */
		protected function complete(e:Event):void
		{
			switch (dataFormat) 
			{
			
				case URLLoaderDataFormat.TEXT :
				{
					if ( serializer != null && isDeserialize )
					{
						data = serializer.deserialize(data) ;
					}
					
					break ;
			    }
				case URLLoaderDataFormat.VARIABLES :
				{
					
					data = new URLVariables(data) ;
					if ( serializer != null && isDeserialize )
					{
						for (var prop:String in data)
						{
							data[prop] = serializer.deserialize( data[prop] ) ;
						}
					}
					break ;
                }
				case URLLoaderDataFormat.BINARY :
				default :
				{
					//
					break ;
                }
			}
			
		}
		
		/**
		 * @private
		 */
		private var _serializer:Serializer ;
    }
}