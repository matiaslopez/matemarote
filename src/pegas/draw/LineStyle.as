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
    
    import vegas.core.CoreObject;    

    /**
     * Defines the line style of the vector shapes. See the flash.display.graphics.lineStyle method.
     * @author eKameleon
     */
    final public class LineStyle extends CoreObject implements ILineStyle
    {
        
        /**
         * Creates a new LineStyle instance.
         * @param thickness An integer that indicates the thickness of the line in points; valid values are 0 to 255. If a number is not specified, or if the parameter is undefined, a line is not drawn. If a value of less than 0 is passed, the default is 0. The value 0 indicates hairline thickness; the maximum thickness is 255. If a value greater than 255 is passed, the default is 255.
         * @param color (default = 0) A hexadecimal color value of the line; for example, red is 0xFF0000, blue is 0x0000FF, and so on. If a value is not indicated, the default is 0x000000 (black). Optional. 
         * @param alpha (default = 1.0) A number that indicates the alpha value of the color of the line; valid values are 0 to 1. If a value is not indicated, the default is 1 (solid). If the value is less than 0, the default is 0. If the value is greater than 1, the default is 1. 
         * @param pixelHinting (default = false) A Boolean value that specifies whether to hint strokes to full pixels. This affects both the position of anchors of a curve and the line stroke size itself. With pixelHinting set to true, Flash Player hints line widths to full pixel widths. With pixelHinting set to false, disjoints can appear for curves and straight lines. 
         * @param scaleMode (default = "normal")  A value from the LineScaleMode class that specifies which scale mode to use :
         * <li>LineScaleMode.NORMAL—Always scale the line thickness when the object is scaled (the default).</li>
         * <li>LineScaleMode.NONE—Never scale the line thickness.</li>
         * <li>LineScaleMode.VERTICAL—Do not scale the line thickness if the object is scaled vertically only.</li>
         * @param caps (default = null) — A value from the CapsStyle class that specifies the type of caps at the end of lines. Valid values are: CapsStyle.NONE, CapsStyle.ROUND, and CapsStyle.SQUARE. If a value is not indicated, Flash uses round caps. 
         * @param joints (default = null) — A value from the JointStyle class that specifies the type of joint appearance used at angles. Valid values are: JointStyle.BEVEL, JointStyle.MITER, and JointStyle.ROUND. If a value is not indicated, Flash uses round joints. 
         * @param miterLimit (default = 3) — A number that indicates the limit at which a miter is cut off. Valid values range from 1 to 255 (and values outside of that range are rounded to 1 or 255). This value is only used if the jointStyle is set to "miter". The miterLimit value represents the length that a miter can extend beyond the point at which the lines meet to form a joint. The value expresses a factor of the line thickness. For example, with a miterLimit factor of 2.5 and a thickness of 10 pixels, the miter is cut off at 25 pixels. 
         */
        public function LineStyle( thickness:Number , color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3 )
        {
            this.thickness    = thickness;
            this.color        = color;
            this.alpha        = alpha;
            this.pixelHinting = pixelHinting;
            this.scaleMode    = scaleMode;
            this.caps         = caps;
            this.joints       = joints;
            this.miterLimit   = miterLimit;
        }
        
        /**
         * The empty LineStyle singleton.
         */
        public static var EMPTY:LineStyle = new LineStyle( undefined ) ;
        
        /**
         * A number that indicates the alpha value of the color of the line; valid values are 0 to 1. 
         * If a value is not indicated, the default is 1 (solid). If the value is less than 0, the default is 0. If the value is greater than 1, the default is 1. 
         */
        public var alpha:Number;
        
        /**
         * A value from the CapsStyle class that specifies the type of caps at the end of lines. 
         * Valid values are : CapsStyle.NONE, CapsStyle.ROUND, and CapsStyle.SQUARE. 
         * If a value is not indicated, Flash uses round caps.
         */
        public var caps:String;
        
        /**
         * A hexadecimal color value of the line; for example, red is 0xFF0000, blue is 0x0000FF, and so on. 
         * If a value is not indicated, the default is 0x000000 (black).
         */
        public var color:uint;
        
        /**
         * A value from the JointStyle class that specifies the type of joint appearance used at angles. 
         * Valid values are: JointStyle.BEVEL, JointStyle.MITER, and JointStyle.ROUND. If a value is not indicated, Flash uses round joints.
         */
        public var joints:String;
        
        /**
         * A number that indicates the limit at which a miter is cut off. 
         * Valid values range from 1 to 255 (and values outside of that range are rounded to 1 or 255). 
         * This value is only used if the jointStyle is set to "miter". 
         * The miterLimit value represents the length that a miter can extend beyond the point at which the lines meet to form a joint. The value expresses a factor of the line thickness. 
         * For example, with a miterLimit factor of 2.5 and a thickness of 10 pixels, the miter is cut off at 25 pixels.
         */
        public var miterLimit:Number;
        
        /**
         * A Boolean value that specifies whether to hint strokes to full pixels. 
         * This affects both the position of anchors of a curve and the line stroke size itself. 
         * With pixelHinting set to true, Flash Player hints line widths to full pixel widths. 
         * With pixelHinting set to false, disjoints can appear for curves and straight lines. 
         */
        public var pixelHinting:Boolean;
        
        /**
         *  A value from the LineScaleMode class that specifies which scale mode to use :
         * <li>LineScaleMode.NORMAL—Always scale the line thickness when the object is scaled (the default).</li>
         * <li>LineScaleMode.NONE—Never scale the line thickness.</li>
         */
        public var scaleMode:String;
        
        /**
         * An integer that indicates the thickness of the line in points ; valid values are 0 to 255. 
         * If a number is not specified, or if the parameter is undefined, a line is not drawn.
         * If a value of less than 0 is passed, the default is 0. 
         * The value 0 indicates hairline thickness ; the maximum thickness is 255. 
         * If a value greater than 255 is passed, the default is 255.
         */
        public var thickness:Number;
       
        /**
         * Initialize and launch the lineStyle method of the specified Graphics reference.
         */
        public function init( graphic:Graphics ):void
        {
            graphic.lineStyle( thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit ) ;
        }
        
        
    }
}
