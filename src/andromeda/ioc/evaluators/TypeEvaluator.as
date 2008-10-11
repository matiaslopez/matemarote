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
    import flash.utils.getDefinitionByName;
    
    import andromeda.ioc.core.TypeAliases;
    import andromeda.ioc.core.TypeExpression;
    import andromeda.ioc.core.TypePolicy;
    import andromeda.ioc.factory.ObjectConfig;
    
    import system.evaluators.Evaluable;
    
    import vegas.core.CoreObject;    

    /**
     * Evaluates a type string expression and return the type Class who corresponding in the application.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import andromeda.ioc.core.TypePolicy ;
     * import andromeda.ioc.evaluators.TypeEvaluator ;
     * import andromeda.ioc.factory.ObjectConfig ;
     * 
     * var conf:ObjectConfig = new ObjectConfig() ;
     * 
     * conf.typePolicy       = TypePolicy.ALL ; // TypePolicy.NONE, TypePolicy.ALIAS, TypePolicy.EXPRESSION
     * conf.typeAliases      =
     * [
     *     { alias:"CoreObject" , type:"vegas.core.CoreObject" }
     * ] ;
     * 
     * conf.typeExpression   =
     * [
     *     { name:"map"     , value:"vegas.data.map" } ,
     *     { name:"HashMap" , value:"{map}.HashMap"  }
     * ] ;
     * 
     * var evaluator:TypeEvaluator = new TypeEvaluator( conf ) ;
     * 
     * trace( evaluator.eval( "CoreObject"  ) ) ; // [class CoreObject]
     * trace( evaluator.eval( "{HashMap}"   ) ) ; // [class HashMap]
     * trace( evaluator.eval( "test"        ) ) ; // null
     * trace( evaluator.eval( "{map}.Test"  ) ) ; // null
     * </pre>
     * @author eKameleon
     */
    public class TypeEvaluator extends CoreObject implements Evaluable 
    {
        
        /**
         * Creates a new TypeEvaluator instance.
         * @param config The optional ObjectConfig object to filter the type expression to evaluate.
         */
        public function TypeEvaluator( config:ObjectConfig=null )
        {
            this.config = config ;
        }
        
        /**
         * The ObjectConfig reference of this evaluator.
         */
        public var config:ObjectConfig ;
        
        /**
         * Indicates if the eval() method throws errors or return null when an error is throwing.
         */
        public var throwError:Boolean ;        
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            if ( o is Class )
            {
                return o as Class ;
            }
            else if ( o is String )
            {
                
                var type:String = o as String ;
                
                if ( config != null )
                {
                    var policy:String = config.typePolicy ;
                    
                    if ( policy != TypePolicy.NONE )
                    {
                        if ( policy == TypePolicy.ALL || policy == TypePolicy.EXPRESSION )
                        {
                    	   var exp:TypeExpression = (config.typeExpression as TypeExpression) ;
                    	   if ( exp != null )
                    	   {
                        	   type = exp.format(type) ;
                       	   }
                        }
                    
                        if ( policy == TypePolicy.ALL || policy == TypePolicy.ALIAS )
                        {
                            var aliases:TypeAliases = (config.typeAliases as TypeAliases) ;
                            if ( aliases != null && aliases.containsAlias(type) )
                            {
                                type = aliases.getValue(type) ;
                            }
                        }
                    }
                }
                
                try
                {
                    return getDefinitionByName( type ) as Class ;
                }
                catch( e:Error )
                {
                	if ( throwError )
                	{
                        throw new EvalError(this + " eval failed : " + e.toString() ) ;
                	}
                }
            }

            return null ;

        }

    }
}
