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
package andromeda.model.array 
{
    import andromeda.events.ModelObjectEvent;
    import andromeda.model.AbstractModelObject;
    import andromeda.vo.IValueObject;
    
    import vegas.data.iterator.Iterator;
    import vegas.data.iterator.PageByPageIterator;
    import vegas.events.ArrayEvent;

    /**
     * Defines an <code class="prettyprint">Array</code> model with a 'page by page' iterator.
     * @author eKameleon
     */
    public class PageableArrayModel extends AbstractModelObject
    {

        /**
         * Creates a new PageableArrayModel instance.
         * @param id the id of this model.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function PageableArrayModel(id:* = null, bGlobal:Boolean = false, sChannel:String = null)
        {
            super( id, bGlobal, sChannel );
            _a = new Array() ;
        }
        
        /**
         * Inserts all IValueObject in the array passed in argument.
         * @param datas The array of all value objects to insert in the model.
         * @param noClear (optional) If this argument is <code class="prettyprint">true</code> the clear method isn't called when this process begin.
         * @param noRefresh (optional) If this argument is <code class="prettyprint">true</code> the refresh method isn't called when this process is finish.
         */
        public function addAllVO( datas:Array , noClear:Boolean=false , noRefresh:Boolean=false ):void
        {
            if ( !noClear )
            {
                clear() ;
            }
            var len:uint = datas.length ;
            for ( var i:uint = 0 ; i < len ; i++ )
            {
                var vo:IValueObject = datas[i] as IValueObject ;
                if ( supports( vo ) )
                {
                    _a.push( vo ) ;
                }    
            }
            if ( noRefresh == true )
            {
                return ;    
            }
            refresh() ;
        }

        /**
         * Clear the model.
         */    
        public override function clear():void
        {
            _a = []  ;
            super.clear() ;
        }    

        /**
         * Returns the count of the IValueObject in a page of this model.
         * @return the count of the IValueObject in a page of this model.
         */
        public function getCountVO():uint
        {
            return _voCount ;
        }
        
        /**
         * Returns the current page selected in the model.
         * @return the current page selected in the model.
         */
        public function getCurrentPage():Number
        {
            return _itPage.currentPage() ;    
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">addVO</code> method.
         * @return the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function getEventTypeUPDATE():String
        {
            return _sUpdateType || ModelObjectEvent.UPDATE_VO ;
        }
        
        /**
         * Returns the numbers of page with the current model.
         * @return the numbers of page with the current model.
         */
        public function getPageCount():Number
        {
            return _itPage.pageCount() ;    
        }

        /**
         * Returns <code class="prettyprint">true</code> if the list has a next page.
         * @return <code class="prettyprint">true</code> if the list has a next page.
         */
        public function hasNext():Boolean
        {
            return     _itPage.hasNext() ;
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the list has a previous page.
         * @return <code class="prettyprint">true</code> if the list has a previous page.
         */
        public function hasPrevious():Boolean
        {
            return _itPage.hasPrevious() ;
        }

        /**
         * Returns a PageByPageIterator of this model.
         * @return a PageByPageIterator of this model.
         */
        public function iterator():Iterator
        {
            return new PageByPageIterator( _voCount , _a ) ;    
        }

        /**
         * Seek the iterator in the last page of this object.
         */
        public function lastPage():void
        {
            if ( _itPage != null )
            {
                _itPage.lastPage() ;
            }
        }

        /**
         * Notify an <code class="prettyprint">Event</code> when a <code class="prettyprint">IValueObject</code> is inserted in the model. 
         * If the model countVO value is > 1 notify an ArrayEvent else if the coutVO value is 1 notify a ModelObjectEvent. 
         */ 
        public function notifyUpdate( value:* ):*
        {
            if ( isLocked() == false )
            {
                if ( getCountVO() > 1 )
                {    
                    dispatchEvent( new ArrayEvent( getEventTypeUPDATE() , value as Array ) ) ;
                }
                else
                {
                    dispatchEvent( new ModelObjectEvent( getEventTypeUPDATE() , this , value ) ) ;
                }
            }
            return value ;
        }

        /**
         * Show the next page of the model.
         */
        public function next():*
        {
            if ( hasNext() )
            {
                return notifyUpdate( _itPage.next() ) ;
            }
        }

        /**
         * Show in the previous page in the list or previous screen.
         */
        public function previous():*
        {
            if ( hasPrevious() )
            {
                return notifyUpdate( _itPage.previous() ) ;
            }
        }

        /**
         * Refresh the model.
         */
        public function refresh():void
        {
            if (size() > 0)
            {
                _itPage = new PageByPageIterator ( _voCount , _a ) ;
            }
            else
            {
                _itPage = null ;    
            }
            run() ;
        }
    
        /**
         * Resets the key pointer of the iterator.
         */
        public function reset():void 
        {
            if ( _itPage != null )
            {
                _itPage.reset() ;
            }
        }

        /**
         * Run the model when is initialize. This method don't work if the model is locked.
         * @see ILockable
         */
        public override function run(...arguments:Array):void
        {
            if ( isLocked() ) 
            {
                return ;
            }
            if ( size() > 0 )
            {
                next() ;
            }
        }

        /**
         * Set the count of the IValueObject in a page of this model. 
         * @param n The count value of items in this model. This value must be >=1.
         * @param noRender Indicates if the method call the run method if this argumement is <code class="prettyprint">false</code> (default is <code class="prettyprint">false</code>).
         */
        public function setCountVO( n:uint , noRender:Boolean=false ):void
        {
            _voCount = n > 1 ? n : 1 ;
            if ( noRender == true ) 
            {
                lock() ;
            }
            refresh() ;
            if ( noRender == true ) 
            {
                unlock() ;
            }
        }

        /**
         * Sets the event name use in the <code class="prettyprint">addVO</code> method.
         */
        public function setEventTypeUPDATE( type:String ):void
        {
            _sUpdateType = type ;
        }

        /**
         * Returns the number of <code class="prettyprint">IValueObject</code> in this model.
         * @return the number of <code class="prettyprint">IValueObject</code> in this model.
         */
        public function size():uint
        {
            return _a.length ;    
        }
    
        /**
         * Returns the array representation of all vos in this model.
         * @return the array representation of all vos in this model.
         */
        public function toArray():Array
        {
            return [].contact( _a ) ;    
        }

        /**
         * The internal array of all elements.
         */
        private var _a:Array ; 
        
        /**
         * The current PageByPageIterator instance.
         */
        private var _itPage:PageByPageIterator ;
        
        /**
         * The type of the update event.
         */
        private var _sUpdateType:String ;
    
        /**
         * The numbers of items in the model.
         */
        private var _voCount:Number = 1 ;

    }

}
