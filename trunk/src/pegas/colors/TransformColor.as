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

package pegas.colors 
{
    import flash.display.DisplayObject;    
    
    /**
	 * Transformation class to modify the filters on a Color object with Photoshop filters.
	 * @author eKameleon
	 */
	public class TransformColor extends Color 
	{

		/**
		 * Creates a new LightColor instance.
		 * @param display a DisplayObject reference.
		 */
		public function TransformColor(display:DisplayObject)
		{
			super( display );
		}
		
		/**
		 * Corresponding a filter in mode "addition" in photoshop over a display object. 
		 */
		public function addition(n:Number):void 
		{
			var o:Object = RGB.numberToRGB(n) ;
			setTransform ( { rb:o.r , gb:o.g , bb:o.b });
		}
		
		/**
		 * Corresponding a filter in mode "colorDodge" in photoshop over a display object. 
		 */
		public function colorDodge(n:Number):void 
		{
			var o:Object = RGB.numberToRGB(n) ;
			setTransform ({ ra:_dodge(o.r) , ga:_dodge(o.g) , ba:_dodge(o.b) } );
		}
		
		/**
	 	 * Corresponding a filter in mode "difference" in photoshop over a display object. 
		 */
		public function difference (n:Number):void 
		{
			var o:Object = RGB.numberToRGB(n) ;
			setTransform ( { rb:-o.r , gb:-o.g , bb:-o.b });
		}
		
		/**
		 * Corresponding a filter in mode "divide" in photoshop over a display object. 
		 */
		public function divide(n:Number):void 
		{
			var o:Object = RGB.numberToRGB(n) ;
			setTransform ({ ra:_div(o.r) , ga:_div(o.g) , ba:_div(o.b) } );
		}
			
		/**
		 * Corresponding a filter in mode "linearBurn" in photoshop over a display object. 
	 	 */
		public function linearBurn (n:Number):void 
		{
			var o:Object = RGB.numberToRGB(n) ;
			setTransform ({ rb:o.r-255 , gb:o.g-255, bb:o.b-255 });
		}
		
		/**
		 * Corresponding a filter in mode "linearDodge" in photoshop over a display object. 
	 	 */
		public function linearDodge (n:Number):void 
		{
			var o:Object = RGB.numberToRGB(n) ;
			setTransform ({ rb:o.r , gb:o.g, bb:o.b });
		}
			
		/**
		 * Corresponding a filter in mode "multiply" in photoshop over a display object. 
		 */
		public function multiply(n:Number):void 
		{
			var o:Object = RGB.numberToRGB(n) ;
			setTransform ({ ra:o.r/2.55 , ga:o.g/2.55 , ba:o.b/2.55 });
		}
		
		/**
		 * Corresponding a filter in mode "negative" in photoshop over a display object. 
		 */
		public function negative (n:Number):void 
		{
			setTransform ({ ra:-100, ga:-100, ba:-100, rb:255, gb:255, bb:255 });
		}
			
		/**
	 	 * Corresponding a filter in mode "screen" in photoshop over a display object. 
	 	 */
		public function screen (n:Number):void 
		{
			var o:Object = RGB.numberToRGB(n) ;
			setTransform ({ ra:_scr(o.r), ga:_scr(o.g), ba:_scr(o.b), rb:o.r, gb:o.g, bb:o.b } );
		}
		
		/**
		 * Corresponding a filter in mode "substraction" in photoshop over a movieclip. 
		 */
		public function substraction (n:Number):void 
		{
			var o:Object = RGB.numberToRGB(n) ;
			setTransform ({ ra:-100, ga:-100, ba:-100, rb:o.r, gb:o.g, bb:o.b } );
		}
		
		/**
		 * @private
	 	 */
		private function _div(n:Number):Number 
		{
			return 100 / ( (n + 1) /256 ) ;
		}
	
		/**
	 	 * @private
	 	 */
		private function _dodge(n:Number):Number 
		{
			return 100 / ((258 - n) / 256);
		}
			
		/**
	 	 * @private
	 	 */
		private function _scr(n:Number):Number 
		{
			return 100 * (255 - n) / 255;
		}
		
	}

}
