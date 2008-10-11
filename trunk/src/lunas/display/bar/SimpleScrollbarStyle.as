/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.display.bar 
{
	import lunas.core.AbstractStyle;
	import lunas.core.EdgeMetrics;			

	/**
	 * The IStyle object of the SimpleScrollbar component.
	 * @author eKameleon
	 */
	public class SimpleScrollbarStyle extends AbstractStyle 
	{

		/**
		 * Creates a new SimpleScrollbarStyle instance.
		 * @param id The id of the object.
		 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
		 */
		public function SimpleScrollbarStyle( id:*=null , init:*=null )
		{
			super( id, init );
		}
		
		/**
		 * The array of flash.filters objects of the bar.
		 */
		public var barFilters:Array ;
		
		/**
		 * The padding between the arrow buttons and the bar.
		 */
		public var padding:EdgeMetrics = new EdgeMetrics(1,1,1,1) ;

		/**
		 * The array of flash.filters objects of the thumb.
		 */
		public var thumbFilters:Array ;
		

	}
}
