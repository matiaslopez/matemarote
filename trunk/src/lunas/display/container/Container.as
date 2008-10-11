/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package lunas.display.container 
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;
    
    import lunas.core.AbstractComponent;
    import lunas.core.IContainer;
    import lunas.events.ComponentEvent;    

    /**
     * The Container class is the base components for all objects that can serve as display object containers on the display list.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.display.StageScaleMode ;
     * import flash.events.KeyboardEvent ;
     * import flash.text.TextFieldAutoSize ;
     * import flash.text.TextFormat ;
     * 
     * import lunas.display.container.Container ;
     * 
     * stage.scaleMode = StageScaleMode.NO_SCALE ;
     * 
     * var container:Container = new Container() ;
     * container.x = 25 ;
     * container.y = 25 ;
     * 
     * addChild(container) ;
     * 
     * for (var i:uint = 0 ; i<10 ; i++ )
     * {
     * 
     *     var field:TextField = new TextField() ;
     *     field.x = 10 ;
     *     field.y = 10 ;
     *     field.autoSize = TextFieldAutoSize.LEFT ;
     *     field.defaultTextFormat = new TextFormat("verdana", 10) ;
     *     field.text = "#" + i ;
     *     
     *     var display:Square = new Square() ; // linked Sprite in the library of the swf.
     *     container.addChild( display ) ;
     *     
     *     display.x = i * ( display.width + 10 ) ;
     *     display.addChild( field ) ;
     * }
     * 
     * var keyDown:Function = function( e:KeyboardEvent ):void
     * {
     *     // trace( "removeChildsAt(2,3) : " + container.removeChildsAt(2,3) ) ;
     *     trace( "removeRange(2,3) : " + container.removeRange(2,5) ) ;
     * }
     * 
     * stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     * </pre>
     * @author eKameleon
     */
    public class Container extends AbstractComponent implements IContainer
    {

        /**
         * Creates a new Container instance.
         * @param id Indicates the id of the object.
         * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
         * @param name Indicates the instance name of the object.
         */
        public function Container(id:* = null, isConfigurable:Boolean = false, name:String = null)
        {
            super( id, isConfigurable, name ) ;
            registerView() ;
        }
        
        /**
         * Adds a child DisplayObject instance to this DisplayObjectContainer instance. 
         * The child is added to the front (top) of all other children in this DisplayObjectContainer instance. 
         * (To add a child to a specific index position, use the addChildAt() method.)
         * If you add a child object that already has a different display object container as a parent, 
         * the object is removed from the child list of the other display object container.
         * @param child The DisplayObject instance to add as a child of this DisplayObjectContainer instance.
         * @throws ArgumentError Throws if the child is the same as the parent. Also throws if the caller is a child (or grandchild etc.) of the child being added.
         * @return The DisplayObject instance that you pass in the child parameter.  
         */
        public override function addChild( child:DisplayObject ):DisplayObject
        {
            var d:DisplayObject = (_scope == this) ? super.addChild(child) : _scope.addChild( child ) ;
            update() ;
            return d ;
        }

        /**
         * Adds a child DisplayObject instance to this DisplayObjectContainer instance. The child is added at the index position specified. 
         * An index of 0 represents the back (bottom) of the display list for this DisplayObjectContainer object. 
         * @param child The DisplayObject instance to add as a child of this DisplayObjectContainer instance. 
         * @param index The index position to which the child is added. If you specify a currently occupied index position, the child object that exists at that position and all higher positions are moved up one position in the child list. 
         * @throws RangeError Throws if the index position does not exist in the child list.
         * @throws ArgumentError Throws if the child is the same as the parent. Also throws if the caller is a child (or grandchild etc.) of the child being added.
         * @return The DisplayObject instance that you pass in the child parameter. 
         */
        public override function addChildAt( child:DisplayObject , index:int ):DisplayObject
        {
            var d:DisplayObject = _scope.addChildAt(child, index) ;
            update() ;
            return d ;
        }

        /**
         * (read-only) Returns the number of children of this object.
         */
        public override function get numChildren() : int
        {
            return (_scope == this) ? super.numChildren : _scope.numChildren ;
        }

        /**
         * Indicates whether the security restrictions would cause any display objects to be omitted from the list returned by calling the DisplayObjectContainer.getObjectsUnderPoint() method with the specified point point. By default, content from one domain cannot access objects from another domain unless they are permitted to do so with a call to the Security.allowDomain() method.
         * @param point The point under which to look.
         * @return true if the point contains child display objects with security restrictions. 
         */
        public override function areInaccessibleObjectsUnderPoint( point:Point ):Boolean
        {
            return (_scope == this) ? super.areInaccessibleObjectsUnderPoint(point) : _scope.areInaccessibleObjectsUnderPoint(point) ;
        }
        
        /**
         * Removes all childs in the container.
         */
        public function clear():void
        {
            var size:uint = numChildren ;
            while(--size > -1)
            {
                removeChildAt( size ) ; 
            }
            update() ;
            fireComponentEvent( ComponentEvent.CLEAR ) ;
        }

        /**
         * Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself. 
         * The search includes the entire display list including this DisplayObjectContainer instance. 
         * Grandchildren, great-grandchildren, and so on each return true.
         * @param child The child object to test.
         * @return true if the child object is a child of the DisplayObjectContainer or the container itself; otherwise false. 
         */
        public override function contains( child:DisplayObject ):Boolean
        {
            return (_scope == this) ? super.contains(child) : _scope.contains(child) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if a child exist in the display list at the specified index value.
         * @return <code class="prettyprint">true</code> if a child exist in the display list at the specified index value.
         */
        public function containsAt( index:int ):Boolean 
        {
            return getChildAt(index) != null ;
        }
        
        /**
         * Returns the child display object instance that exists at the specified index.
         * @param index The index position of the child object.  
         * @return The child display object at the specified index position.
         * @throws RangeError Throws if the index does not exist in the child list.
         * @throws SecurityError This child display object belongs to a sandbox to which you do not have access. You can avoid this situation by having the child movie call Security.allowDomain().
         * @see getChildByName() 
         */
        public override function getChildAt(index : int) : DisplayObject
        {
            return (_scope == this) ? super.getChildAt( index ) : _scope.getChildAt( index ) ;    
        }

        /**
         * Returns the child display object that exists with the specified name. 
         * If more that one child display object has the specified name, the method returns the first object in the child list.
         * @param name The name of the child to return. 
         * @throws SecurityError This child display object belongs to a sandbox to which you do not have access. You can avoid this situation by having the child movie call the Security.allowDomain() method. 
         * @return The child display object with the specified name. 
         */
        public override function getChildByName(name : String) : DisplayObject
        {
            return (_scope == this) ? super.getChildByName( name ) : _scope.getChildByName( name ) ;
        }

        /**
         * Returns the index position of a child DisplayObject instance.
         * @param child The DisplayObject instance to identify.
         * @return The index position of the child display object to identify.
         */
        public override function getChildIndex( child:DisplayObject ):int
        {
            return (_scope == this) ? super.getChildIndex(child) : _scope.getChildIndex(child) ;
        }
        
        /**
         * Returns an array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance. 
         * Any child objects that are inaccessible for security reasons are omitted from the returned array. 
         * To determine whether this security restriction affects the returned array, call the areInaccessibleObjectsUnderPoint() method.
         * @param The point under which to look.
         * @return An array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance. 
         */
        public override function getObjectsUnderPoint( point:Point ):Array
        {
            return (_scope == this) ? super.getObjectsUnderPoint(point) : _scope.getObjectsUnderPoint(point) ;
        }

        /**
         * Returns the index number value of the specified child reference in argument.
         * @return the index number value of the specified child reference in argument.
         */
        public function indexOf( child:DisplayObject ):int 
        {
            return (_scope == this) ? super.getChildIndex( child ) : _scope.getChildIndex( child ) ;
        }

        /**
         * Registers the view of this component. The scope view can be the current DisplayObjectContainer or a child inside it.
         */
        public function registerView( scope:DisplayObjectContainer = null ):void
        {
            unregisterView() ;
            _scope = ( scope == null || scope == this ) ? this : scope ;
        }

        /**
         * Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance. 
         * The parent property of the removed child is set to null , and the object is garbage collected if no other references to the child exist. 
         * The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
         * @param child The DisplayObject instance to remove.
         * @throws ArgumentError Throws if the child parameter is not a child of this object.
         * @return The DisplayObject instance that you pass in the child parameter.
         */
        public override function removeChild( child:DisplayObject ):DisplayObject
        {
            var d:DisplayObject = (_scope == this) ? super.removeChild(child) : _scope.removeChild(child) ;
            update() ;
            return d ;
        }
        
        /**
         * Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer. 
         * The parent property of the removed child is set to null, and the object is garbage collected if no other references to the child exist. 
         * The index positions of any display objects above the child in the DisplayObjectContainer are decreased by 1.
         * @param index The child index of the DisplayObject to remove.
         * @throws RangeError Throws if the index does not exist in the child list.
         * @throws SecurityError This child display object belongs to a sandbox to which the calling object does not have access. 
         * You can avoid this situation by having the child movie call the Security.allowDomain() method.          
         * @return The DisplayObject instance that was removed.
         */
        public override function removeChildAt( index:int):DisplayObject
        {
            var d:DisplayObject = (_scope == this) ? super.removeChildAt(index) : _scope.removeChildAt( index ) ;
            update() ;
            return d ;
        }
        
        /**
         * Removes all childs in the model defined for the first item by the specified index value, 
         * this method remove the first and the <code class="prettyprint">size - 1</code> items.
         * @throws RangeError if the index value is out of the bounds of the container elements.
         */
        public function removeChildsAt( index:int, size:Number ):Array 
        {
            var removes:Array = [] ;
            var l:int = index + size ;
            while( --l >= index )
            {
                var child:DisplayObject = removeChildAt(l) ;
                if ( child != null )
                {
                    removes.push( child ) ;    
                }
            }
            update() ;
            return ( removes.length > 0 ) ? removes.reverse() : null ;
        }
        
        /**
         * Removes a range of childs in the container.
         * @return the array representation of all removed items.
         * @throws RangeError if the index value is out of the bounds of the container elements.
         */
        public function removeRange( from:int , to:int ):Array 
        {
            var removes:Array = [] ;
            if ( to <= from )
            {
                if ( containsAt( from ) )
                {
                    removes.push( removeChildAt( from ) ) ;
                }
                else
                {
                    return null ;
                } 
                update() ; 
            }
            else
            {
                removes = removeChildsAt( from , to - from ) ;
            }
            return removes ;
        }
                
        /**
         * Changes the position of an existing child in the display object container. 
         * This affects the layering of child objects.
         * @param child The child DisplayObject instance for which you want to change the index number. 
         * @param index The resulting index number for the child display object. 
         * @throws RangeError Throws if the index does not exist in the child list. 
         * @throws ArgumentError Throws if the child parameter is not a child of this object.  
         */
        public override function setChildIndex( child:DisplayObject , index:int ) : void
        {
            if ( _scope == this )
            {
                super.setChildIndex( child, index ) ;
            }
            else
            {
                _scope.setChildIndex(child, index) ;
            }    
        }        
        
        /**
         * Returns the number of children of this object.
         * @return the number of children of this object.
         */
        public function size():uint
        {
            return _scope == this ? super.numChildren : _scope.numChildren ;    
        }
        
        /**
         * Swaps the z-order (front-to-back order) of the two specified child objects. 
         * All other child objects in the display object container remain in the same index positions.
         * @param child1 The first child object. 
         * @param child2 The second child object. 
         * @throws ArgumentError Throws if either child parameter is not a child of this object.  
         */
        public override function swapChildren( child1:DisplayObject, child2:DisplayObject):void
        {
            if ( _scope == this )
            {
                super.swapChildren( child1, child2 ) ;
            }
            else
            {
                _scope.swapChildren( child1 , child2 ) ;
            }    
        }
        
        /**
         * Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list. 
         * All other child objects in the display object container remain in the same index positions.
         * @param index1 The index position of the first child object.
         * @param index2 The index position of the second child object.
         * @throws RangeError — If either index does not exist in the child list.  
           */
        public override function swapChildrenAt( index1:int , index2:int ):void
        {
            if ( _scope == this )
            {
                super.swapChildrenAt(index1, index2) ;
            }
            else
            {
                _scope.swapChildrenAt(index1, index2) ;
            }
        }
        
        
        /**
         * Returns the Array representation of all childs in this container.
         * @return the Array representation of all childs in this container.
         */
        public function toArray():Array
        {
            var ar:Array    = [] ;
            var size:uint   = numChildren ;
            for( var i:uint = 0 ; i<size ; i++ )
            {
                ar[i] = getChildAt(i) ; 
            }
            return ar ;
        }
        
        /**
         * Unregisters the view of this component.
         */
        public function unregisterView():void
        {
            _scope = this ;
        }
        
        /**
         * The scope of the active display of this container component.
         */
        protected var _scope:DisplayObjectContainer ;    
        
    }
}
