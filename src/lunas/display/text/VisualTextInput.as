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
package lunas.display.text 
{
    import flash.display.Sprite;
    
    import lunas.core.AbstractTextInput;
    import lunas.core.EdgeMetrics;    

    /**
     * This class provides a basic implementation of the <code class="prettyprint">ITextInput</code> interface, this class is a proxy who use a skin sprite who contains a background and a dynamic textfield reference.
     * @author eKameleon
     */
    public class VisualTextInput extends AbstractTextInput 
    {
        
        /**
         * Creates a new VisualTextInput instance.
         * @param id Indicates the id of the object.
         * @param skin Indicates the skin view of this visual textinput component.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */ 
        public function VisualTextInput(id:* = null, skin:Sprite = null , isConfigurable:Boolean = false, name:String = null)
        {
            super( id, isConfigurable, name );
            this.skin = skin ;
            
        }
        
        /**
         * The internal background of this TextInput.
         */        
        public function get background():Sprite
        {
            return _background ;
        }
        
        /**
         * @private
         */        
        public function set background(sprite:Sprite):void
        {
            if ( _background != null )
            {
                removeChild( _background ) ;
            }
            _background = sprite  ;
            if ( _background != null )
            { 
                addChildAt(_background, 0) ;
            }
            update() ;
        } 
        
        /**
         * The internal background name of this TextInput.
         */        
        public function get backgroundName():String
        {
            return _backgroundName ;
        }
        
        /**
         * @private
         */        
        public function set backgroundName( name:String ):void
        {
            _backgroundName = name ;
        }                  
        
        /**
         * The internal textfield name of this TextInput.
         */        
        public function get fieldName():String
        {
            return _fieldName ;
        }
        
        /**
         * @private
         */        
        public function set fieldName( name:String ):void
        {
            _fieldName = name ;
        }                  
        
        /**
         * Indicates the skin view of this visual textinput component.
         * This sprite must contains a sprite with the instance name "background" and a dynamic textfield with the name "field". 
         */
        public function get skin():Sprite
        {
            return _skin ;	
        }
        
        /**
         * @private
         */
        public function set skin( view:Sprite ):void
        {
            if ( _skin != null )
            {
                removeChild(_skin) ;
            }
            _skin = view ;
            if ( _skin != null )
            {
            	initSkin() ;
                resolveSkin() ;
                addChild(_skin) ;
            }
        }
        
        /**
         * Invoked when the style of the component is changed.
         */
        public override function getStyleRenderer():Class 
        {
            return VisualTextInputStyle ;
        }          
        
        /**
         * Called when the view of the component is changed.
         */
        public override function viewChanged():void
        {
            if ( textField != null )
            {
               
                var b:Number = EdgeMetrics.filterNaNValue( border.bottom ) ;
                var l:Number = EdgeMetrics.filterNaNValue( border.left   ) ;
                var r:Number = EdgeMetrics.filterNaNValue( border.right  ) ;
                var t:Number = EdgeMetrics.filterNaNValue( border.top    ) ;
                
                var $w:Number ;
                var $h:Number ;
                
                if ( background != null )
                {
                	$w = _w = background.width ;
                	$h = _h = background.height ;
                }
                else
                {
                    $w = isNaN(w) ? 0 : w ;
                    $h = isNaN(h) ? 0 : h ;
                }
                
                var s:VisualTextInputStyle = style as VisualTextInputStyle ;
                
                textField.defaultTextFormat = s.defaultTextFormat ;
                textField.textColor         = enabled ? s.color : s.disabledColor ;
                
                textField.x      = l  ;
                textField.y      = t+1  ;
                textField.width  = $w - l - r ;
                textField.height = $h - t - b ;
            }
        }        
        
        /**
         * Invoked when the enabled property of the component change.
         */
        public override function viewEnabled():void 
        {
            var s:VisualTextInputStyle = style as VisualTextInputStyle ;
            textField.textColor        = enabled ? s.color : s.disabledColor ;
            viewEditableChanged() ;
        }        
                
        /**
         * @private
         */
        protected var _background:Sprite ;           
        
        /**
         * @private
         */
        protected var _backgroundName:String = "background" ;           
        
        /**
         * @private
         */
        protected var _fieldName:String = "field" ;           
        
        /**
         * @private
         */
        protected var _skin:Sprite ;
        
        /**
         * Invoked to initialize the skin.
         */
        protected function initSkin():void
        {
            x = _skin.x ;
            y = _skin.y ;
            _skin.x = 0 ;
            _skin.y = 0 ;
        }        
        
        /**
         * Invoked to resolve the content of the skin.
         */
        protected function resolveSkin():void
        {
            if ( _skin != null )
            {
                _skin.mouseEnabled = false ;
                background = ( backgroundName in _skin ) ? _skin[backgroundName] : null ;
                textField  = ( fieldName      in _skin ) ? _skin[fieldName]      : null ;
                groupPolicyChanged() ;
                update() ;
            }   
        }
        
    }
}
