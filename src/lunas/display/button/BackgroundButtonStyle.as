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
    import lunas.core.AbstractStyle;
    import lunas.core.EdgeMetrics;
    
    import pegas.draw.FillStyle;
    import pegas.draw.LineStyle;
    import pegas.transitions.TweenLite;
    import pegas.transitions.easing.Back;
    import pegas.transitions.easing.Elastic;    

    /**
	 * This IStyle class is used in the BackgroundButton component.
	 */
	public class BackgroundButtonStyle extends AbstractStyle 
	{

		/**
		 * Creates a new BackgroundButtonStyle instance.
		 * @param id The id of the object.
		 * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored. 
		 */
		public function BackgroundButtonStyle(id:* = null, init:* = null)
		{
			super( id, init );
		}
		
        /**
         * The alignement of the background.
         * @see pegas.draw.Align
         */
        public var align:uint = 10 ;
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public var bottomLeftRadius:Number = 0 ;
        
        /**
         * The radius of the bottom-left corner, in pixels.
         */
        public var bottomRightRadius:Number = 0 ;		
		
	    /**
	     * The margin values of the component.
	     */
    	public var margin:EdgeMetrics ;
	
    	/**
	     * The theme style when the component is up.
	     */
    	public var theme:FillStyle ;
		
	    /**
	     * The border style when the component is up.
	     */
    	public var themeBorder:LineStyle ;
		
	    /**
	     * The border style when the component is disabled.
	     */
    	public var themeBorderDisabled:LineStyle ;
		
	    /**
	     * The border style when the component is over.
	     */
    	public var themeBorderRollOver:LineStyle ;
		
	    /**
	     * The border style when the component is selected.
	     */
    	public var themeBorderSelected:LineStyle ;
		
	    /**
	     * The theme style when the component is disabled.
	     */
    	public var themeDisabled:FillStyle ;
		
	    /**
	     * The theme style when the component is over.
	     */
    	public var themeRollOver:FillStyle ;
	
	    /**
	     * The theme style when the component is selected.
	     */
    	public var themeSelected:FillStyle ;
    	
        /**
         * The radius of the upper-left corner, in pixels.
         */
        public var topLeftRadius:Number = 0 ;
                
        /**
         * The radius of the upper-right corner, in pixels. 
         */
        public var topRightRadius:Number = 0 ;    	
    	
	    /**
	     * The tween invoked when the button is over.
	     */
    	public var tweenOver:TweenLite ;
		
	    /**
	     * The tween invoked when the button is selected.
	     */
    	public var tweenSelected:TweenLite ;
		
	    /**
	     * Initialize the IStyle object.
     	 */
	    public override function initialize():void 
	    {
            margin              = new EdgeMetrics( 2, 2, 2, 2 ) ;
            theme               = new FillStyle( 0x338599 , 1 ) ;
       	    themeBorder         = new LineStyle( 2, 0xFFFFFF , 1 ) ;
            themeDisabled       = new FillStyle( 0xD2EBF0 , 1 ) ;
            themeRollOver       = new FillStyle( 0x286979 , 1 ) ;
           	themeSelected       = new FillStyle( 0xDBD2F0 , 1 ) ;
            themeBorderDisabled = new LineStyle( 2, 0xFFFFFF , 1 ) ;
            themeBorderRollOver = new LineStyle( 2, 0xFFFFFF , 1 ) ;
            themeBorderSelected = new LineStyle( 2, 0xFFFFFF , 1 ) ;
            tweenOver           = new TweenLite( null , "brightness" , Back.easeOut    , 125 , 0 , 1   , true  ) ;
            tweenSelected       = new TweenLite( null , "brightness" , Elastic.easeOut , 100 , 0 , 0.5 , true  ) ;
    	}
			
	}
}
