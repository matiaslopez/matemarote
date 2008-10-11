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
  
*/
package lunas.display.button 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.filters.GradientGlowFilter;
	
	import asgard.display.CoreShape;
	import asgard.text.CoreTextField;
	
	import lunas.core.AbstractButtonBuilder;
	import lunas.events.ButtonEvent;
	
	import pegas.colors.LightColor;
	import pegas.draw.FillStyle;
	import pegas.draw.RoundedComplexRectanglePen;
	import pegas.transitions.Tween;	

	/**
	 * The IBuilder class of the AquaButton component.
	 */
	public class AquaButtonBuilder extends AbstractButtonBuilder 
	{
		
		/**
		 * Creates a new AquaButtonBuilder instance.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function AquaButtonBuilder( target:DisplayObject , bGlobal:Boolean = false, sChannel:String = null)
		{
			super( target, bGlobal, sChannel );
		}
		
		/**
		 * The background reference of the component.
		 */
		public var background:CoreShape ;
			
	    /**
	     * The light color reference of the builder.
	     */
    	public var backgroundColor:LightColor ;
		
		/**
		 * The IPen of the background.
		 */
		public var backgroundPen:RoundedComplexRectanglePen ;
		
	    /**
	     * The tween of the builder.
	     */
    	public var backgroundTween:Tween ;
			
		/**
		 * The effect reference of the component.
		 */
		public var effect:CoreShape ;
			
		/**
		 * The effect IPen object of the component.
		 */
		public var effectPen:RoundedComplexRectanglePen ;		

		/**
	 	 * The field reference of the component.
		 */
		public var field:CoreTextField ;

		/**
		 * Clear the view of the component.
		 */
		public override function clear():void 
		{
			backgroundPen   = null ;
			effectPen       = null ;
	    	backgroundColor = null ;
			backgroundTween = null ;
			var t:DisplayObjectContainer = ( target as DisplayObjectContainer ) ;
			if ( background != null && t.contains(background) ) t.removeChild( background ) ;
			if ( effect != null && t.contains(effect) ) t.removeChild( effect ) ;
			if ( field != null && t.contains(field) ) t.removeChild( field ) ;
		}

		/**
		 * Invoked when the button is down.
		 */
		public function disabled( e:ButtonEvent ):void
		{
			var $s:AquaButtonStyle = (target as AquaButton).style as AquaButtonStyle ;
			_refreshBackground( $s.themeDisabledFill ) ;
		}
		
		/**
		 * Invoked when the button is down.
		 */
		public function down( e:ButtonEvent ):void
		{
			var $s:AquaButtonStyle = (target as AquaButton).style as AquaButtonStyle ;
			_refreshBackground( $s.themeSelectedFill ) ;
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
		public function over( e:ButtonEvent ):void
		{
			var $s:AquaButtonStyle = (target as AquaButton).style as AquaButtonStyle ;
			_refreshBackground( $s.themeRollOverFill ) ;
		}
		
		/**
		 * Run the build of the component.
		 */
		public override function run( ...arguments:Array ):void 
		{
				
			var t:DisplayObjectContainer = ( target as DisplayObjectContainer ) ;
			
        	background = new CoreShape() ;
			effect     = new CoreShape() ;
			field      = new CoreTextField() ;
			
			field.mouseEnabled = false ;
			
			t.addChild(background) ;
			t.addChild(effect) ;
			t.addChild(field) ;
			
			// tools
			
			backgroundPen    = new RoundedComplexRectanglePen( background ) ;
			effectPen        = new RoundedComplexRectanglePen( effect ) ;
				
        	backgroundColor  = new LightColor( background ) ;    
        	backgroundTween  = new Tween( backgroundColor ) ;
		
		}		
		
		/**
		 * Invoked when the button is up.
		 */
		public function up( e:ButtonEvent ):void
		{
			var $s:AquaButtonStyle = (target as AquaButton).style as AquaButtonStyle ;			
			_refreshBackground( $s.themeFill ) ;
		}
		
		/**
	 	 * Update the view of the component.
	 	 */
		public override function update():void 
		{
			_refreshBackground() ;
			_refreshField() ;
		}
		
		/**
		 * @private
		 */
		private function _refreshBackground( fill:FillStyle = null ):void
		{
			
			var $s:AquaButtonStyle = (target as AquaButton).style as AquaButtonStyle ;
			
			background.filters = $s.themeFilters ;
					
			var $w:Number = AquaButton(target).w ;
			var $h:Number = AquaButton(target).h ;
			
			backgroundPen.bottomLeftRadius  = $s.themeBottomLeftRadius ;	
			backgroundPen.bottomRightRadius = $s.themeBottomRightRadius ;
			backgroundPen.topLeftRadius     = $s.themeTopLeftRadius ;
			backgroundPen.topRightRadius    = $s.themeTopRightRadius ;
			
			backgroundPen.fill = fill == null ? $s.themeFill : fill ;
			
			backgroundPen.draw( 0, 0, $w,  $h ) ;
			
			effectPen.bottomLeftRadius  = $s.themeBottomLeftRadius ;	
			effectPen.bottomRightRadius = $s.themeBottomRightRadius ;
			effectPen.topLeftRadius     = $s.themeTopRightRadius ;
			effectPen.topRightRadius    = $s.themeTopRightRadius ;	
			effectPen.fill              = new FillStyle( 0x000000, 100 ) ;
			effectPen.draw( 1, 1, $w-2, $h - 4 ) ;
					
			var alphas:Array            = [ 0 , 0.8 ] ;
			var colors:Array            = [ ( backgroundPen.fill as FillStyle).color , 0xFFFFFF ] ;
			var ratios:Array            = [ 0 , 255 ] ;
			var glow:GradientGlowFilter = new GradientGlowFilter ( -8 , 90 , colors, alphas, ratios , 4 , $h, 1.2, 2, "inner", true ) ; 
					
			effect.filters = [ glow  ] ;
		
		}
			
	    /**
	     * @private
	     */
    	private function _refreshField():void
	    {
	        //var $target:AquaButton = (target as AquaButton) ;
	        //var $s:AquaButtonStyle = $target.style as AquaButtonStyle ;
			/*	
			var $w:Number = AquaButton(target).w ;
			var $h:Number = AquaButton(target).h ;
			        
        	//var $r:Number          = $s.themeRound > 0 ? $s.themeRound : 0 ;
		
			var $p:Number          = $s.padding > 0 ? $s.padding : 0 ;
			var $m:Number          = $s.margin > 0 ? $s.margin : 0 ;		
        	var $t:String          = HTMLStringFormatter.paragraph( $target.label || "", $s.labelStyleName ) ;
    		var $i:DisplayObject   = null ; // icon
    	        
        	field.antiAliasType = $s.antiAliasType || AntiAliasType.NORMAL ;
			field.embedFonts    = $s.embedFonts ;
        	field.gridFitType   = $s.gridFitType || GridFitType.NONE ;
			field.multiline     = $s.multiline ;
        	field.selectable    = $s.selectable ;
        	field.wordWrap      = $s.wordWrap ;
			
        	field.styleSheet    = $s.styleSheet ;
					
			//field.border = true ;
			
			if ( $s.html )
			{
				field.htmlText = $t ;
			}
			else
			{	
				field.text = $t ;	
			}
			
			field.visible = $t.length > 0 ;
			        
        	field.height = field.textHeight + 4 ;
			field.y      = ($h - field.height) / 2 - 1 ; 
			
			//var $bl:Number = backgroundPen.bottomLeftRadius ;
			//var $br:Number = backgroundPen.bottomRightRadius ;
			//var $tl:Number = backgroundPen.topLeftRadius     ;
			//var $tr:Number = backgroundPen.topRightRadius    ;
	
			//field.x     = ( $i == null ) ? ($tl + $p) : ($i.x + $i.width + $p + $r ) ;
			//field.width = ( $i == null ) ? ( $w - $m - $p - 2 * $r ) : ( $w - field.x - $m - $r ) ;
			*/
		}				
		
	}
}
