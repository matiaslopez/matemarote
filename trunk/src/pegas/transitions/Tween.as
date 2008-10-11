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
    import pegas.transitions.Motion;    	

    /**
	 * The Tween class lets you use ActionScript to move, resize, and fade movie clips easily on the Stage by specifying a property of the target movie clip to be tween animated over a number of frames or seconds.
	 * The Tween class also lets you specify a variety of easing methods.
	 * <p>Easing refers to gradual acceleration or deceleration during an animation, which helps your animations appear more realistic.</p>
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import pegas.transitions.Tween ;
	 * var tw:Tween = new Tween (mc, "_x", Elastic.easeOut, mc._x, 400, 2, true, true) ;
	 * </pre>
	 * @author eKameleon
	 */
	public class Tween extends Motion 
	{

		/**
		 * Creates a new Tween instance.
		 * <p><b>Usage :</b></p>
	 	 * <pre class="prettyprint">
	 	 * var tw:Tween = new Tween( obj, prop:String, e:Function, b:Number, f:Number, d:Number , u:Boolean, auto:Boolean ) ;
	 	 * var tw:Tween = new Tween( obj, entries , d:Number , u:Boolean, auto:Boolean ) ;
	 	 * </pre>
	 	 */
		public function Tween( ...arguments:Array )
		{
			
			_model = new TweenModel() ;
			
			if (arguments[0] != null) 
			{
				target = arguments[0] ;
			}
			
			var auto:Boolean ;
		
			var l:uint = arguments.length ;
			if ( l > 1 )
			{
				if ( arguments[1] is Array ) 
				{
					model      = arguments[1] ;
					duration   = arguments[2] > 0 ? arguments[2] : null ;
					useSeconds = arguments[3] == true ;
					auto       = arguments[4] == true ;
					setGlobal( arguments[5] || null , arguments[6] || null ) ;				
				}
				else
				{
					insert( new TweenEntry( arguments[1] , arguments[2], arguments[3], arguments[4]) )  ;
					duration   = ( arguments[5] > 0 ) ? arguments[5] : null ;
					useSeconds = arguments[6] == true ;
					auto       = arguments[7] == true ; // auto start
				}
			}
				
			if ( auto ) 
			{
				run() ;
			}
		
		}
		
		/**
		 * (read-write) Determinates the model of this Tween.
		 * @see pegas.transitions.TweenModel
		 */
		public function get model():* 
		{
			return _model ;
		}
		
		/**
		 * @private
		 */
		public function set model( o:* ):void 
		{
            if ( o is TweenModel ) 
            {
                _model = o as TweenModel ;
            }
            else if ( o is Array ) 
            {
                _model = new TweenModel( null , o as Array ) ;
            }
            else 
            {
                _model = new TweenModel() ;
            }
		}

		/**
		 * Removes all entries in the model of this Tween object.
		 */
		public function clear():void 
		{
			if ( running ) 
			{
				this.stop() ;
		}	
			if ( _model )
			{
				_model.clear() ;
			}
			notifyCleared() ;
		}

		/**
		 * Returns a shallow copy of this Tween object.
		 * @return a shallow copy of this Tween object.
		 */
		public override function clone():* 
		{
			var t:Tween = new Tween() ;
			t.target     = target ;
			t.duration   = duration ;
			t.useSeconds = useSeconds ;
			if (size() > 0) 
			{
				t.model = model.clone() ;
			}
			return t ;
		}
        	
		/**
		 * Inserts a TweenEnry in the model of the Tween object.
		 * @param entry a TweenEntry reference.
		 */
		public function insert( entry:TweenEntry ):void 
		{
			_model.insert( entry ) ;
		}

		/**
		 * Inserts a new property in the Tween object.
		 * @param prop the string representation of the number property.
		 * @param easing the easing method used by the Tween on this property.
		 * @param begin the begin value.
		 * @param finish the finish value.
		 * @return a TweenEntry defined by the specified arguments.
		 */
		public function insertProperty( prop:String=null , easing:Function=null, begin:Number=NaN, finish:Number=NaN):TweenEntry 
		{ 
			var e:TweenEntry = new TweenEntry(prop, easing, begin, finish) ;
			insert(e) ;
			return e ;
		}

		/**
		 * Remove a TweenEntry in the Tween Object.
		 * @param entry The entry to remove in this Tween.
		 */
		public function remove( entry:TweenEntry ):Boolean 
		{
			return _model.remove( entry ) ;
		}	
	
		/**
		 * Remove a property in the Tween Object.
		 */
		public function removeProperty( prop:String ):Boolean 
		{
			return _model.remove( prop ) ;
		}

		/**
		 * Set the TweenEntry property of this TweenLite object.
		 * @param prop the property name of the object to change.
		 * @param easing the easing function of the tween entry.
		 * @param begin the begin value.
	 	 * @param finish the finish value. 
		 */
		public function setTweenEntry( prop:String, easing:Function , begin:Number , finish:Number ):void
		{
			if ( _model.contains( prop ) )
			{
				var entry:TweenEntry = _model.get(prop) ;
				entry.easing = easing ; 	
				entry.begin  = begin  ;
				entry.finish = finish ;
			}
			else
			{
				insertProperty.apply(this, arguments) ;	
			}
		}
        
		/**
		 * Returns the numbers of elements(properties) in the model of this Tween.
		 * @return the numbers of elements(properties) in the model of this Tween.
		 */
		public function size():Number 
		{
			return _model.size() ;
		}
	
		/**
		 * Update the current Tween in the time.
		 */
		public override function update():void 
		{
			if ( _model == null || _model.size() == 0 )
			{
				return ;
			}
			var a:Array = _model.toArray() ;
			var l:int   = a.length ;
			while(--l > -1) 
			{
				var e:TweenEntry = a[l] ;
				target[ e.prop ] = e.setPosition( e.getPosition( _time , _duration ) ) ;
			}
			notifyChanged() ;
		}
	
		/**
		 * @private
		 */
		private var _model:TweenModel ;
		
	}
	
}
