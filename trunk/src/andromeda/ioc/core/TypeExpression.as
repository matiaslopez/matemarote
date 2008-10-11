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
package andromeda.ioc.core 
{
    import vegas.string.Expression;    

    /**
     * This object is an helper who contains type expressions and can format a type with all expression registered in the dictionnary.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint>
     * import andromeda.ioc.core.TypeExpression ;
     * 
     * var exp:TypeExpression = new TypeExpression() ;
     * 
     * exp.put( "package"            , "vegas.test.myPackage" ) ;
     * exp.put( "package.controller" , "{package}.controller" ) ;
     * 
     * var type:String = "{package.controller}.InitApplication" ;
     * 
     * var result:String = exp.format(type) ;
     * 
     * trace( "type:'" + type + "' --> result:'" + result + "'" ) ;
     * </pre>
     * @author eKameleon
     */
    public dynamic class TypeExpression extends Expression 
    {
        
        /**
         * Creates a new TypeExpression instance.
         */
        public function TypeExpression( weakKeys:Boolean = false )
        {
            super( weakKeys );
        }
        
        /**
         * Inserts an alias in the collector. If the alias already exist the value in the collector is replaced.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * import andromeda.ioc.core.TypeExpression ;
         * 
         * var exp:TypeExpression = new TypeExpression() ;
         * 
         * exp.put( "vegas"             , "vegas" ) ;
         * exp.put( "data.map"          , "{vegas}.map" ) ;
         * exp.put( "data.map.HashMap"  , "{data.map}.HashMap" ) ;
         * </pre>
         * @param alias The alias name, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @param value The value of the alias type, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @return <code class="prettyprint">true</core> if the alias can be registered.
         */
        public function put( key:String, value:String ):Boolean
        {
            if ( key == null || value == null || key.length == 0  || value.length == 0 )
            {
                return false ;
            }
            this[key] = value ;
            return true ;
        }        
        
    }
}
