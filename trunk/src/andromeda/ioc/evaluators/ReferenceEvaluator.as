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
package andromeda.ioc.evaluators 
{
    import flash.display.DisplayObjectContainer;
    
    import andromeda.ioc.factory.IObjectFactory;
    
    import system.evaluators.Evaluable;
    import system.evaluators.PropertyEvaluator;    

    /**
     * Evaluates a reference string expression and return the property value who corresponding in the target object specified in this evaluator.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
	 * import andromeda.ioc.evaluators.ReferenceEvaluator ;
	 * import andromeda.ioc.factory.ECMAObjectFactory ;
	 * 
	 * import andromeda.vo.FilterVO ;
	 * 
	 * var linkages:Array = [ FilterVO ] ;
	 * 
	 * var objects:Array =
	 * [
	 *     {
	 *         id         : "VIDEO" ,
	 *         type       : "andromeda.vo.FilterVO" ,
	 *         properties : [ { name:"filter" , value:1 } ]
	 *     }
	 *     ,
	 *     {
	 *          id         : "MP3" ,
	 *          type       : "andromeda.vo.FilterVO" ,
	 *          properties : [ { name:"filter" , value:2 } ]
	 *     }
	 *     ,
	 *     {
	 *          id         : "my_filter" ,
	 *          type       : "andromeda.vo.FilterVO" ,
	 *          methods    :
	 *          [
	 *               { name:"toggleFilter" , arguments:[ { ref : "VIDEO.filter" } , { value : true } ] } ,
	 *               { name:"toggleFilter" , arguments:[ { ref : "MP3.filter"   } , { value : true } ] }
	 *          ]
	 *     }
	 * ];
	 * 
	 * var factory:ECMAObjectFactory = ECMAObjectFactory.getInstance() ;
	 * 
	 * factory.create( objects ) ;
	 * 
	 * var evaluator:ReferenceEvaluator = new ReferenceEvaluator( factory ) ;
	 * 
	 * // test evaluator
	 * 
	 * trace( evaluator.eval( "DISK" ) ) ; // null
	 * trace( evaluator.eval( "VIDEO" ) ) ; // [FilterVO:1]
	 * trace( evaluator.eval( "VIDEO.filter" ) ) ; // 1
	 * 
	 * // test in the factory
	 * 
	 * trace( factory.getObject( "my_filter" ) ) ; // [FilterVO:3]
     * </pre>
     * @author eKameleon
     */
    public class ReferenceEvaluator implements Evaluable 
    {
        
        /**
         * Creates a new ReferenceEvaluator instance.
         * @param factory The IObjectFactory use in the evaluator.
         */
        public function ReferenceEvaluator( factory:IObjectFactory = null  )
        {
            this.factory = factory ;
        }
        
        /**
         * The IObjectFactory use in the evaluator.
         */
        public function get factory():IObjectFactory
        {
        	return _factory ;
        }
        
        /**
         * @private
         */
        public function set factory( factory:IObjectFactory ):void
        {
        	_factory = factory ;
        }        
        
        /**
         * The reference pattern who represents the current root reference of the application defines in the config object in the factory.
         */
        public var rootPattern:String = "#root" ;
        
        /**
         * The separator of the expression evaluator.
         */
        public var separator:String = "." ;
        
        /**
         * The reference pattern who represents the current stage reference of the application defines in the config object in the factory.
         */
        public var stagePattern:String = "#stage" ;        
        
        /**
         * The reference pattern who represents the current factory.
         */
        public var thisPattern:String = "#this" ;
        
        /**
         * Indicates if the class throws errors or return null when an error is throwing.
         */        
        public function get throwError():Boolean
        {
            return _propEvaluator.throwError ;  
        }
        
        /**
         * @private
         */        
        public function set throwError( b:Boolean ):void
        {
            _propEvaluator.throwError = b ;  
        }        
        
        /**
         * The undefineable value returns in the eval method if the expression can't be evaluate.
         */
        public var undefineable:* = null ;
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            if ( o is String && factory != null )
            {
            	var exp:String = o as String ;
            	
            	if ( exp.length > 0 )
            	{
            		switch( exp )
            		{
            			case thisPattern :
                        {
                            return factory ;
                        }
                        case rootPattern  :
                        case stagePattern :
            		    {
                            var root:DisplayObjectContainer = factory.config.root as DisplayObjectContainer ;
                            if ( root == null )
                            {
                            	return null ;
                            }
            			    if ( exp == rootPattern )
            			    {
                			     return root ;
                            }
            			    else
            			    { 
                                return root.stage ;
            			    }
            		    }
                        default :
                        {
                            var members:Array = exp.split( separator ) ;
                            if ( members.length > 0 )
                            {
                                var ref:String = members.shift() ;
                                var value:*    = factory.getObject( ref ) ;
                                if ( value != null && members.length > 0 )
                                {
                				    _propEvaluator.target = value ;
                                    value = _propEvaluator.eval( members.join(".") ) ;
                                    _propEvaluator.target = null ;
                                }
                                return value ;
                            }
                        }
                    }
            	}
            }        	
            return undefineable ;
        }
        
        /**
         * @private
         */
        private var _factory:IObjectFactory ;
        
        /**
         * @private
         */
        private var _propEvaluator:PropertyEvaluator = new PropertyEvaluator() ;
    }
}