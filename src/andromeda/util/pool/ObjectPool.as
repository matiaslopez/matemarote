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
package andromeda.util.pool 
{
    import vegas.core.CoreObject;                                                                                

    /**
     * This class implements the object pool design pattern implementation.
     * <pre class="prettyprint">
     * import andromeda.util.pool.* ;
     * 
     * import test.pool.* ;
     * 
     * var i:int;
     * 
     * var pool:ObjectPool = new ObjectPool() ;
     * 
     * pool.allocate( 10 , MyClass , ["hello label"] ) ;
     * 
     * pool.initialize("init", ["arg1", "arg2"]) ;
     * 
     * var activeObjects:Array = [] ;
     * 
     * //read the first object
     * 
     * activeObjects[0] = pool.object;
     * 
     * var k:int = pool.wasteCount ;
     * 
     * trace("pool.wasteCount : " + pool.wasteCount) ; // 9
     * 
     * for ( i = 0 ; i < k ; i++ )
     * {
     *     activeObjects.push( pool.object ) ; // read the remaining 9 objects
     * }
     * 
     * // wasteCount is now zero, but usageCount reports 10.
     * 
     * trace("pool.usageCount : " + pool.usageCount) ;
     * 
     * try
     * {
     *     //this will fail because the pool is now empty
     *     activeObjects.push( pool.object );
     * }
     * catch (e:Error)
     * {
     *     trace(e);
     * }
     * 
     * k = pool.size ;
     * 
     * // give all objects back to the pool
     * 
     * for (i = 0; i < k; i++)
     * {
     *     pool.object = activeObjects.shift();
     * }
     * 
     * // usage count is zero
     * 
     * trace( pool.usageCount ) ;
     * 
     * trace( "======= use grow property" ) ;
     * 
     * pool.grow = true ;
     * 
     * pool.object ; // create a new object and the pool is growing witn 10 new objects inside the buffer.
     * 
     * trace("pool.usageCount : " + pool.usageCount) ; // 1
     * 
     * trace("pool.wasteCount : " + pool.wasteCount) ; // 9
     * 
     * trace( "======= use destroy method" ) ;
     * 
     * pool.destroy() ;
     * 
     * trace("pool.usageCount : " + pool.usageCount) ; // 0
     * trace("pool.wasteCount : " + pool.wasteCount) ; // 0
     * 
     * trace( "======= Assign a custom object factory, see the test.pool.MyBuilder class") ;
     * 
     * pool.builder = new MyBuilder();
     * 
     * pool.allocate( 20 ) ;
     * 
     * trace( pool.object ) ;
     * 
     * trace("pool.usageCount : " + pool.usageCount) ; // 1
     * trace("pool.wasteCount : " + pool.wasteCount) ; // 19   
     * </pre>
     */
    public class ObjectPool extends CoreObject 
    {

        /**
         * Creates a new ObjectPool instance.
         * @param grow Indicates if the pool of objects is auto growing when a new user is called with the "object" property.
         */
        public function ObjectPool( grow:Boolean = false )
        {
            this.grow = grow ;
        }
        
        /**
         * Defines the builder responsible for creating all pool objects. 
         * If you don't want to use a factory, you must provide a class to the allocate method instead.
         * @see #allocate
         */
        public var builder:ObjectPoolBuilder ;
                
        /**
         * Indicates if the pool of objects is auto growing when a new user is called with the "object" property.
         */
        public var grow:Boolean ;
 
        /**
         * Get the next available object from the pool or put it back for the
         * next use. If the pool is empty and resizable, an error is thrown.
         */
        public function get object():*
        {
            if ( _usageCount == _currSize )
            {
                if ( grow )
                {
                    _currSize += _initSize;
                    
                    var n:Node = _tail;
                    var t:Node = _tail;
                    
                    var node:Node;
                    for (var i:int = 0; i < _initSize; i++)
                    {
                        node      = new Node() ;
                        node.data = builder.build() ;
                        t.next    = node ;
                        t         = node ; 
                    }
                    
                    _tail = t ;
                    _tail.next = _empty = _head ;
                    _allocate = n.next ;
                    return object;
                }
                else
                {
                    throw new Error(this + " object property failed, object pool exhausted.");
                }
            }
            else
            {
                var o:*        = _allocate.data ;
                _allocate.data = null ;
                _allocate      = _allocate.next ;
                _usageCount++;
                return o ;
            }
        }
        
        /**
         * @private
         */
        public function set object(o:*):void
        {
            if (_usageCount > 0)
            {
                _usageCount-- ;
                _empty.data = o ;
                _empty      = _empty.next;
            }
        }
        
        /**
         * The optional Array representation of parameters to send in the ObjectPoolBuilder.build() method use in the pool to create all objects. 
         */
        public var parameters:Array ;
        
        /**
         * Indicates the pool size.
         */
        public function get size():int
        {
            return _currSize;
        }
        
        /**
         * Indicates the total number of 'checked out' objects currently in use.
         */
        public function get usageCount():int
        {
            return _usageCount;
        }
        
        /**
         * The total number of unused thus wasted objects. Use the purge() method to compact the pool.
         * @see #purge
         */
        public function get wasteCount():int
        {
            return _currSize - _usageCount; 
        }
        
        /**
         * Allocates the pool by creating all objects from the builder. 
         * @param clazz The class to create for each object node in the pool.
         * @param size The number of objects to create.
         * @param parameters The optional Array representation of parameters to send in the ObjectPoolBuilder.build() method use in this method to create all pooling objects. 
         * This overwrites the current factory.
         */
        public function allocate( size:uint = 1 , clazz:Class = null, parameters:Array=null ):void
        {
            
            destroy();
            
            if ( parameters != null )
            {
                this.parameters = parameters ;	
            }
            
            if ( clazz )
            {
                builder = new InstanceBuilder( clazz );
            }
            else
            {
                if ( !builder )
                {
                    throw new Error( this + " allocate failed, nothing to instantiate.");
                }
            } 
            
            _initSize = _currSize = size;
            
            _head      = _tail = new Node();
            _head.data = builder.build.apply(builder, this.parameters) ;
            
            var n:Node;
            
            for (var i:int = 1; i < _initSize; i++)
            {
                n      = new Node() ;
                n.data = builder.build.apply(builder, this.parameters) ;
                n.next = _head ;
                _head  = n ;
            }
            
            _empty     = _allocate = _head ;
            _tail.next = _head;
        }        
        
        /**
         * Destroy and unlock all ressources for the garbage collector.
         */
        public function destroy():void
        {
            var tmp:Node ;
            var cur:Node = _head ;
            while (cur)
            {
                tmp      = cur.next ;
                cur.next = null ;
                cur.data = null ;
                cur      = tmp ;
            }
            _head      = _tail     = _empty      = _allocate = null ;
            _initSize  = _currSize = _usageCount = 0 ;
            parameters = null ;
        }

        /**
         * Removes all unused objects from the pool. 
         * If the number of remaining used objects is smaller than the initial capacity defined by the 
         * allocate() method, new objects are created to refill the pool. 
         */
        public function flush():void
        {
            
            var i:int ;
            
            var node:Node ;
            
            if (_usageCount == 0)
            {
                if ( _currSize == _initSize )
                {
                    return;
                }   
                
                if (_currSize > _initSize)
                {
                    i = 0; 
                    node = _head;
                    while (++i < _initSize)
                    {
                        node = node.next;   
                    }
                    _tail     = node ;
                    _allocate = _empty = _head ;
                    _currSize = _initSize;
                    return; 
                }
            }
            else
            {
                var a:Array = [];
                node =_head;
                while (node)
                {
                    
                    if (!node.data) 
                    {
                    	a[int(i++)] = node;
                    }
                    
                    if (node == _tail) 
                    {
                    	break;
                    }
                    
                    node = node.next;   
                
                }
                
                _currSize = a.length;
                _usageCount = _currSize;
                
                _head = _tail = a[0];
                
                for (i = 1; i < _currSize; i++)
                {
                    node = a[i];
                    node.next = _head;
                    _head = node;
                }
                
                _empty     = _allocate = _head ;
                _tail.next = _head;
                
                if (_usageCount < _initSize)
                {
                    _currSize = _initSize;
                    
                    var n:Node = _tail ;
                    var t:Node = _tail ;
                    var k:int = _initSize - _usageCount ;
                    
                    for ( i = 0 ; i < k ; i++ )
                    {
                        node      = new Node();
                        node.data = builder.build.apply(builder, parameters) ;
                        t.next    = node ;
                        t         = node ; 
                    }
                    
                    _tail      = t ;
                    _tail.next = _empty = _head ;
                    _allocate  = n.next ;
                    
                }
            }
        }

        /**
         * Helper method for applying a function to all objects in the pool.
         * @param name The name of the method invoked to initialize all objects in the pool.
         * @param args The Array representation of all arguments of the init method.
         */
        public function initialize( name:String , args:Array):void
        {
            var n:Node = _head ;
            while (n)
            {
            	if ( name in n.data && n.data[ name ] is Function )
            	{
                    n.data[ name ].apply( n.data, args ) ;
            	}
                if (n == _tail) 
                {
                	break ;
                }
                n = n.next ; 
            }
        }

        /**
         * @private
         */
        private var _allocate:Node;
        
        /**
         * @private
         */
        private var _currSize:int;
        
        /**
         * @private
         */
        private var _empty:Node;
                
        /**
         * @private
         */
        private var _head:Node;
        
        /**
         * @private
         */
        private var _initSize:int;

        /**
         * @private
         */
        private var _tail:Node;
        
        /**
         * @private
         */
        private var _usageCount:int;               
        
    }
}
