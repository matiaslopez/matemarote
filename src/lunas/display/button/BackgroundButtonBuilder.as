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
    import flash.display.DisplayObject;
    
    import asgard.display.CoreSprite;
    
    import lunas.core.AbstractButtonBuilder;
    import lunas.events.ButtonEvent;
    
    import pegas.colors.LightColor;
    import pegas.draw.IFillStyle;
    import pegas.draw.ILineStyle;
    import pegas.draw.RectanglePen;
    import pegas.draw.RoundedComplexRectanglePen;
    import pegas.transitions.TweenLite;    

    /**
	 * The IBuilder class of the BackgroundButton component.
	 */
	public class BackgroundButtonBuilder extends AbstractButtonBuilder 
	{

		/**
		 * Creates a new BackgroundButtonBuilder instance.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function BackgroundButtonBuilder(target:DisplayObject, bGlobal:Boolean = false, sChannel:String = null)
		{
			super( target, bGlobal, sChannel );
		}
		
		/**
		 * The background reference of the component.
		 */
		public var background:CoreSprite ;		
		
  		/**
	     * Clear the view of the component.
	     */
    	public override function clear():void 
    	{
    		if ( background != null )
    		{
	        	(target as BackgroundButton).removeChild( background ) ;
	        	background = null ;
    		}
	    }
		
		/**
		 * Invoked when the button is down.
		 */
		public function disabled( e:ButtonEvent = null ):void
		{
	    	var b:BackgroundButton      = target as BackgroundButton ;	
         	var s:BackgroundButtonStyle = b.style as BackgroundButtonStyle ;
			refreshBackground( s.themeDisabled ) ;
		}
		
		/**
		 * Invoked when the button is down.
		 */
		public function down( e:ButtonEvent = null ):void
		{
	    	var b:BackgroundButton      = target as BackgroundButton ;	
         	var s:BackgroundButtonStyle = b.style as BackgroundButtonStyle ;
			refreshBackground( s.themeSelected ) ;
			_resetLightTween() ;
        	if ( s.tweenSelected != null )
        	{
	            _lightTw        = s.tweenSelected.clone() ;
            	_lightTw.target = _lightColor ;
            	_lightTw.run() ;
        	}
		}			
		
		/**
		 * Initialize all register type of this builder.
		 */
		public override function initType():void
		{
			registerType( ButtonEvent.DISABLED , disabled ) ;
			registerType( ButtonEvent.DOWN     , down     ) ;
			registerType( ButtonEvent.OVER     , over     ) ;
			registerType( ButtonEvent.UP       , up       ) ;
		}			
		
    	/**
	     * Invoked when the button is over.
	     */
	    public function over( e:ButtonEvent = null ):void 
	    {
    		var b:BackgroundButton      = target as BackgroundButton ;	
         	var s:BackgroundButtonStyle = b.style as BackgroundButtonStyle ;
         	refreshBackground( s.themeRollOver, s.themeBorderRollOver ) ;
			_resetLightTween() ;
        	if ( s.tweenOver != null )
        	{
	            _lightTw        = s.tweenOver.clone() ;
            	_lightTw.target = _lightColor ;
            	_lightTw.run() ;
        	}        
		}
		
		/**
		 * Register the scope of the light effect of the component.
		 */
		public function registerLight( target:DisplayObject ):void
		{
			_lightColor = new LightColor( target ) ;	
		}
		
		/**
	 	 * Runs the build of the component.
		 */
		public override function run(...arguments:Array):void
		{
         	background     = new CoreSprite() ;
         	_backgroundPen = new RoundedComplexRectanglePen( background ) ;
         	registerLight( background ) ;
         	(target as BackgroundButton).addChild( background ) ;
    	}
    
	    /**
	     * Invoked when the button is up.
	     */
    	public function up( e:ButtonEvent = null ):void 
	    {
        	refreshBackground() ;
    	}

	    /**
	     * Update the view of the component.
	     */
    	public override function update():void 
	    {
        	refreshBackground() ;
    	}		
		
	    /**
	     * Refresh the internal background.
	     */
    	protected function refreshBackground( theme:IFillStyle=null , themeBorder:ILineStyle=null ):void
    	{
	    	var b:BackgroundButton      = target as BackgroundButton ;	
         	var s:BackgroundButtonStyle = b.style as BackgroundButtonStyle ;
         	if ( b != null && s != null )
         	{
                _backgroundPen.line = (themeBorder != null) ? themeBorder : ( b.enabled ? ( b.selected ? s.themeBorderSelected : s.themeBorder) : s.themeBorderDisabled ) ; 
                _backgroundPen.fill = (theme != null) ? theme : ( b.enabled ? ( b.selected ? s.themeSelected : s.theme ) : s.themeDisabled ) ; 
                _backgroundPen.draw( 0, 0, b.w, b.h , s.topLeftRadius , s.topRightRadius , s.bottomLeftRadius , s.bottomRightRadius, s.align ) ;
         	}
    	}
    
        /**
         * @private
         */
	    private var _backgroundPen:RoundedComplexRectanglePen ;
		     
	    /**
	     * @private
	     */ 
    	private var _lightColor:LightColor ;
		     
        /**
         * @private
         */
    	private var _lightTw:TweenLite ;    
    	
    	/**
	     * @private
	     */
    	private function _resetLightTween():void
    	{
    		if( _lightTw != null && _lightTw.running )
			{
				_lightTw.stop() ;
				_lightTw = null ;
			}	
    	}  
				
	}
}
