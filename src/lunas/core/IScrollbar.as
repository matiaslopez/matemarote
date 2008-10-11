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
    import flash.display.Sprite;
    import flash.events.Event;
    
    import lunas.core.IProgressbar;	

    /**
	 * This interface defines all methods to create scrollbar components.
	 * @author eKameleon
	 */
	public interface IScrollbar extends IProgressbar
	{
		
		/**
		 * The bar display of the scrollbar.
		 */
		function get bar():Sprite ;
		function set bar( bar:Sprite ):void ;

		/**
		 * Indicates if the layout direction of the thumb is invert.
		 */
		function get invert():Boolean ;
		function set invert( b:Boolean ):void ;
			
		/**
		 * (read-only) Indicates if the bar is dragging.
		 */
		function get isDragging():Boolean ; 
        
		/**
		 * (Read-write) The thumb display of the scrollbar.
		 */
		function get thumb():Sprite ;
		function set thumb( thumb:Sprite ):void ;
		
        /**
         * (Read-write) Determinates the size of the thumb.
         */
        function get thumbSize():Number ;
        function set thumbSize( value:Number ):void ;
		
		/**
		 * Invoked when the bar is dragging.
		 */
		function dragging( ...args:Array ):void ;
		
		/**
		 * Dispatchs an event when the user drag the bar.
		 */
		function notifyDrag():void ;
		
		/**
		 * Dispatchs an event when the user start to drag the bar.
		 */
		function notifyStartDrag():void ;
		
		/**
		 * Dispatchs an event when the user stop to drag the bar.
		 */
		function notifyStopDrag():void ;
		
		/**
		 * Invoked when the user start to drag the bar.
		 */
		function startDragging( e:Event=null ):void ; 

		/**
		 * Invoked when the user stop to drag the bar.
		 */
		function stopDragging( e:Event=null ):void ; 
		
	}
}
