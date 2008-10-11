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
package andromeda.model.queue 
{
    import andromeda.model.AbstractModelObject;
    import andromeda.vo.IValueObject;
    
    import vegas.data.Queue;
    import vegas.data.iterator.Iterator;
    import vegas.data.queue.LinearQueue;    

    /**
     * This model use an internal <code class="prettyprint">Queue</code> to register value objects.
     * @author eKameleon
     */
    public class QueueModel extends AbstractModelObject 
    {

        /**
         * Creates a new QueueModel instance.
         * @param id the id of this model.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */ 
        public function QueueModel(id:* = null, bGlobal:Boolean = false, sChannel:String = null)
        {
            super( id, bGlobal, sChannel );
            _queue = initializeQueue() ;
        }
        
        /**
         * Default event type when the dequeue method is invoked.
         */
        public static const DEQUEUE_VO:String = "onDequeueVO" ;
            
        /**
         * Default event type when the enqueue method is invoked.
         */
        public static const ENQUEUE_VO:String = "onEnqueueVO" ;        
        
        /**
         * Removes all value objects in the model.
         */
        public override function clear():void
        {
            _queue.clear() ;
            super.clear() ;
        }
        
        /**
         * Dequeues the head value object in the model.
         */
        public function dequeue():*
        {
            var r:* = _queue.poll() ;
            notifyDequeue( r ) ;
            return r ;
        }
        
        /**
         * Enqueues a value object in the model.
         */
        public function enqueue( vo:IValueObject ):Boolean
        {   
            if (vo == null)
        {   
                throw new ArgumentError( this + " enqueue method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;  
            }
            validate(vo) ;
            var b:Boolean = _queue.enqueue( vo ) ;
            notifyEnqueue( vo ) ;
            return b ;
        }
        
        /**
         * Returns the event name use in the {@code dequeue} method.
         * @return the event name use in the {@code dequeue} method.
         */
        public function getEventTypeDEQUEUE():String
        {
            return _sDequeueType ;
        }
            
        /**
         * Returns the event name use in the {@code enqueue} method.
         * @return the event name use in the {@code enqueue} method.
         */
        public function getEventTypeENQUEUE():String
        {
            return _sEnqueueType ;
        }
                        
        /**
         * Returns the internal Queue reference of this model.
         * @return the internal Queue reference of this model.
         */
        public function getQueue():Queue
        {
            return _queue ; 
        }        
        
        /**
         * This method is invoked in the constructor of the class to initialize all events.
         * Overrides this method.
         */
        public override function initEventType():void
        {
            super.initEventType() ;
            _sDequeueType = DEQUEUE_VO ;
            _sEnqueueType = ENQUEUE_VO ;
        }        
        
        /**
         * Initialize the internal Queue instance in the constructor of the class.
         * You can overrides this method if you want change the default LinearQueue use in this model.
         */
        public function initializeQueue():Queue
        {
            return new LinearQueue() ;  
        }
        
        /**
         * Returns {@code true} if this model is empty.
         * @return {@code true} if this model is empty.
         */
        public function isEmpty():Boolean 
        { 
            return _queue.isEmpty() ;
        }
        
        /**
         * Returns the iterator of this model.
         * @return the iterator of this model.
         */
        public function iterator():Iterator
        {
            return _queue.iterator() ;  
        }

        /**
         * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is dequeue in the model.
         */ 
        public function notifyDequeue( vo:IValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sDequeueType , vo ) ) ;
        }
        
        /**
        * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is enqueue in the model.
        */ 
        public function notifyEnqueue( vo:IValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sEnqueueType , vo ) ) ;
        }
                
        /**
         * Sets the event name use in the <code class="prettyprint">dequeue</code> method.
         */
        public function setEventTypeDEQUEUE( type:String ):void
        {
            _sDequeueType = type ;
        }
    
        /**
         * Sets the event name use in the <code class="prettyprint">enqueue</code> method.
         */
        public function setEventTypeENQUEUE( type:String ):void
        {
            _sEnqueueType = type ;
        }
                
        /**
         * Sets the internal Queue of this model. 
         * By default the initializeQueue() method is used if the passed-in argument is null.
         */
        public function setQueue( queue:Queue ):void
        {
            _queue = queue || initializeQueue() ;  
        }
            
        /**
         * Returns the number of <code class="prettyprint">IValueObject</code> in this model.
         * @return the number of <code class="prettyprint">IValueObject</code> in this model.
         */
        public function size():Number
        {
            return _queue.size() ;
        }        
        
        /**
         * Returns the <code class="prettyprint">Array</code> representation of this object.
         * @return the <code class="prettyprint">Array</code> representation of this object.
         */
        public function toArray():Array
        {
            return _queue.toArray() ;   
        }        
            
        /**
         * The internal {@code Queue} reference.
         */
        private var _queue:Queue ;        
        
        /**
         * The internal ModelObjectEvent type use in the dequeue method.
         */
        private var _sDequeueType:String ;
                
        /**
         * The internal ModelObjectEvent type use in the enqueue method.
         */
        private var _sEnqueueType:String ;        
        
    }
}
