/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package andromeda.util.observer
{
    
    /**
     * A class can implement the IObserver interface when it wants to be informed of changes in observable objects.
     * @author eKameleon
     */
    public interface IObserver
    {

        /**
         * This method is called whenever the observed object is changed.
         * @param o the observable object.
         * @param arg an argument passed to the notifyObservers method.
         */
        function update(o:Observable, arg:*):void ;

    }
}