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
package lunas.core 
{
    import flash.text.TextField;
    
    import lunas.core.IFocusable;        

    /**
     * This interface defines all methods to implement in a text input display components.
     * @author eKameleon
     */
    public interface ITextInput extends IData, IFocusable 
    {
    
        /**
         * Specifies whether extra white space (spaces, line breaks, and so on) should be removed in a TextInput control with HTML text.
         */
        function get condenseWhite():Boolean ;
        
        /**
         * @private
         */
        function set condenseWhite(b:Boolean):void ;
        
        /**
         * Indicates whether this control is used for entering passwords.
         */
        function get displayAsPassword():Boolean ;
        
        /**
         * @private
         */
        function set displayAsPassword(b:Boolean):void ;
        
        /**
         * Indicates whether the user is allowed to edit the text in this control.
         */
        function get editable():Boolean ;
        
        /**
         * @private
         */
        function set editable( b:Boolean ):void ;    
    	
        /**
         * Specifies the text displayed by the TextInput component, including HTML markup that expresses the styles of that text.
         */
        function get htmlText():String ;

        /**
         * @private
         */
        function set htmlText( str:String ):void ;        	
    	
        /**
         * Maximum number of characters that users can enter in the text field.
         */
        function get maxChars():int ;
        
        /**
         * @private
         */
        function set maxChars( i:int ):void ; 
                
        /**
         * Indicates the set of characters that a user can enter into the control.
         */
        function get restrict():String ; 
        
        /**
         * @private
         */
        function set restrict( expression:String ):void ; 
            	
        /**
         * Plain text that appears in the component.
         */
        function get text():String ;

        /**
         * @private
         */
        function set text( str:String ):void ;    	
    	
    	/**
    	 * The internal TextField that renders the text of this TextInput.
    	 */
    	function get textField():TextField ;

        /**
         * @private
         */
    	function set textField( field:TextField ):void ;
    	
    }
}
