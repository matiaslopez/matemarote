/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.display.container 
{
    import flash.events.Event;
    
    import andromeda.events.ActionEvent;
    
    import lunas.display.container.ListContainer;
    import lunas.events.ComponentEvent;
    
    import pegas.transitions.Motion;
    import pegas.transitions.Tween;
    import pegas.transitions.TweenEntry;
    import pegas.transitions.easing.Back;
    
    import system.numeric.Mathematics;	

    /**
	 * This container is a list and can be scrolled.
	 * @author eKameleon
 	*/
	public class ScrollContainer extends ListContainer 
	{

		/**
		 * Creates a new ScrollContainer instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function ScrollContainer(id:* = null, isConfigurable:Boolean = false, name:String = null)
		{

			_tw = new Tween() ;
			_tw.addEventListener( ActionEvent.CHANGE , _refreshChilds ) ;
			_tw.addEventListener( ActionEvent.FINISH , _finish  ) ;

			_entry = new TweenEntry() ;	

			super( id, isConfigurable, name ) ;

			_tw.target = _container ;
			
		}

		/**
		 * Returns the bottom scroll value.
		 * @return the bottom scroll value.
		 */
		public function get bottomScroll():Number 
		{
			return ( maxscroll > 1) ? (scroll + ( childCount -1 ) ) : childCount ;
		}
		
		/**
		 * @private
		 */
		public override function set direction(value:String):void
		{
			_container.x = _container.y = 0 ;
			super.direction = value ;
			speedScroll( (fixScroll == true) ? 1 : scroll ) ;
		}

		/**
		 * Indicates if the scroll is fixed.
		 */
		public var fixScroll:Boolean = false ;	
		
		/**
	 	 * Returns the maxscroll value.
		 * @return the maxscroll value.
		 */
		public function get maxscroll():Number 
		{
			var m:Number = (numChildren - childCount) ;
			if (isNaN(m)) 
			{
				m = 1 ;
			}
			return ( m >= 1 ) ? m+1 : 1 ;
		}
	
		/**
		 * Indicates if the scroll use an easing effect.
		 */
		public var noScrollEasing:Boolean = false ;

		/**
		 * Returns the scroll value of this container.
		 * @return the scroll value of this container.
	 	 */
		public function get scroll():Number 
		{
			return Mathematics.clamp( _scroll , 1 , maxscroll ) ;
		}
			
		/**
		 * Sets the scroll value of this container.
	 	 */
		public function set scroll(n:Number):void 
		{
			setScroll( n ) ;	
		}

		/**
		 * Indicates the scroll easing method.
		 */
		public var scrollEasing:Function = undefined ;
		
		/**
		 * Indicates the scroll duration.
		 */
		public var scrollDuration:Number = 12  ;
		
		/**
		 * Indicates if the container use cacheAsBitmap flag when the scroll is in progress.
		 */
		public var useCacheAsBitmap:Boolean = false ;
		
		/**
		 * Draws the view of the component.
		 */
		public override function draw( ...arguments:Array ):void 
		{
			super.draw() ;
			_clearTween() ;
			if (fixScroll) 
			{
				speedScroll(1) ;
			}
		}

		/**
		 * Returns the current container position.
		 * @return the current container position.
		 */
		public function getContainerPos():Number 
		{
			var index:Number = scroll - 1 ;
			var prop:String = getCoordinateProperty() ;
			return index > 0 ? -1 * getChildAt(index)[prop] : 0 ;
		}

		/**
		 * Invoked when the scroll is finished.
		 */
		public function notifyFinish():void 
		{
			dispatchEvent( new ActionEvent( ActionEvent.FINISH , this ) ) ;
		}
	
		/**
		 * Notify a scroll ComponentEvent.
		 */
		public function notifyScroll():void 
		{
			fireComponentEvent( ComponentEvent.SCROLL ) ;
		}

		/**
		 * Invoked when the scroll is started.
		 */
		public function notifyStart():void 
		{
			dispatchEvent( new ActionEvent( ActionEvent.START , this ) ) ;
		}

		/**
		 * Sets the scroll value of the container.
		 * @param n the scroll value.
		 * @param noEvent This optional flag disabled the scroll event notify in this method if it's <code class="prettyprint">true</code>.
		 */
		public function setScroll(n:Number, noEvent:Boolean=false ):void  
		{
			if ( n == _scroll ) 
			{
				return ;
			}
			if ( maxscroll > 0 ) 
			{
				_scroll = n ;
				_changeScroll() ;
				if ( noEvent == false ) 
				{
					notifyScroll() ;
				}
			}
			else 
			{
				_scroll = 1 ;
			}
		}

		/**
	 	 * Scroll the container without scroll and without notify an event.
		 */
		public function speedScroll( n:Number ):void 
		{
			_clearTween() ;
			var pro:String = getCoordinateProperty() ;
			var inv:String = (pro == propY) ? propX : propY ;
			_scroll = ( maxscroll > 0) ? n : 1 ;
			_container[ pro ] = getContainerPos() ;
			_container[ inv ] = 0 ;
		}

		/**
		 * Invoked to refreshChilds during the scroll of this container.
		 */
		protected function _refreshChilds( ...arguments:Array ):void 
		{
			// overrides this method.
		}
		
		/**
	 	 * @private
	 	 */
		private var _entry:TweenEntry ;
		
		/**
		 * @private
		 */
		private var _scroll:Number = 0 ;
		
		/**
		 * @private
		 */
		private var _tw:Tween ;
		
		/**
		 * @private
		 */
		private function _changeScroll():void 
		{
			
			if ( _tw != null )
			{
				if ( _tw.running ) 
				{
					_tw.stop() ;
				}
			}
		
			var prop:String = getCoordinateProperty() ;
			var pos:Number  = getContainerPos () ;
			
			var inv:String = (prop == propY) ? propX : propY ;
			
			_container[inv] = 0 ;
			
			notifyStart() ;
					
			if ( noScrollEasing ) 
			{
				_container[prop] = pos ;
				_refreshChilds() ;
				notifyFinish() ;
			} 
			else 
			{
					
				_tw.clear() ;
				
				_entry.prop   = prop ;
				_entry.easing = scrollEasing || Back.easeOut ;
				_entry.begin  = _container[prop] ;
				_entry.finish = pos ;
					
				cacheAsBitmap = useCacheAsBitmap ;
							
				_tw.insert( _entry ) ;
				_tw.duration = isNaN( scrollDuration ) ? 24 : scrollDuration ;
				_tw.run() ;
						
			}
		}	

		/**
		 * @private
		 */
		private function _clearTween():void 
		{
			if ( _tw != null )
			{
				if ( _tw.running )
				{
					_tw.stop() ;
				}
			} 
		}

		/**
		 * @private
		 */
		private function _finish( e:Event ):void
		{
			cacheAsBitmap = false ;
			notifyFinish() ;	
		}
		
	}
}

