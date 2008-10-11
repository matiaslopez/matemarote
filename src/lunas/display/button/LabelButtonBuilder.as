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
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	
	import asgard.text.CoreTextField;
	
	import lunas.core.EdgeMetrics;
	import lunas.events.ButtonEvent;
	
	import vegas.string.HTMLStringFormatter;	

	/**
	 * The IBuilder of the LabelButton component class.
	 */
	public class LabelButtonBuilder extends BackgroundButtonBuilder 
	{

		/**
		 * Creates a new LabelButtonBuilder reference.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
	 	 */
		public function LabelButtonBuilder(target:DisplayObject, bGlobal:Boolean = false, sChannel:String = null)
		{
			super( target, bGlobal, sChannel );
		}
		
		/**
		 * The field reference of the component.
		 */
		public var field:CoreTextField ;
		
  		/**
	     * Clear the view of the component.
	     */
    	public override function clear():void 
    	{
    		super.clear() ;
    		var b:LabelButton = target as LabelButton ;	
    		if ( field != null && b.contains( field) )
    		{
	        	b.removeChild( field ) ;
	        	field = null ;
    		}
	    }
		
		/**
		 * Invoked when the button is disabled.
		 */
		public override function disabled( e:ButtonEvent = null ):void
		{
        	super.disabled( e ) ; 
    		var b:LabelButton      = target as LabelButton ;	
        	var s:LabelButtonStyle = b.style as LabelButtonStyle ;
        	if ( s.useTextColor )
        	{
               	field.textColor = s.textDisabledColor ;
        	}        	
		}
		
		/**
		 * Invoked when the button is down.
		 */
		public override function down( e:ButtonEvent = null ):void
		{
        	super.down( e ) ; 
        	
    		var b:LabelButton      = target as LabelButton ;	
        	var s:LabelButtonStyle = b.style as LabelButtonStyle ;
        	if ( s.useTextColor )
        	{
               	field.textColor = s.textSelectedColor ;
        	}   
		}			
		
    	/**
	     * Invoked when the button is over.
	     */
	    public override function over( e:ButtonEvent = null ):void 
	    {
        	super.over( e ) ;
        	
    		var b:LabelButton      = target as LabelButton ;	
        	var s:LabelButtonStyle = b.style as LabelButtonStyle ;
        	if ( s.useTextColor )
        	{
               	field.textColor = s.textRollOverColor ;
			}   
		}

		/**
	 	 * Runs the build of the component.
		 */
		public override function run(...arguments:Array):void
		{
			super.run() ;
         	
         	field = new CoreTextField() ;
			field.mouseEnabled = false ;
			var b:BackgroundButton = target as BackgroundButton ;	
			
			b.addChild( field ) ;
    	}
    
	    /**
	     * Invoked when the button is up.
	     */
    	public override function up( e:ButtonEvent = null ):void 
	    {
        	super.up( e ) ;
        	
    		var b:LabelButton      = target as LabelButton ;	
        	var s:LabelButtonStyle = b.style as LabelButtonStyle ;
        	if ( s.useTextColor )
        	{
               	field.textColor = s.color ;
        	}   
    	}

	    /**
	     * Update the view of the component.
	     */
    	public override function update():void 
	    {
        	super.update()  ;
        	
        	refreshField()  ;
        	refreshFieldLayout() ;
    	}			

		/**
		 * Refreshs the internal field.
		 */
		protected function refreshField():void
		{
    		var b:LabelButton      = target as LabelButton ;	
        	var s:LabelButtonStyle = b.style as LabelButtonStyle ;
        	
        	var txt:String = HTMLStringFormatter.span( b.label || "", s.labelStyleName ) ;
        	
        	field.border        = s.border ;
        	field.borderColor   = s.borderColor ;
        	field.antiAliasType = s.antiAliasType || AntiAliasType.NORMAL ;
			field.embedFonts    = s.embedFonts ;
        	field.gridFitType   = s.gridFitType || GridFitType.NONE ;
			field.multiline     = s.multiline ;
        	field.selectable    = s.selectable ;
        	field.wordWrap      = s.wordWrap ;
        	field.styleSheet    = s.styleSheet ;
			
        	if (s.html)
        	{
	            field.htmlText = txt ;
        	}
        	else
        	{    
	            field.text = txt ;    
        	}
			        
        	field.visible = txt != null || txt.length > 0 ;
        
	        if ( s.useTextColor )
        	{
	            field.textColor = b.enabled ? ( b.selected ? s.textSelectedColor : s.color ) : s.textDisabledColor ;
        	}
		
		}

	    /**
	     * Refresh the field layout.
	     */
	    protected function refreshFieldLayout():void
	    {
    		var b:LabelButton      = target as LabelButton ;	
        	var s:LabelButtonStyle = b.style as LabelButtonStyle ;
         	
        	field.x = EdgeMetrics.filterNaNValue( s.margin.left ) ;
					
        	var h:Number =  EdgeMetrics.filterNaNValue( s.padding.top ) + EdgeMetrics.filterNaNValue( s.padding.bottom ) ;
    		
        	field.width  = b.w - field.x ;
        	field.height = b.h + h ; 
        	
	        field.y      = EdgeMetrics.filterNaNValue( s.padding.top ) ; 
       	}

	}

}
