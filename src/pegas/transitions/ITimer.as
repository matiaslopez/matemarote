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

	/**
	 * This interface defines the methods to implement timer object create tile interval process.
	 * @author eKameleon
	 */
	public interface ITimer
	{
		
		/**
		 * The total number of times the timer has fired since it started at zero.
		 */
		function get currentCount():int ;
		
		/**
		 * The delay, in milliseconds, between timer events.
		 */
		function get delay():Number ;
		function set delay( time:Number ):void ;
		
		/**
		 * The total number of times the timer is set to run.
		 */
		function get repeatCount():int ;
		function set repeatCount( count:int ):void ;
		
		/**
		 * Stops the timer, if it is running, and sets the currentCount property back to 0, like the reset button of a stopwatch.
		 */
		function reset():void ;
		
		/**
		 * Starts the timer, if it is not already running.
		 */
		function start():void ;
		
		/**
		 * Stops the timer.
		 */
		function stop():void ;
		
	}
}
