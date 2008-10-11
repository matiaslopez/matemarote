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
	import flash.text.StyleSheet;
	
	import lunas.core.AbstractStyle;
	
	import pegas.draw.FillStyle;
	import pegas.transitions.easing.Elastic;	

	/**
	 * The IStyle class of the AquaButton component.
	 */
	public class AquaButtonStyle extends AbstractStyle 
	{
		
		/**
		 * Creates a new AquaButtonStyle instance.
		 * @param id The id of the object.
		 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
		 */
		public function AquaButtonStyle(id:* = null, init:* = null)
		{
			super( id, init );
		}
		
		/**
		 * The anti alias type of the fields in the component.
		 */
    	public var antiAliasType:String = null ;
			
		/**
		 * The default color of the field of the component.
		 */
		public var color:Number = 0x000000 ;
		
		/**
		 * The easing begin value.
		 */
    	public var easingBegin:Number = 90 ;
		
		/**
		 * The easing duration value.
		 */    
    	public var easingDuration:Number = 1.5 ;
		
		/**
	 	 * The easing end value.
		 */
    	public var easingEnd:Number = 0 ;
		
		/**
		 * The name of the easing property.
		 */
    	public var easingProperty:String = "brightness" ;
		
		/**
		 * The id of the easing rollover method.
		 */
    	public var easingRollOver:Function = Elastic.easeOut ;
		
		/**
		 * Indicates if the easing use seconds.
		 */
    	public var easingUseSeconds:Boolean = true ;
		
		/**
		 * Indicates if the fields embed fonts.
		 */
    	public var embedFonts:Boolean = false ;
		
		/**
		 * Indicates the type of the gridfit of the fields.
		 */
    	public var gridFitType:String = null ;
		
		/**
		 * Indicates if the button use a html text or not.
		 */
    	public var html:Boolean = true ;
		
		/**
		 * The array of the filters of the component icon.
		 */
		public var iconFilters:Array ;
		
		/**
	 	 * The style name of the field of the component.
	 	 */
		public var labelStyleName:String = "aqua_button_label" ;

		/**
		 * The padding value used in the component.
		 */
    	public var margin:Number = 2 ;
		
		/**
		 * Indicates if the text in the button is multiline.
		 */
    	public var multiline:Boolean = false ;
		
		/**
		 * The padding value used in the component.
		 */
    	public var padding:Number = 1 ;
		
		/**
		 * Indicates if the field is selectable in the component.
		 */
    	public var selectable:Boolean = false ;
	
		/**
		 * The color of the text when is disabled.
		 */
	    public var textDisabledColor:Number = 0xCCCCCC ;
		
		/**
		 * The color of the text when is over.
		 */
    	public var textRollOverColor:Number = 0xFFFFFF ;
		
		/**
		 * The color of the text when is selected.
		 */
    	public var textSelectedColor:Number = 0x37284F ;
	
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public var themeBottomLeftRadius:Number = 8 ;
        
        /**
         * The radius of the bottom-right corner, in pixels.
         */
        public var themeBottomRightRadius:Number = 8 ;
        
		/**
		 * The alpha value of the text.
		 */
    	public var themeFill:FillStyle = new FillStyle( 0x006699 , 100 ) ;
		
		/**
		 * The disabled color value of the background.
		 */
    	public var themeDisabledFill:FillStyle = new FillStyle( 0x000000 , 100 ) ;
		
		/**
	 	 * The array of the filters of the component background.
	 	 */
		public var themeFilters:Array ;
		
		/**
		 * The rollover color value of the background.
		 */
    	public var themeRollOverFill:FillStyle = new FillStyle( 0x435F78 , 100 ) ;
		
		/**
		 * The selected color value of the background.
		 */
    	public var themeSelectedFill:FillStyle = new FillStyle( 0x000000 , 100 ) ;
		
        /**
         * The radius of the upper-left corner, in pixels.
         */
        public var themeTopLeftRadius:Number = 8 ;
        
        /**
         * The radius of the upper-right corner, in pixels. 
         */
        public var themeTopRightRadius:Number = 8 ;				
		
		/**
		 * Indicates if the component use the style text colors.
		 */
		public var useTextColor:Boolean = true ;
		
		/**
		 * The wordwrap value of the fields.
		 */
    	public var wordWrap:Boolean = false ;
    	
	    /**
	     * Initialize the style object.
	     */
    	public override function initialize():void 
	    {
			if ( styleSheet == null )
    		{
	    		var styles:Object = 
    			{
	    			
    			} ;	
       			var s:StyleSheet = new StyleSheet() ;
       			s.setStyle( labelStyleName , styles ) ;
       			styleSheet = s ;
			}
    	}		
	
	}

}
