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
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.geom.Matrix;
    
    import vegas.core.CoreObject;    

    /**
     * Defines the fill style of the vector shapes. See the flash.display.graphics.beginBitmapFill method.
     * @author eKameleon
     */
    final public class FillBitmapStyle extends CoreObject implements IFillStyle
    {
        
        /**
         * Creates a new FillBitmapStyle instance.
         * @param bitmap A transparent or opaque bitmap image that contains the bits to be displayed.
         * @param matrix A matrix object (of the flash.geom.Matrix class), which you can use to define transformations on the bitmap. 
         * @param repeat If true, the bitmap image repeats in a tiled pattern. If false, the bitmap image does not repeat, and the edges of the bitmap are used for any fill area that extends beyond the bitmap.
         * @param smooth A value from the InterpolationMethod class that specifies which value to use: InterpolationMethod.linearRGB or InterpolationMethod.RGB.
         */
        public function FillBitmapStyle( bitmap:BitmapData , matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false )
        {
            this.bitmap  = bitmap ;
            this.matrix  = matrix ;
            this.repeat  = repeat ;
            this.smooth  = smooth ;
        }
        
        /**
         * A transparent or opaque bitmap image that contains the bits to be displayed.
         */
        public var bitmap:BitmapData;
    
        /**
         * A matrix object (of the flash.geom.Matrix class), which you can use to define transformations on the bitmap.
         */
        public var matrix:Matrix;
        
        /**
         * If true, the bitmap image repeats in a tiled pattern. If false, the bitmap image does not repeat, and the edges of the bitmap are used for any fill area that extends beyond the bitmap.
         */
        public var repeat:Boolean ;
        
        /**
         * If false, upscaled bitmap images are rendered by using a nearest-neighbor algorithm and look pixelated. If true, upscaled bitmap images are rendered by using a bilinear algorithm. Rendering by using the nearest neighbor algorithm is usually faster.
         */
        public var smooth:Boolean ;
        
        /**
         * Initialize and launch the beginBitmapFill method of the specified Graphics reference.
         */
        public function init( graphic:Graphics ):void
        {
            graphic.beginBitmapFill( bitmap , matrix , repeat , smooth );
        }
        
    }

}
