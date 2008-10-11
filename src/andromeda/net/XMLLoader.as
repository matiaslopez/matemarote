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

    /**
	 * This loader load an external XML file.
	 * @author eKameleon
	 */
	public class XMLLoader extends URLLoader
	{
		
        /**
         * Creates a new XMLLoader instance.
         * @param request The URLRequest of the file to load.
         */ 
		public function XMLLoader( request:URLRequest=null )
		{
			super( request );
            addEventListener( Event.COMPLETE, complete ) ;			
		}

		/**
		 * Invoked when the loader process is complete to parse the datas.
		 */
		protected function complete(e:Event):void
		{
			if ( URLLoaderDataFormat.TEXT ) 
			{
    			try
				{
				   data = new XML( data as String ) ;
				}
				catch( er:Error )
				{
				   	data = null ;
				}
			}
		}
        		
    }
}