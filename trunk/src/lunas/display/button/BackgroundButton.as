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
    import flash.events.Event;
    
    import lunas.core.AbstractButton;    

    /**
	 * The basic BackgroundButton component.
     * <pre class="prettyprint">
     * import lunas.display.button.BackgroundButton ;
     * 
     * var bt:LabelButton = new BackgroundButton() ;
     * bt.x               = 25 ;
     * bt.y               = 50 ;
     * bt.toggle          = true ;
     * 
     * addChild(bt) ;
     * </pre>
	 */
	public class BackgroundButton extends AbstractButton 
	{

		/**
		 * Creates a new BackgroundButton instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
	 	 */	
		public function BackgroundButton(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{
			super( id, isConfigurable, name );
			setSize( 120, 20) ;
		}
		
		/**
	     * Returns the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
	     * @return the <code class="prettyprint">IBuilder</code> constructor use to initialize this component.
	     */
    	public override function getBuilderRenderer():Class 
    	{
	        return BackgroundButtonBuilder ;
	    } 
	    
	    /**
     	 * Returns the <code class="prettyprint">IStyle</code> constructor use to initialize this component.
	     * @return the <code class="prettyprint">IStyle</code> constructor use to initialize this component.
     	 */
    	public override function getStyleRenderer():Class 
    	{
	        return BackgroundButtonStyle ;
	    }
     		
    	/**
	     * Invoked when the component IStyle changed.
	     */
    	public override function viewStyleChanged( e:Event=null ):void 
	    {
	        update() ;
	    }
        		
	}
}
