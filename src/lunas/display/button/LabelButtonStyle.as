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
    import flash.text.StyleSheet;
    
    import lunas.core.EdgeMetrics;
    
    import pegas.draw.FillStyle;
    import pegas.draw.LineStyle;    

    /**
	 * This IStyle class is used in the LabelButton to set the styles of the component.
	 */
	public class LabelButtonStyle extends BackgroundButtonStyle 
	{

		/**
		 * Creates a new LabelButtonStyle instance.
		 * @param id The id of the object.
		 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
		 */	
		public function LabelButtonStyle( id:* = null, init:* = null )
		{
			super( id, init ) ;
		}
		
		/**
		 *  The anti alias type of the fields in the component.
     	 */
    	public var antiAliasType:String = null ;
    
	    /**
	     * Indicates if the textField is autosize value.
	     */
     	public var autoSize:Object ;
    	
    	/**
    	 * Indicates if the border of the field is visible.
    	 */
    	public var border:Boolean ;
    	
    	/**
    	 * The color of the field border.
    	 */
    	public var borderColor:Number ;
    	
	    /**
	     * The default color of the field of the component.
	     */
	    public var color:Number = 0xFFFFFF ;
		    
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
	     * The style name of the field of the component.
	     */
    	public var labelStyleName:String = "label_button_label" ;
    	
	    /**
	     * Indicates if the text in the button is multiline.
	     */
	    public var multiline:Boolean = false ;
    	
	    /**
	     * The padding value used in the component.
	     */
    	public var padding:EdgeMetrics ;
		
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
    	public var textRollOverColor:Number = 0xFEFE45 ;
		
	    /**
	     * The color of the text when is selected.
	     */
	    public var textSelectedColor:Number = 0xD1BE72 ;
    
    	/**
	     * Indicates if the component use the style text colors.
	     */
    	public var useTextColor:Boolean = true ;
    	
	    /**
	     * The wordwrap value of the fields.
	     */
    	public var wordWrap:Boolean = false ;
		
	    /**
	     * Initialize the IStyle object.
     	 */
	    public override function initialize():void 
	    {
            super.initialize() ;
            
            border              = false ;
            margin              = new EdgeMetrics( 6, 0, 4, 0 ) ;
            padding             = new EdgeMetrics( 0, 0, 4, 0 ) ;
            
            theme               = new FillStyle( 0 , 0 ) ;
            themeBorder         = new LineStyle( 0, 0 , 0 ) ;
            
            themeDisabled       = new FillStyle( 0 , 0 ) ;
            themeRollOver       = new FillStyle( 0 , 0 ) ;
            themeSelected       = new FillStyle( 0 , 0 ) ;
            
            themeBorderDisabled = new LineStyle( 0, 0 , 0 ) ;
            themeBorderRollOver = new LineStyle( 0, 0 , 0 ) ;
            themeBorderSelected = new LineStyle( 0, 0 , 0 ) ;
            
            styleSheet          = new StyleSheet() ;
            styleSheet.setStyle("." + labelStyleName, { color:"#FFFFFF", fontFamily:"arial", size:"12px" } ) ;
    	}		
		
	}

}
