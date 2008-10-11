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
package andromeda.model.map 
{
    import andromeda.events.ModelObjectEvent;
    import andromeda.model.AbstractModelObject;
    import andromeda.vo.IValueObject;
    
    import vegas.data.Map;
    import vegas.data.iterator.Iterable;
    import vegas.data.iterator.Iterator;
    import vegas.data.map.HashMap;
    import vegas.errors.Warning;    

    /**
     * This model use an internal <code class="prettyprint">Map</code> to register value objects with a specific key.
     * @author eKameleon
     */
    public class MapModel extends AbstractModelObject implements Iterable 
    {

        /**
         * Creates a new MapModel instance.
         * @param id the id of this model.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel (optional) the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function MapModel(id:* = null, bGlobal:Boolean = false, sChannel:String=null )
        {
            super( id , bGlobal , sChannel );
            _map = initializeMap() ;
        }
        
        /**
         * Inserts a value object in the model.
         * @throws ArgumentError if the argument of this method is 'null' or 'undefined'. 
         * @throws Warning if the <code class="prettyprint">IValueObject</code> passed in argument is already register in the model.
         */
        public function addVO( vo:IValueObject ):void
        {
            if (vo == null)
            {
                throw new ArgumentError( this + " addVO method failed, the argument passed in argument not must be 'null' or 'undefined'.") ;    
            }
            validate(vo) ;
            if ( !_map.containsKey( vo.id ) )
            {
                _map.put( vo.id , vo ) ;
                notifyAdd(vo) ;
            }
            else
            {
                throw new Warning( this + " addVO method failed, the IValueObject passed in argument already register in the model, you must remove this 'id' key before add a new value object.") ;    
            }
        }
        
        /**
         * Removes all value objects in the model.
         */
        public override function clear():void
        {
            _map.clear() ;
            super.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified IValueObject.
         * @return <code class="prettyprint">true</code> if the model contains the specified IValueObject.
         */
        public function contains( vo:IValueObject ):Boolean
        {
            return _map.containsValue( vo ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified id key in argument.
         * @return <code class="prettyprint">true</code> if the model contains the specified id key in argument
         */
        public function containsByID( id:* ):Boolean
        {
            return _map.containsKey( id ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified attribute value.
         * @return <code class="prettyprint">true</code> if the model contains the specified id key in argument
         */
        public function containsByProperty( propName:String , value:* ):Boolean
        {
            if ( propName == null )
            {    
                return false ;
            }    
            var datas:Array = _map.getValues() ;
            var size:uint = datas.length ;
            if (size > 0)
            {
                while ( --size > -1 )
                {
                    if ( datas[size][propName] == value )
                    {
                        return true ;
                    }
                }
                return false ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">addVO</code> method.
         * @return the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function getEventTypeADD():String
        {
            return _sAddType ;
        }

        /**
         * Returns the event name use in the <code class="prettyprint">removeVO</code> method.
         * @return the event name use in the <code class="prettyprint">removeVO</code> method.
         */
        public function getEventTypeREMOVE():String
        {
            return _sRemoveType ;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">updateVO</code> method.
         * @return the event name use in the <code class="prettyprint">updateVO</code> method.
         */
        public function getEventTypeUPDATE():String
        {
            return _sUpdateType ;
        }

        /**
         * Returns the internal map of this model.
         * @return the internal map of this model.
         */
        public function getMap():Map
        {
            return _map ;    
        }

        /**
         * Returns the IValueObject defined by the id passed in argument.
         * @return the IValueObject defined by the id passed in argument.
         */
        public function getVO( id:* ):IValueObject
        {
            return _map.get( id ) ;
        }
        
        /**
         * This method is invoked in the constructor of the class to initialize all events.
         * Overrides this method.
         */
        public override function initEventType():void
        {
            super.initEventType() ;
            _sAddType    = ModelObjectEvent.ADD_VO ;
            _sRemoveType = ModelObjectEvent.REMOVE_VO ;
            _sUpdateType = ModelObjectEvent.UPDATE_VO ;
        }

        /**
         * Initialize the internal Map instance in the constructor of the class.
         * You can overrides this method if you want change the default HashMap use in this model.
         */
        public function initializeMap():Map
        {
            return new HashMap() ;    
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model is empty.
         * @return <code class="prettyprint">true</code> if the model is empty.
         */
        public function isEmpty():Boolean 
        {
            return _map.isEmpty() ;    
        }
        
        /**
         * Returns the iterator of this model.
         * @return the iterator of this model.
         */
        public function iterator():Iterator
        {
            return _map.iterator() ;
        }

        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">IValueObject</code> is inserted in the model.
         */ 
        public function notifyAdd( vo:IValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sAddType , vo ) ) ;
        }

        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">IValueObject</code> is removed in the model.
         */ 
        public function notifyRemove( vo:IValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sRemoveType , vo ) ) ;
        }
        
        /**
         * Notify a <code class="prettyprint">ModelObjectEvent</code> when a <code class="prettyprint">IValueObject</code> is updated in the model.
         */ 
        public function notifyUpdate( vo:IValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sUpdateType , vo ) ) ;
        }

        /**
         * Removes a value object in the model.
         */
        public function removeVO( vo:IValueObject ):void
        {
            if (vo == null)
            {
                throw new ArgumentError( this + " removeVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;    
            }    
            validate(vo) ;
            if ( _map.containsKey( vo.id ) )
            {
                _map.remove( vo.id ) ;
                notifyRemove( vo ) ;
            }
            else
            {
                throw new Warning( this + " removeVO method failed, the id passed in argument allready register in the model, you must remove this 'id' key before add a noew value object.") ;    
            }
        }
    
        /**
         * Sets the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function setEventTypeADD( type:String ):void
        {
            _sAddType = type ;
        }
    
        /**
         * Sets the event name use in the <code class="prettyprint">removeVO</code> method.
         */
        public function setEventTypeREMOVE( type:String ):void
        {
            _sRemoveType = type ;
        }

        /**
         * Sets the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function setEventTypeUPDATE( type:String ):void
        {
            _sUpdateType = type ;
        }

        /**
         * Sets the internal map of this model. By default the 'initializeMap' method is used if the passed-in argument is null.
         */
        public function setMap( m:Map ):void
        {
            _map = m || initializeMap() ;
        }

        /**
         * Returns the number of <code class="prettyprint">IValueObject</code> in this model.
         * @return the number of <code class="prettyprint">IValueObject</code> in this model.
         */
        public function size():Number
        {
            return _map.size() ;
        }

        /**
         * Update a value object in the model.
         * @throws Warning if the value object passed-in argument don't exist.
         */
        public function updateVO( vo:IValueObject ):void
        {
            if ( _map.containsKey( vo.id ) )
            {
                _map.put( vo.id , vo ) ;
                notifyUpdate(vo) ;
            }
            else
            {
                throw new Warning( this + " updateVO method failed, the value object passed in argument don't exist in the model.") ;
            }
        }
        
        /**
         * The internal map of this model.
         */
        private var _map:Map ;
        
        /**
         * The internal ModelObjectEvent type use in the addVO method.
         */
        private var _sAddType:String ;
                
        /**
         * The internal ModelObjectEvent type use in the removeVO method.
         */
        private var _sRemoveType:String ;
        
        /**
         * The internal ModelObjectEvent type when the update event type is use.
         */
        private var _sUpdateType:String ;

        
    }

}
