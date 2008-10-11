/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Laurent Marlin <contact@mediaboost.fr> 

*/
package lunas.display.button 
{
    import lunas.core.EdgeMetrics;
    
    import pegas.draw.FillStyle;
    import pegas.draw.LineStyle;    

    /**
	 * The IStyle class of the IconButton component.
	 */
	public class IconButtonStyle extends LabelButtonStyle 
	{
		/**
		 * Creates a new IconButtonStyle instance.
		 * @param id The id of the object.
		 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored.
    	 * @param bGlobal the flag to use a global event flow or a local event flow.
    	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function IconButtonStyle(id:* = null, init:* = null)
		{
			super( id, init );
		}
		
		/**
		 * Indicates the height value of the label field of the component.
		 */
		public var height:Number ;
		
		/**
		 * Indicates the width value of the label field of the component.
		 */
		public var width:Number ;
		
		/**
	     * Initialize the IStyle object.
     	 */
	    public override function initialize():void 
	    {
	    	super.initialize() ;
	    	margin      = new EdgeMetrics( 6, 0, 4, 0 ) ;	    	
			padding     = new EdgeMetrics( 6, 2, 2, 2 ) ;
        	theme       = new FillStyle( 0xA2A2A2 , 0.5 ) ;
        	themeBorder = new LineStyle( 2 , 0xFFFFFF , 0.5 ) ;
    	}
	}
}
