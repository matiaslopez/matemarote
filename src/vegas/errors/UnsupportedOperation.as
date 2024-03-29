﻿/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/


package vegas.errors
{

	/**
	 * Thrown to indicate that the requested operation is not supported.
	 * @author eKameleon
	 */
    public class UnsupportedOperation extends FatalError
    {

		/**
		 * Creates a new UnsupportedOperation instance.
		 */
        public function UnsupportedOperation(message:String="", id:int=0)
        {
            super(message, id);
        }
        
    }
}