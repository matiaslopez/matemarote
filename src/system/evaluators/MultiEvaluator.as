/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/
package system.evaluators 
    {
    
    /**
     * This <code class="prettyprint">IEvaluator</code> use a <code class="prettyprint">Array</code> collection of evaluators to evaluate the specified value.
     * <pre class="prettyprint">
     * import system.evaluators.* ;
     * 
     * var e1:EdenEvaluator = new EdenEvaluator(false) ;
     * var e2:DateEvaluator = new DateEvaluator() ;
     * 
     * var result:* ;
     * 
     * var me:MultiEvaluator = new MultiEvaluator( e1, e2 ) ;
     * 
     * result = me.eval( "new Date(2007,5,12,22,10,5)" ) ;
     * trace("evaluate new Date(2007,5,12,22,10,5) : " + result ) ; // evaluate new Date(2007,5,12,22,10,5) :  07.06.2008 09:10:53
     * 
     * me.clear() ;
     * 
     * me.add( e1 , e2 ) ;
     * 
     * result = me.eval("new Date(2007,5,12,22,10,5)") ;
     * 
     * trace("evaluate new Date(2007,5,12,22,10,5) : " + result ) ; // evaluate new Date(2007,5,12,22,10,5) : Tue Jun 12 22:10:05 GMT+0200 2007
     * 
     * me.remove( e2 ) ;
     * 
     * result = me.eval("new Date(2007,5,12,22,10,5)") ;
     * 
     * trace("evaluate new Date(2007,5,12,22,10,5) : " + result ) ; // evaluate new Date(2007,5,12,22,10,5) :  07.06.2008 09:10:53
     * </pre>
     */
    public class MultiEvaluator implements Evaluable
        {

        /**
         * @private
         */
        private var _evaluators:Array ; 
        
        /**
         * Indicates if the MultiEvaluator is cleared before insert new <code class="prettyprint">IEvaluator</code> objects (in the insert method).
         */
        public var autoClear:Boolean ;

        /**
         * Creates a new MultiEvaluator instance.
         * @param ...evaluators The enumeration list of <code class="prettyprint">IEvaluator</code> objets or Arrays of IEvaluator. Only Array and IEvaluator are compatible to fill the MultiEvaluator.
         */
        public function MultiEvaluator( ...evaluators:Array )
            {
            _evaluators = [] ;
            add.apply(this, evaluators) ;
            }

        /**
         * Inserts <code class="prettyprint">IEvaluator</code> objects in the MultiEvaluator.  
         * @param ...evaluators The enumeration list of IEvaluator objets or Arrays of IEvaluator. Only Array and IEvaluator are compatible to fill the MultiEvaluator.
         */
        public function add( ...evaluators:Array ):void
            {
            if ( autoClear )
                {
                clear() ;
                }
            var l:uint = evaluators.length ; 
            if ( l > 0 )
                {
                var c:uint, i:uint, j:uint ;
                var e:* ;
                for ( i = 0 ; i<l ; i++ )
                    {
                    e = evaluators[i] ;
                    if ( e is Evaluable )
                        {
                        _evaluators.push(e) ;        
                        }
                    else if ( e is Array )
                        {
                        c = (e as Array).length ;
                        for ( j=0 ; j<c ; j++ )
                            {
                            if ( e[j] is Evaluable )
                                {
                                _evaluators.push( e[j] ) ; 
                                }
                            }
                        }
                    else
                        {
                        // nothing    
                        }
                    }
                }
            }         
                
        /**
         * Clear all the <code class="prettyprint">IEvaluator</code> objects.
         */
        public function clear():void
            {
            _evaluators = [] ;
            }
                
        /**
         * Evaluates the specified object.
         */
        public function eval(o:*):*
            {
            var i:uint ;
            var len:uint = _evaluators.length ;
            if ( len > 0 )
                {
                for ( i = 0 ; i<len ; i++ )
                    {
                    o = _evaluators[i].eval( o ) ;
                    }
                }
            return o ;
            }
        
        /**
         * Removes an <code class="prettyprint">IEvaluator</code> objects in the MultiEvaluator if is register.
         * @param evaluator The <code class="prettyprint">IEvaluator</code> to find and remove.
         * @return <code class="prettyprint">true</code> if the IEvaluator is removed.
         */
        public function remove( evaluator:Evaluable ):Boolean
            {
            var index:int = _evaluators.indexOf(evaluator) ;
            if( index > -1 )
                {
                	_evaluators.splice(index, 1) ;
                	return true ;
                }
            else
                {
                	return false ;
                }
            }           
        
        }

    }
