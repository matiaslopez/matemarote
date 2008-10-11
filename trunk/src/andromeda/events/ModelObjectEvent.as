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
package andromeda.events
{
    import flash.events.Event;
    
    import andromeda.model.IModelObject;
    import andromeda.vo.IValueObject;
    
    import vegas.events.BasicEvent;    

    /**
     * The ModelObjectEvent is the basic event use in a IModelObject to notify changed.
     * @author eKameleon
     */
    public class ModelObjectEvent extends BasicEvent
    {
        
        /**
         * Creates a new ModelObjectEvent instance.
         * @param type the type of the event.
         * @param (optional) model the IModelObject reference of this event.
         * @param (optional) the IValueObject of this event.
         * @param target the target of the event.
         * @param info The information object of this event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */    
        public function ModelObjectEvent(type:String, model:IModelObject=null , vo:IValueObject=null, target:Object = null , context:* = null, bubbles:Boolean=false, cancelable:Boolean=false , time:Number = 0 )
        {
            super(type, target, context, bubbles, cancelable, time );
            setVO( vo ) ;
            setModel ( model ) ;
        }

        /**
         * Default event type when an <code class="prettyprint">IValueObject</code> is inserted in a model.
         */
        public static var ADD_VO:String = "onAddVO" ;
		
        /**
         * Default event type before the change event notify when the current <code class="prettyprint">IValueObject</code> in a model is changed.
         */
        public static var BEFORE_CHANGE_VO:String = "onBeforeChangeVO" ; 		
        
		/**
         * Default event type when all <code class="prettyprint">IValueObject</code> in a model are deleted.
         */
        public static var CLEAR_VO:String = "onClearVO" ;
            
        /**
         * Default event type when the current <code class="prettyprint">IValueObject</code> is changed in the model.
         */
        public static var CHANGE_VO:String = "onChangeVO" ;
    
        /**
         * Default event type when an <code class="prettyprint">IValueObject</code> is removed in a model.
         */
        public static var REMOVE_VO:String = "onRemoveVO" ;
            
        /**
         * Default event type when the an <code class="prettyprint">IValueObject</code> in the model is updated.
         */
        public static var UPDATE_VO:String = "onUpdateVO" ;
        
        /**
         * Returns the shallow copy of this object.
         * @return the shallow copy of this object.
         */
        public override function clone():Event 
        {
            return new ModelObjectEvent( type, getModel() , getVO(), target, context ) ;
        }
        
        /**
         * Returns the IModelObject reference of this event.
         * @return the IModelObject reference of this event.
         */
        public function getModel():IModelObject
        {
            return _model as IModelObject ;    
        }
        
        /**
         * Returns a IValueObject reference.
         * @return a IValueObject reference.
         */
        public function getVO():IValueObject
        {
            return _vo ;    
        }

        /**
         * Sets the IModelObject reference of this event.
         */
        public function setModel( model:IModelObject ):void
        {
            _model = model || null ;    
        }
    
        /**
         * Sets the IValueObject reference.
         */
        public function setVO( vo:IValueObject ):void
        {
            _vo = vo || null ;    
        }
        
        /**
         * @private
         */
        private var _model:IModelObject ;    

        /**
         * @private
         */
        private var _vo:IValueObject ;
            
    }

}