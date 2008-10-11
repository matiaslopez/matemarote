/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package pegas.draw 
{
    import flash.display.Graphics;
    import flash.geom.Matrix;
    
    import vegas.core.CoreObject;    

    /**
     * Defines the fill style of the vector shapes. See the flash.display.graphics.beginGradientFill method.
     * @author eKameleon
     */
    final public class FillGradientStyle extends CoreObject implements IFillStyle
    {
        
        /**
         * Creates a new FillGradientStyle instance.
         * @param type A value from the GradientType class that specifies which gradient type to use : GradientType.LINEAR or GradientType.RADIAL.
         * @param colors An array of RGB hexadecimal color values to be used in the gradient; for example, red is 0xFF0000, blue is 0x0000FF, and so on. You can specify up to 15 colors. For each color, be sure you specify a corresponding value in the alphas and ratios parameters.
         * @param alphas An array of alpha values for the corresponding colors in the colors array; valid values are 0 to 1. If the value is less than 0, the default is 0. If the value is greater than 1, the default is 1.
         * @param ratios An array of color distribution ratios; valid values are 0 to 255. This value defines the percentage of the width where the color is sampled at 100%. The value 0 represents the left-hand position in the gradient box, and 255 represents the right-hand position in the gradient box.
         * @param matrix A transformation matrix as defined by the flash.geom.Matrix class. The flash.geom.Matrix class includes a createGradientBox() method, which lets you conveniently set up the matrix for use with the beginGradientFill() method.
         * @param spreadMethod A value from the SpreadMethod class that specifies which spread method to use, either: SpreadMethod.PAD, SpreadMethod.REFLECT, or SpreadMethod.REPEAT.
         * @param interpolationMethod A value from the InterpolationMethod class that specifies which value to use: InterpolationMethod.linearRGB or InterpolationMethod.RGB.
         * @param focalPointRatio A number that controls the location of the focal point of the gradient. 0 means that the focal point is in the center. 1 means that the focal point is at one border of the gradient circle. -1 means that the focal point is at the other border of the gradient circle. A value less than -1 or greater than 1 is rounded to -1 or 1.
         */
        public function FillGradientStyle( type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0 )
        {
            this.alphas              = alphas ;
            this.colors              = colors ;
            this.focalPointRatio     = focalPointRatio ;
            this.interpolationMethod = interpolationMethod ;
            this.matrix              = matrix ;
            this.ratios              = ratios ;
            this.spreadMethod        = spreadMethod ;
            this.type                = type   ;
        }
        
        /**
         * An array of alpha values for the corresponding colors in the colors array; valid values are 0 to 1. 
         * If the value is less than 0, the default is 0. 
         * If the value is greater than 1, the default is 1.
         */
        public var alphas:Array;
    
        /**
         * An array of RGB hexadecimal color values to be used in the gradient ; 
         * for example, red is 0xFF0000, blue is 0x0000FF, and so on. You can specify up to 15 colors. 
         * For each color, be sure you specify a corresponding value in the alphas and ratios parameters.
         */
        public var colors:Array;
        
        /**
         * A number that controls the location of the focal point of the gradient. 
         * 0 means that the focal point is in the center. 
         * 1 means that the focal point is at one border of the gradient circle. 
         * -1 means that the focal point is at the other border of the gradient circle. 
         * A value less than -1 or greater than 1 is rounded to -1 or 1.
         */
        public var focalPointRatio:Number ;
        
        /**
         * A value from the InterpolationMethod class that specifies which value to use : InterpolationMethod.linearRGB or InterpolationMethod.RGB
         */
        public var interpolationMethod:String ;
        
        /**
         * A transformation matrix as defined by the flash.geom.Matrix class. The flash.geom.Matrix class includes a createGradientBox() method, which lets you conveniently set up the matrix for use with the beginGradientFill() method.
         */
        public var matrix:Matrix ;
        
        /**
         * An array of color distribution ratios; valid values are 0 to 255. 
         * This value defines the percentage of the width where the color is sampled at 100%. 
         * The value 0 represents the left-hand position in the gradient box, and 255 represents the right-hand position in the gradient box.
         */
        public var ratios:Array ;
        
        /**
         * A value from the SpreadMethod class that specifies which spread method to use, either: SpreadMethod.PAD, SpreadMethod.REFLECT, or SpreadMethod.REPEAT.
         */
        public var spreadMethod:String ;
        
        /**
         * A value from the GradientType class that specifies which gradient type to use : GradientType.LINEAR or GradientType.RADIAL.
         */
        public var type:String ;
        
        /**
         * Initialize and launch the beginGradientFill method of the specified Graphics reference.
         */
        public function init( graphic:Graphics ):void
        {
            graphic.beginGradientFill( type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio );
        }
        
    }

}
