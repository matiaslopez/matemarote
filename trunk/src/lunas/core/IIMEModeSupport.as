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

    /**
     * The IIMESupport interface defines the interface for any component that supports IME.
     * (input method editor).
     * IME is used for entering characters in Chinese, Japanese, and Korean.
     * @author eKameleon
     */
    public interface IIMEModeSupport 
    {

        /**
         *  The IME mode of the component.
         */
        function get imeMode():String;
        
        /**
         *  @private
         */
        function set imeMode(value:String):void;    	
    	
    }
}
