/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/
 
package system.ui 
{
    import flash.text.TextField;
    
    import system.diagnostics.TraceConsole;    

    /**
     * The TextFieldConsole use a TextField display that redirect messages in the debug application.
     * <p><b>Note:</b> You can not read from the output and so the TextFieldConsole is not interactive.</p>
     */
    public class TextFieldConsole extends TraceConsole 
    {
        
        /**
         * Creates a new TextFieldConsole instance.
         * @param textfield The TextField reference to redirect the messages.
         */
        public function TextFieldConsole( textfield:TextField , verbose:Boolean=true )
        {
        	this.textfield = textfield ;
        	this.verbose   = verbose ;
        }
        
        /**
         * The TextField reference of this console.
         */
        public var textfield:TextField ;
        
        /**
         * Indicates the verbose mode.
         */
        public var verbose:Boolean ;
        
        /**
         * Appends the message format and add newline character.
         */        
        public override function writeLine( ...messages ):void
        {
            var msg:String = _formatMessage( messages ) ;
            
            msg = _buffer + msg  ;
            
            if ( verbose )
            {
                trace( msg ) ; 
            }
            
            var txt:String = textfield.text ;
            txt += msg + "\r" ;
            
            textfield.text = txt ;
            
            _buffer = "" ;
        }
        
    }
}
