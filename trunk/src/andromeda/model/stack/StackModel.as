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
package andromeda.model.stack 
{
    import andromeda.model.AbstractModelObject;
    import andromeda.vo.IValueObject;
    
    import vegas.data.Stack;
    import vegas.data.iterator.Iterator;
    import vegas.data.stack.SimpleStack;    

    /**
     * This model use an internal <code class="prettyprint">Stack</code> to register value objects.
     * @author eKameleon
     */
    public class StackModel extends AbstractModelObject 
    {

        /**
         * Creates a new StackModel instance.
         * @param id the id of this model.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */ 
        public function StackModel(id:* = null, bGlobal:Boolean = false, sChannel:String = null)
        {
            super( id, bGlobal, sChannel ) ;
            _stack = initializeStack() ;
        }
        
        /**
         * Default event type when the pop method is invoked.
         */
        public static var POP_VO:String = "onPopVO" ;
            
        /**
         * Default event type when the push method is invoked.
         */
        public static var PUSH_VO:String = "onPushVO" ;

        /**
         * Removes all value objects in the model.
         */
        public override function clear():void
        {
            _stack.clear() ;
            super.clear() ;
        }
        
        /**
         * Returns the event name use in the {@code pop} method.
         * @return the event name use in the {@code pop} method.
         */
        public function getEventTypePOP():String
        {
            return _sPopType ;
        }
            
        /**
         * Returns the event name use in the {@code push} method.
         * @return the event name use in the {@code push} method.
         */
        public function getEventTypePUSH():String
        {
            return _sPushType ;
        }
        
        /**
         * Returns the internal {@code Stack} reference of this model.
         * @return the internal {@code Stack} reference of this model.
         */
        public function getStack():Stack
        {
            return _stack ; 
        }
        
        /**
         * This method is invoked in the constructor of the class to initialize all events.
         * Overrides this method.
         */
        public override function initEventType():void
        {
            super.initEventType() ;
            _sPopType  = POP_VO ;
            _sPushType = PUSH_VO ;
        }        
        
        /**
         * Initialize the internal Stack instance in the constructor of the class.
         * You can overrides this method if you want change the default {@code SimpleStack} use in this model.
         */
        public function initializeStack():Stack
        {
            return new SimpleStack() ;  
        }
    
        /**
         * Returns {@code true} if this model is empty.
         * @return {@code true} if this model is empty.
         */
        public function isEmpty():Boolean 
        { 
            return _stack.isEmpty() ;
        }
    
        /**
         * Returns the iterator of this model.
         * @return the iterator of this model.
         */
        public function iterator():Iterator
        {
            return _stack.iterator() ;  
        }
        
        /**
         * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is poped in the model.
         */ 
        public function notifyPop( vo:IValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sPopType, vo ) ) ;    
        }

        /**
         * Notify a {@code ModelObjectEvent} when a {@code IValueObject} is pushed in the model.
         */ 
        public function notifyPush( vo:IValueObject ):void
        {
            if ( isLocked() )
            {
                return ;
            }
            dispatchEvent( createNewModelObjectEvent( _sPushType, vo ) ) ;    
        }        
        
        /**
         * Removes and returns the lastly pushed value object in the model.
         * @return the lastly pushed value object in the model.
         */
        public function pop():IValueObject
        {
            var vo:IValueObject = _stack.pop() ;
            notifyPop( vo ) ;
            return vo ;
        }

        /**
         * Pushes the passed-in value object to this stack.
         * @param vo The IValueObject to push.
         * @throws ArgumentError If the IValueObject is 'null' or 'undefined'.
         */
        public function push( vo:IValueObject ):void
        {
            if (vo == null)
            {
                throw new ArgumentError( this + " push method failed, the IValueObject passed in argument not must be 'null' or 'undefined'.") ;  
            }
            validate(vo) ;
            _stack.push( vo ) ;
            notifyPush( vo ) ;
        }
                
        /**
         * Sets the event name use in the <code class="prettyprint">pop</code> method.
         */
        public function setEventTypePOP( type:String ):void
        {
            _sPopType = type ;
        }
    
        /**
         * Sets the event name use in the <code class="prettyprint">push</code> method.
         */
        public function setEventTypePUSH( type:String ):void
        {
            _sPushType = type ;
        }
        
        /**
         * Sets the internal Stack of this model. 
         * By default the initializeStack() method is used if the passed-in argument is null.
         */
        public function setStack( s:Stack ):void
        {
            _stack = s || initializeStack() ;   
        }
                
        /**
         * Returns the number of <code class="prettyprint">IValueObject</code> in this model.
         * @return the number of <code class="prettyprint">IValueObject</code> in this model.
         */
        public function size():Number
        {
            return _stack.size() ;
        }   
        
        /**
         * Returns the <code class="prettyprint">Array</code> representation of this object.
         * @return the <code class="prettyprint">Array</code> representation of this object.
         */
        public function toArray():Array
        {
            return _stack.toArray() ;   
        }
        
        /**
         * The internal ModelObjectEvent type use in the <code class="prettyprint">pop</code> method.
         */
        private var _sPopType:String ;
                
        /**
         * The internal ModelObjectEvent type use in the <code class="prettyprint">push</code> method.
         */
        private var _sPushType:String ;        
        
        /**
         * The internal {@code Stack} reference.
         */
        private var _stack:Stack ;        
        
    }
}
