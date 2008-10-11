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
    import andromeda.ioc.factory.ObjectConfig;
    
    import system.evaluators.PropertyEvaluator;                                

    /**
     * Evaluates a type string expression and return the value who corresponding in the locale reference in the configuration of the factory.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import andromeda.ioc.evaluators.LocaleEvaluator ;
     * import andromeda.ioc.factory.ObjectConfig ;
     * 
     * var locale:Object =
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
     * var configurator:ObjectConfig = new ObjectConfig() ;
     * configurator.locale           = locale ;
     * 
     * var evaluator:LocaleEvaluator = new LocaleEvaluator( configurator ) ;
     * 
     * trace( evaluator.eval( "test"       ) ) ; // null
     * trace( evaluator.eval( "message"    ) ) ; // hello world
     * trace( evaluator.eval( "title"      ) ) ; // my title
     * trace( evaluator.eval( "menu.title" ) ) ; // my menu title
     * trace( evaluator.eval( "menu.label" ) ) ; // my label
     * </pre>
     * @author eKameleon
     */
    public class LocaleEvaluator extends PropertyEvaluator
    {
        
        /**
         * Creates a new LocaleEvaluator instance.
         * @param config The optional ObjectConfig object to filter the type expression to evaluate.
         */
        public function LocaleEvaluator( config:ObjectConfig=null )
        {
            this.config = config ;
        }
        
        /**
         * The ObjectConfig reference of this evaluator.
         */
        public var config:ObjectConfig ;
		
        /**
         * The ObjectConfig reference of this evaluator.
         */
        public override function get target():*
        {
        	return config != null ? config.locale : null ;
        }                
                
        
    }
}
