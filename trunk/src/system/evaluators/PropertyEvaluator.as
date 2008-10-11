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
    import system.evaluators.Evaluable;        

    /**
     * Evaluates a type string expression and return the property value who corresponding in the target object specified in this evaluator.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.evaluators.PropertyEvaluator ;
     * 
     * var obj:Object =
     * {
     *     message : "hello world" ,
     *     title   : "my title"    ,
     *     menu    :
     *     {
     *         title : "my menu title" ,
     *         label : "my label"
     *     }
     * }
     * 
     * var evaluator:PropertyEvaluator = new PropertyEvaluator( obj ) ;
     * 
     * // valid expressions
     * 
     * trace( evaluator.eval( "message"    ) ) ; // hello world
     * trace( evaluator.eval( "title"      ) ) ; // my title
     * trace( evaluator.eval( "menu.title" ) ) ; // my menu title
     * trace( evaluator.eval( "menu.label" ) ) ; // my label
     * 
     * // invalid expressions
     * 
     * trace( evaluator.eval( ""            ) ) ; // null
     * trace( evaluator.eval( "unknow"      ) ) ; // null
     * trace( evaluator.eval( "menu.unknow" ) ) ; // null
     * 
     * // change the "undefineable" value returns in the eval() method when the evaluation failed.
     * 
     * evaluator.undefineable = "empty" ;
     * trace( evaluator.eval( "unknow" ) ) ; // empty ;
     * 
     * evaluator.undefineable = undefined ;
     * trace( evaluator.eval( "unknow" ) ) ; // undefined ;
     *     
     * // activate the throwError mode.
     *     
     * evaluator.throwError = true ;
     * 
     * try
     * {    
     *     evaluator.eval( "test" ) ;
     * }
     * catch( e:Error )
     * {
     *     trace( e ) ; // EvalError: [object PropertyEvaluator] eval failed with the expression : test
     * }
     * </pre>
     */
    public class PropertyEvaluator implements Evaluable 
    {
        
        /**
         * Creates a new PropertyEvaluator instance.
         * @param target the target object use in the evaluator.
         */
        public function PropertyEvaluator( target:* = null )
        {
            this.target = target ;
        }
        
        /**
         * The target reference use in the evaluator.
         */
        public function get target():*
        {
            return _target ;
        }
        
        /**
         * @private
         */
        public function set target( o:* ):void
        {
            _target = o ;
        }        
        
        /**
         * The separator of the expression evaluator.
         */
        public var separator:String = "." ;
        
        /**
         * This attributs defines the value returns from the eval() method if the expression can't be evaluate.
         */
        public var undefineable:* = null ;
        
        /**
         * Indicates if the eval() method throws errors or return null when an error is throwing.
         */
        public var throwError:Boolean ;
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            if ( o is String && target != null )
            {
                var exp:String = o as String ;
                if ( exp.length > 0 )
                {
                    var value:*       = target ;
                    var members:Array = exp.split( separator ) ;
                    var len:int       = members.length ;
                    for ( var i:int ; i<len ; i++ )
                    {
                        if ( members[i] in value )
                        {
                            value = value[ members[i] ] ;    
                        }
                        else
                        {
                        	if ( throwError )
                        	{
                                throw new EvalError( this + " eval failed with the expression : " + o ) ;
                        	}
                        	return undefineable ;
                        }
                    }
                    return value ;
                }
            }
            return undefineable ;
        }
        
        /**
         * @private
         */
        private var _target:* ;
        
    }
}
