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

    /**
     * The static enumeration list of all object attributes.
     * @author eKameleon
     */
    public class ObjectAttribute 
    {
        
        /**
         * Defines the label of the arguments in a method or a constructor object.
         */
        public static const ARGUMENTS:String = "arguments" ;  
        
        /**
         * Defines the attribute name of the "config" object in the configuration of the ioc factory.
         */
        public static const CONFIG:String = "config" ;  

        /**
         * Defines the label of the 'configuration' top-level attribute.
         */
        public static const CONFIGURATION:String = "configuration" ;  
        
        /**
         * Defines the label of the 'evaluators' attribure.
         */
        public static const EVALUATORS:String = "evaluators" ;  

        /**
         * Defines the label of the 'factory' attribure.
         */
        public static const FACTORY:String = "factory" ;  

        /**
         * Defines the label of the 'identify' property of the object.
         */
        public static const IDENTIFY:String = "identify" ;
        
        /**
         * Defines the label of the 'i18n' top-level attribute.
         */
        public static const I18N:String = "i18n" ;           
        
        /**
         * Defines the label of the 'imports' top-level attribute.
         */
        public static const IMPORTS:String = "imports" ;        
        
        /**
         * Defines the label of the lazyInit name property of the object.
         */        
        public static const LAZY_INIT:String = "lazyInit" ;
              
        /**
         * Defines the attribute name of the "locale" object in the configuration of the ioc factory and the object definition "arguments" and "properties".
         */
        public static const LOCALE:String = "locale" ;         
        
        /**
         * Defines the label of the 'lock' property of the object.
         */
        public static const LOCK:String = "lock" ;        
        
        /**
         * Defines the label of the name in a property object.
         */
        public static const NAME:String = "name" ;  
        
        /**
         * The name of the external object property to register the destroy method name.
         */
        public static const OBJECT_DESTROY_METHOD_NAME:String = "destroy" ;  
        
        /**
         * The name of the "factoryMethod" object definition attribute.
         */
        public static const OBJECT_FACTORY_METHOD:String = "factoryMethod" ;  
        
        /**
         * The name of the "factoryProperty" object definition attribute.
         */
        public static const OBJECT_FACTORY_PROPERTY:String = "factoryProperty" ;          

        /**
         * The name of the "factoryReference" object definition attribute.
         */
        public static const OBJECT_FACTORY_REFERENCE:String = "factoryReference" ;   
        
        /**
         * The name of the "factoryValue" object definition attribute.
         */
        public static const OBJECT_FACTORY_VALUE:String = "factoryValue" ;          
        
        /**
         * The name of the external object property to define the id of the object.
         */
        public static const OBJECT_ID:String = "id" ;  
        
        /**
         * The name of the external object property to register the init method name.
         */
        public static const OBJECT_INIT_METHOD_NAME:String = "init" ;  

        /**
         * Defines the label of the "listeners" name property of the object.
         */        
        public static const OBJECT_LISTENERS:String = "listeners" ;
        
        /**
         * The name of the external object property to register the properties.
         */
        public static const OBJECT_PROPERTIES:String = "properties" ;  

        /**
         * The name of the external object property to define the scope flag of the object.
         */
        public static const OBJECT_SCOPE:String = "scope" ;  
    
        /**
         * The name of the external object property to define the singleton flag of the object.
         */
        public static const OBJECT_SINGLETON:String = "singleton" ;  
        
        /**
         * The name of the external object property to define the static factory flag of the object.
         */
        public static const OBJECT_STATIC_FACTORY_METHOD:String = "staticFactoryMethod" ;  
        
        /**
         * The name of the external object property to define the static property flag of the object.
         */
        public static const OBJECT_STATIC_FACTORY_PROPERTY:String = "staticFactoryProperty" ;          
        
        /**
         * Defines the label of the 'objects' top-level attribute.
         */
        public static const OBJECTS:String = "objects" ;  
                
        /**
         * Defines the label of the 'resource' attribute in the imports objects.
         */
        public static const RESOURCE:String = "resource" ;

        /**
         * Defines the label of the type of the object.
         */
        public static const TYPE:String = "type" ;  
        
        /**
         * Defines the attribute name of the alias expression in a typeAlias object in the configuration of the ioc factory.
         */
        public static const TYPE_ALIAS:String = "alias" ;   
        
        /**
         * Defines the attribute name of the 'typeAliases' Array in the configuration of the ioc factory.
         */
        public static const TYPE_ALIASES:String = "typeAliases" ;           
        
        /**
         * Defines the attribute name of the 'typeExpression' Array in the configuration of the ioc factory.
         */
        public static const TYPE_EXPRESSION:String = "typeExpression" ;           
        
        /**
         * Defines the label of the reference in a property object.
         */
        public static const REFERENCE:String = "ref" ;  
        
        /**
         * Defines the label of the value in a property object.
         */
        public static const VALUE:String = "value" ;  
        
    }
    
}
