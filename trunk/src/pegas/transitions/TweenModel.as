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
    import andromeda.model.AbstractModel;
    
    import pegas.events.TweenEntryEvent;
    
    import vegas.data.Map;
    import vegas.data.iterator.Iterable;
    import vegas.data.iterator.Iterator;
    import vegas.data.map.HashMap;	

    /**
 	 * The model of the Tween class.
	 * @author eKameleon
 	 */
	public class TweenModel extends AbstractModel implements Iterable 
	{

		/**
		 * Creates a new TweenModel instance.
		 * @param id the id of the model.
		 * @param tweens The array to initialize the model with some TweenEntry objects. All no TweenEntry objects are ignored.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
	 	 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
	 	 */
		public function TweenModel(id:* = null, tweens:Array=null, bGlobal:Boolean = false, sChannel:String = null)
		{
			super( id,  bGlobal , sChannel ) ;
			_map = new HashMap() ;
			initEventType() ;
			if ( tweens == null ) return ;
			var size:uint = tweens.length ;
			if (size > 0) 
			{
				var t:TweenEntry ;
				for (var i:Number = 0 ; i < size ; i++) 
				{
					t = tweens[i] as TweenEntry ;
					if ( t != null )
					{
						insert( t.clone() ) ;
					}
				}
			}
		}
		
		/**
		 * Clear the model.
		 */
		public function clear():void 
		{
			_map.clear( ) ;
			dispatchEvent( new TweenEntryEvent( TweenEntryEvent.CLEAR_ENTRY  , this ) ) ;
		}
		
		/**
		 * Returns a shallow copy of this object. This method keep all Tween entries and the id of the original object.
		 * <code class="prettyprint">  
		 * var clone:TweenModel = tp.clone() ;
		 * </code>
	 	 * @return a shallow copy of this object.
	 	 */
		public function clone():*
		{
			return new TweenModel( null , toArray() ) ;
		}
		
		/**
		 * Returns <code class="prettyprint">true</code> if the specified property exist in this model.
		 * @return <code class="prettyprint">true</code> if the specified property exist in this model.
		 */
		public function contains( prop:String ):Boolean 
		{
			return _map.containsKey( prop ) ;
		}
		
		/**
		 * Returns the specified TweenEntry reference.
		 * @return the specified TweenEntry reference.
	 	 */
		public function get( prop:String ):TweenEntry 
		{
			return _map.get( prop ) ;
		}

		/**
	 	 * Returns the event name use in the <code class="prettyprint">insert</code> method.
		 * @return the event name use in the <code class="prettyprint">insert</code> method.
		 */
		public function getEventTypeADD():String
		{
			return _sTypeAdd ;
		}

		/**
	 	 * Returns the event name use in the <code class="prettyprint">clear</code> method.
	 	 * @return the event name use in the <code class="prettyprint">clear</code> method.
	 	 */
		public function getEventTypeCLEAR():String
		{
			return _sTypeClear ;
		}
		
		/**
		 * Returns the event name use in the <code class="prettyprint">remove</code> method.
		 * @return the event name use in the <code class="prettyprint">remove</code> method.
	 	 */
		public function getEventTypeREMOVE():String
		{
			return _sTypeRemove ;
		}
		
		/**
		 * Returns the Array representation of all property names in this model.
		 * @return the Array representation of all property names in this model.
		 */
		public function getProperties():Array 
		{
			return _map.getKeys() ;
		}
		
		/**
		 * Initialize the event types of this model.
		 */
		public function initEventType():void
		{
			_sTypeAdd    = TweenEntryEvent.ADD_ENTRY    ;
			_sTypeClear  = TweenEntryEvent.CLEAR_ENTRY  ;
			_sTypeRemove = TweenEntryEvent.REMOVE_ENTRY ;
		}
		
		/**
		 * Inserts a new TweenEntry in the model.
		 */
		public function insert( entry:TweenEntry ):Boolean 
		{
			var p:String = entry.prop ;
			if ( p != null ) 
			{
				_map.put( p, entry ) ;
				dispatchEvent( new TweenEntryEvent( getEventTypeADD() , this, entry ) ) ;
				return true ;
			}
			else 
			{
				return false ;
			}
		}
		
		/**
		 * Returns an iterator of this model.
		 * @return an iterator of this model.
		 */
		public function iterator():Iterator
		{
			return _map.iterator() ;
		}

		/**
		 * Removes an entry in the model.
		 */
		public function remove( entry:* ):Boolean 
		{
			var p:String ;
			if ( entry is String ) 
			{
				p = entry as String ;
			}
			else if ( entry is TweenEntry ) 
			{
				p = entry.prop ;
			}
			else 
			{
				throw new ArgumentError(this + " remove method failed with an unknow argument value : " + entry ) ;
			} 
			if ( contains(p) ) 
			{
				var t:TweenEntry = _map.remove( p ) ;
				if (t != null) 
				{
					dispatchEvent( new TweenEntryEvent( getEventTypeREMOVE() , this, t ) ) ;
					return true ;
				}
			} 
			else 
			{
				return false ;
			}
			return false ;
		}

		/**
		 * Sets the event name use in the <code class="prettyprint">insert</code> method.
		 */
		public function setEventTypeADD( type:String=null ):void
		{
			_sTypeAdd = type || TweenEntryEvent.ADD_ENTRY ;
		}
		
		/**
	 	 * Sets the event name use in the <code class="prettyprint">clear</code> method.
	 	 */
		public function setEventTypeCLEAR( type:String=null ):void
		{
			_sTypeClear = type || TweenEntryEvent.CLEAR_ENTRY ;
		}

		/**
		 * Sets the event name use in the <code class="prettyprint">remove</code> method.
		 */
		public function setEventTypeREMOVE( type:String=null ):void
		{
			_sTypeRemove = type || TweenEntryEvent.REMOVE_ENTRY ;
		}
		
		/**
		 * Returns the number of elements in the model.
		 * @return the number of elements in the model.
		 */
		public function size():Number 
		{
			return _map.size( ) ;
		}

		/**
		 * Returns the Array representation of all TweenEntry objects in this model.
		 * @return the Array representation of all TweenEntry objects in this model.
		 */
		public function toArray():Array 
		{
			return _map.getValues( ) ;
		}
				
		/**
	     * Returns the Map representation of all TweenEntry objects in this model.
	 	 * @return the Map representation of all TweenEntry objects in this model.
	 	 */
		public function toMap():Map 
		{
			return _map.clone() ;		
		}

		/**
		 * Returns the String representation of this object.
	 	 * @return the String representation of this object.
		 */
		public override function toString():String 
		{
			var s:String = "[TweenModel" ; 
			if ( _map.size() > 0 )
			{
				s += ":" + _map.toString() ;
			}
			s += "]" ;
			return s ;
		}

		/**
		 * @private
		 */
		private var _sTypeAdd:String ;
			
		/**
		 * @private
		 */
		private var _sTypeClear:String ;
		
		/**
		 * @private
		 */
		private var _sTypeRemove:String	 ;
		
		/**
		 * @private
		 */
		private var _map:HashMap ;
		
	}
}
