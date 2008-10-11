/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.managers 
{
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import flash.display.Stage;
    import flash.events.FocusEvent;
    
    import andromeda.model.AbstractModel;
    
    import vegas.data.iterator.Iterator;
    import vegas.data.map.HashMap;
    import vegas.data.sets.MultiHashSet;    

    /**
     * The TabManager manage visual tab process in the applications.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import asgard.managers.TabManager ;
     * 
     * var manager:TabManager = TabManager.getInstance() ;
     * 
     * manager.auto = true ;
     * 
     * container1.field1.tabIndex = 10 ;
     * container1.field2.tabIndex = 20 ;
     * container1.field3.tabIndex = 30 ;
     * container1.field4.tabIndex = 40 ;
     * 
     * container2.field1.tabIndex = 2 ;
     * container2.field2.tabIndex = 1 ;
     * container2.field3.tabIndex = 4 ;
     * container2.field4.tabIndex = 3 ;
     * 
     * manager.insert("group1", container1.field1 ) ;
     * manager.insert("group1", container1.field2 ) ;
     * manager.insert("group1", container1.field3 ) ;
     * manager.insert("group1", container1.field4 ) ;
     * 
     * manager.insert("group2", container2.field1 ) ;
     * manager.insert("group2", container2.field2 ) ;
     * manager.insert("group2", container2.field3 ) ;
     * manager.insert("group2", container2.field4 ) ;
     * 
     * manager.select("group1") ; // default 
     * 
     * var onKeyDown:Function = function(e:KeyboardEvent):void
     * {
     *     var code:Number = e.keyCode ;
     *     switch( code )
     *     {
     *         case Keyboard.UP :
     *         {
     *             manager.select("group1") ;
     *             break ;
     *         }
     *         case Keyboard.DOWN :
     *         {
     *                 manager.select("group1" , container1.field3 ) ;
     *                 break ;
     *         }
     *         case Keyboard.LEFT :
     *         {
     *                 manager.select("group2") ;
     *                break ;
     *            }
     *            case Keyboard.RIGHT :
     *            {
     *                    manager.select("group2" , container2.field2 ) ;
     *                    break ;
     *            }
     *     }
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , onKeyDown ) ;
     * </pre>
     * @author eKameleon
     */
    public class TabManager extends AbstractModel 
    {

        /**
         * Creates a new TabManager instance.
         * @param id the id of the model.
         * @param id the id of this model.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function TabManager( id:* = null, bGlobal:Boolean = false, sChannel:String = null)
        {
            super( id, bGlobal, sChannel );
            _map = new HashMap() ;
            _set = new MultiHashSet() ;
        }

        /**
         * Indicates if the tab manager use a auto group focus over the interactive objects when there are focused.
         */
        public var auto:Boolean = false ;
        
        /**
         * Removes all elements in this manager.
         */
        public function clear():void 
        {
            unSelect() ;
            if ( _map.size() > 0 )
            {
                var next:InteractiveObject ;
                var it:Iterator = _map.iterator() ;
                while( it.hasNext() )
                {
                    next = it.next() as InteractiveObject ;
                    if ( next != null )
                    {
                        next.removeEventListener(FocusEvent.FOCUS_IN, _onFocusIn) ;
                    }
                }    
            }
            _map.clear() ;
            _set.clear() ;
        }

        /**
         * Checks whether the map contains the specified group id.
         */
        public function contains( id:* ):Boolean
        {
            return _set.containsKey(id) ;    
        }
        
        /**
         * Returns the current group id selected in the manager.
         * @return the current group id selected in the manager.
         */
        public function getCurrent():*
        {
            return _current ;
        }    

        /**
         * Returns the singleton reference of the TabManager class.
         * @return the singleton reference of the TabManager class.
         */
        public static function getInstance():TabManager 
        {
            if (_instance == null)
            {
                _instance = new TabManager();
            }
            return _instance;
        }

        /**
         * Insert a new child object in the manager with the specified id.
         * @param id The key of the group to collect the specified interactive object.
         * @param child The interactive object to collect in the manager.
         * @return <code class="prettyprint">true</code> if the interactive object is inserted in the manager.
         * @throws ArgumentError the id argument not must be 'null' or 'undefined'.
         */
        public function insert( id:* , child:InteractiveObject ):Boolean
        {
            if ( id == null )
            {
                throw new ArgumentError( this + " insert failed, the id argument not must be 'null' or 'undefined'.") ;
            }
            var b:Boolean = _set.put( id , child ) ;
            if ( b )
            {
                child.tabEnabled = false ;
                child.addEventListener(FocusEvent.FOCUS_IN, _onFocusIn, false, 0, true) ;
                _map.put( child , id ) ;
            }
            return b == true ;
        } 

        /**
         * Removes a child object in the manager with the specified id.
         * @param id The key of the group to collect the specified interactive object.
         * @param child The interactive object to collect in the manager.
         * @return <code class="prettyprint">true</code> if the interactive object is removed in the manager.
         * @throws ArgumentError the id argument not must be 'null' or 'undefined'.
         */
        public function remove( id:* , child:InteractiveObject ):Boolean
        {
            if ( id == null )
            {
                throw new ArgumentError( this + " insert failed, the id argument not must be 'null' or 'undefined'.") ;
            }
            var b:Boolean = _set.removeByKey( id , child ) ; 
            if ( b )
            {
                child.tabEnabled = false ;
                child.removeEventListener(FocusEvent.FOCUS_IN, _onFocusIn) ;
                _map.remove( child ) ;
            }
            return b ;
        }    
        
        /**
         * Select the specified group and returns <code class="prettyprint">true</code> if the group exist.
         * @param id The key of the tab group of interactive objects.
         * @param defaultChild (optional) The default interactive object to select by default when the group is selected.
         * @return <code class="prettyprint">true</code> if the specified group of interactive objects is selected.
         * @throws ArgumentError the id argument not must be 'null' or 'undefined'.
         */
        public function select( id:* , defaultChild:InteractiveObject = null ):Boolean
        {
            if ( id == null )
            {
                throw new ArgumentError( this + " insert failed, the id argument not must be 'null' or 'undefined'.") ;
            }
            if ( contains( id ) )
            {
                unSelect() ;
                _current = id ;
                var it:Iterator = _set.iteratorByKey( _current ) ;
                var first:InteractiveObject ;
                var isFirst:Boolean = true ;
                while (it.hasNext()) 
                {
                    var next:InteractiveObject = it.next() ;
                    if ( isFirst )
                    {
                        first = next ;
                        isFirst = false ;    
                    }
                    next.tabEnabled = true ;    
                }
                first = (defaultChild != null && _set.containsValueByKey( id, defaultChild)) ? defaultChild : first ;
                if ( next.stage != null )
                {
                    next.stage.focus = first ;
                }
                return true ;
            }
            else
            {
                return false ;    
            }    
        }
    
        /**
         * Unselect the specified group and returns <code class="prettyprint">true</code> if the group exist.
         * @return <code class="prettyprint">true</code> if the unselected group exist and the process is success.
         */
        public function unSelect():Boolean
        {
            if ( _current != null )
            {
                var it:Iterator = _set.iteratorByKey( _current ) ;
                while (it.hasNext()) 
                {
                    it.next().tabEnabled = false ;    
                }
                _current = null ;                
                return true ;
            }
            else
            {
                return false ;    
            }
        }

        /**
          * The current group selected in the manager.
          */
        private var _current:* = null ;
        
        /**
          * @private
          */
        private static var _instance:TabManager ;

        /**
         * @private
         */
        private var _map:HashMap ;

        /**
         * @private
         */
        private var _set:MultiHashSet ;
    
        /**
         * Invoked when an interactive object in the manager is focus in.
         */
        private function _onFocusIn( e:FocusEvent ):void
        {
            if ( auto && (e.relatedObject != e.target) )
            {
                var child:InteractiveObject = e.target as InteractiveObject ;
                if ( _map.containsKey( child ) )
                {
                    var id:* = _map.get( child ) ;
                    if ( id != getCurrent() )
                    {
                        this.select( id , child ) ;
                    }
                }
            }
        }
            
    }
    
}
