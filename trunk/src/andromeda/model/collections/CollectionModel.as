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
package andromeda.model.collections 
{
    import andromeda.events.ModelObjectEvent;
    import andromeda.model.AbstractModelObject;
    import andromeda.vo.IValueObject;
    
    import vegas.data.Collection;
    import vegas.data.collections.SimpleCollection;
    import vegas.data.iterator.Iterator;
    import vegas.errors.Warning;    

    /**
     * This model use an internal <code class="prettyprint">Collection</code> to register value objects.
     * @author eKameleon
     */
    public class CollectionModel extends AbstractModelObject 
    {

        /**
         * Creates a new CollectionModel instance.
         * @param id the id of this model.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel (optional) the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */ 
        public function CollectionModel(id:* = null, bGlobal:Boolean = false, sChannel:String = null)
        {
            super( id, bGlobal, sChannel );
            _co = initializeCollection() ;
        }
        
        /**
         * Inserts a value object in the model.
         * @throws ArgumentError if the argument of this method is 'null' or 'undefined'. 
         * @throws TypeMismatchError if the <code class="prettyprint">IValueObject</code> passed in argument isn't valide.
         */
        public function addVO( vo:IValueObject ):Boolean
        {
            if (vo == null)
            {
                throw new ArgumentError( this + " addVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;    
            }
            validate(vo) ;
            var b:Boolean = _co.insert( vo ) ;
            notifyAdd( vo ) ;
            return b ;
        }
        
        /**
         * Removes all value objects in the model.
         */
        public override function clear():void
        {
            _co.clear() ;
            super.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified IValueObject.
         * @return <code class="prettyprint">true</code> if the model contains the specified IValueObject.
         */
        public function contains( vo:IValueObject ):Boolean
        {
            return _co.contains( vo ) ;
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
            var datas:Array = _co.toArray() ;
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
         * Returns the internal Collection of this model.
         * @return the internal Collection of this model.
         */
        public function getCollection():Collection
        {
            return _co ;   
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
         * This method is invoked in the constructor of the class to initialize all events.
         * Overrides this method.
         */
        public override function initEventType():void
        {
            super.initEventType() ;
            _sAddType    = ModelObjectEvent.ADD_VO ;
            _sRemoveType = ModelObjectEvent.REMOVE_VO ;
        }
                
        /**
         * Initialize the internal Collection instance in the constructor of the class.
         * You can overrides this method if you want change the default SimpleCollection use in this model.
         */
        public function initializeCollection():Collection
        {
            return new SimpleCollection() ; 
        }  
        
        /**
         * Returns {@code true} if this model is empty.
         * @return {@code true} if this model is empty.
         */
        public function isEmpty():Boolean 
        { 
            return _co.isEmpty() ;
        }
        
        /**
         * Returns the iterator of this model.
         * @return the iterator of this model.
         */
        public function iterator():Iterator
        {
            return _co.iterator() ;
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
         * Removes a value object in the model.
         * @throws ArgumentError If the IValueObject passed in argument not must be 'null' or 'undefined'.
         * @throws Warning if the value object don't exist in the model.
         */
        public function removeVO( vo:IValueObject ):*
        {
            var r:* ;
            if (vo == null)
            {
                throw new ArgumentError( this + " removeVO method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ; 
            }
            validate(vo) ;
            if ( _co.contains( vo ) )
            {
                r = _co.remove( vo ) ;
                notifyRemove( vo ) ;
            }
            else
            {
                throw new Warning( this + " removeVO method failed, the value object don't exist in the model.") ;  
            }
            return r ;
        }        
        
        /**
         * Sets the internal Collection of this model. 
         * By default the initializeCollection() method is used if the passed-in argument is null.
         */
        public function setCollection( co:Collection ):void
        {
            _co = co || initializeCollection() ;  
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
         * Returns the number of <code class="prettyprint">IValueObject</code> in this model.
         * @return the number of <code class="prettyprint">IValueObject</code> in this model.
         */
        public function size():Number
        {
            return _co.size() ;
        }
        
        /**
         * Returns the <code class="prettyprint">Array</code> representation of this object.
         * @return the <code class="prettyprint">Array</code> representation of this object.
         */
        public function toArray():Array
        {
            return _co.toArray() ;  
        }
            
        /**
         * The internal Collection of this model.
         */
        private var _co:Collection ;
        
        /**
         * The internal ModelObjectEvent type use in the addVO method.
         */
        private var _sAddType:String ;
                
        /**
         * The internal ModelObjectEvent type use in the removeVO method.
         */
        private var _sRemoveType:String ;
        
    }
}
