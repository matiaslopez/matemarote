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
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.evaluators
    {
    import system.eden;
    
    /**
     * Evaluates eden expression.
     * <pre class="prettyprint">
     * import system.evaluators.* ;
     * var e:EdenEvaluator = new EdenEvaluator(false) ;
     * var result:* = e.eval("new Date(2007,5,12,22,10,5)") ;
     * trace("evaluate new Date(2007,5,12,22,10,5) : " + result ) ; // evaluate new Date(2007,5,12,22,10,5) : Tue Jun 12 22:10:05 GMT+0200 2007
     * </pre>
     */
    public class EdenEvaluator implements Evaluable
        {
        	
        /**
         * @private
         */
        private var _serialized:Boolean;
        
        /**
         * Creates a new EdenEvaluator instance.
         * @param serialized This Boolean flag indicates if the object must be evaluates with a final serialized or not value.
         */
        public function EdenEvaluator( serialized:Boolean = true )
            {
            _serialized = serialized;
            }
        
        /**
         * Evaluates the specified object.
         */        
        public function eval(o:*):*
            {
            var result:* = eden.deserialize( o );
            
            if( _serialized )
                {
                return eden.serialize( result );
                }
            else
                {
                return result;
                }
            }
        
        }
    }

