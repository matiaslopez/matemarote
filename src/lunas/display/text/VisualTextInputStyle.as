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
    import flash.text.TextFormat;
    
    import lunas.core.AbstractStyle;    

    /**
     * The IStyle class of the VisualTextInput component.
     * @author eKameleon
     */
    public class VisualTextInputStyle extends AbstractStyle 
    {

        /**
         * Creates a new VisualTextInputStyle instance.
         * @param id The id of the object.
         * @param init An object that contains properties with which to populate the newly IStyle object. If initObject is not an object, it is ignored.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function VisualTextInputStyle(id:* = null, init:* = null, bGlobal:Boolean = false, sChannel:String = null)
        {
            super( id, init, bGlobal, sChannel );
        }
        
        /**
         * Color of text in the component.
         */
        public var color:uint = 0x0B333C ;        
        
        /**
         * The default TextFormat of the text input.
         */
        public var defaultTextFormat:TextFormat = new TextFormat("Verdana", 11, null, null, null, null, null, null, null, 4, 4 ) ;
        
        /**
         * Color of text in the component if it is disabled. The default value is 0xAAB3B3.
         */
        public var disabledColor:uint = 0xAAB3B3 ;
        
               
    }
}
