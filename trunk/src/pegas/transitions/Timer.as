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

package pegas.transitions 
{
	
	import flash.utils.Timer ;
	import pegas.transitions.ITimer;		

	/**
	 * This class extends the flash.utils.Timer class and implement the pegas.transitions.ITimer class.
	 * The Timer class is the interface to Flash Player timers. 
	 * You can create new Timer objects to run code on a specified time sequence. 
	 * Use the start() method to start a timer. 
	 * Add an event listener for the timer event to set up code to be run on the timer interval. 
	 * @author eKameleon
	 */
	public class Timer extends flash.utils.Timer implements ITimer 
	{
		
		/**
		 * Constructs a new Timer object with the specified delay and repeatCount states. 
		 * The timer does not start automatically; you must call the start() method to start it.
    	 * @param delay The delay between timer events, in milliseconds.
    	 * @param repeatCount Specifies the number of repetitions. If zero, the timer repeats infinitely. If nonzero, the timer runs the specified number of times and then stops.
		 */
		public function Timer( delay:Number, repeatCount:int = 0 )
		{
			super( delay, repeatCount ) ;	
		}
		
	}
	
}
