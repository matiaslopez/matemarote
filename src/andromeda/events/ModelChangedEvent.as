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
  
*/package andromeda.events
{
    import flash.events.Event;

    import vegas.events.BasicEvent;    
    
    /**
     * This event is used with some models.
     * @author eKameleon
     */
    public class ModelChangedEvent extends BasicEvent
    {
        
        /**
         * Creates a new ModelChangedEvent instance.
         */
        public function ModelChangedEvent
        (
            eventName:String=null
            , data:* = null, fieldName:String = null
            , firstItem:uint=0, index:uint=0, lastItem:uint=0
            , removedIDs:Array = null , removedItems:Array = null 
            , target:Object = null, context:* = null 
            , bubbles:Boolean = false, cancelable:Boolean = false
        ) {
            super(ModelChangedEvent.MODEL_CHANGED, target, context, bubbles, cancelable);
            this.eventName = eventName ;
            this.data = data ;
            this.fieldName = fieldName ;
            this.firstItem = firstItem ;
            this.index = index ;
            this.lastItem = lastItem ;
            this.removedIDs = removedIDs ;
            this.removedItems = removedItems ;
        }

        /**
         * The type of a ModelChangedEvent when an item is added in this model.
         */
        public static const ADD_ITEMS:String = "addItems" ; 

        /**
         * The type of a ModelChangedEvent when clear all items in the model.
         */
        public static const CLEAR_ITEMS:String = "clear" ;

        /**
         * The type of a ModelChangedEvent when the model is changed.
         */
        public static const MODEL_CHANGED:String = "modelChanged" ;

        /**
         * The type of a ModelChangedEvent when an item is removed in this model.
         */
        public static const REMOVE_ITEMS:String = "removeItems" ;

        /**
         * The type of a ModelChangedEvent when the model is sorted.
         */
        public static const SORT_ITEMS:String = "sortItems" ;

        /**
         * The type of a ModelChangedEvent when all is update in the model.
         */
        public static const UPDATE_ALL:String = "updateAll" ;

        /**
         * The type of a ModelChangedEvent when a field in the model is updated.
         */
        public static const UPDATE_FIELD:String = "updateField" ;

        /**
         * The type of a ModelChangedEvent when an item in the model changed.
         */
        public static const UPDATE_ITEMS:String = "updateItems" ;

        /**
         * The data of this event.
         */
        public var data:* = null ;
        
        /**
         * The event name of this event (same like type value).
         */
        public var eventName:String = null ;
        
        /**
         * The name of the field that was updated, or null. 
         */
        public var fieldName:String = null ;

        /**
         * The index of the first item that was added, changed, or removed. 
         */
        public var firstItem:uint = 0 ;

        /**
         * The index of the item of this event.
         */
        public var index:uint = 0  ;

        /**
         * The lastItem value of this event.
         */    
        public var lastItem:uint = 0 ;

        /**
         * An array containing the IDs of the items that were removed, or null. 
         */
        public var removedIDs:Array = null ;

        /**
         * An array containing the items that were removed from the data provider, or null. 
         */
        public var removedItems:Array = null ;
            
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():Event
        {
            return new ModelChangedEvent( eventName, data, fieldName , firstItem, index, lastItem, removedIDs, removedItems , bubbles, cancelable ) ;
        }
        
    }
}