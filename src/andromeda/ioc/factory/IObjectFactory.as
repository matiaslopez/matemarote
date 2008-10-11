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
package andromeda.ioc.factory 
{

    /**
     * Describes all methods defines in a factory who implement the inversion of control design pattern.
     * @author eKameleon
     */
    public interface IObjectFactory 
    {
        
        /**
         * Determinates the configuration object of the object factory.
         */
        function get config():ObjectConfig ;
        
        /**
         * @private
         */
        function set config( o:ObjectConfig ):void ;
        
        /**
         * Returns <code class="prettyprint">true</code> if the referencial contains the specified object.
         * @param id The 'id' of the object to search.
         * @return <code class="prettyprint">true</code> if the referencial contains the specified object.
         */
        function containsObject(id:String):Boolean;
                
        /**
         * This method returns an object with the specified id in argument.
         * @param id The 'id' of the object to return.
         * @return the instance of the object with the id passed in argument.
         */
        function getObject( id:String ):* ;
    
        /**
         * This method indicates if the specified object definition is lazy init.
         * @param id The 'id' of the object definition to check..
         * @return <code class="prettyprint">true</code> if the specified object definition is lazy init.
         */
        function isLazyInit( id:String ):Boolean ;
        
        /**
         * This method defined if the scope of the specified object definition is "singleton".
         * @param The 'id' of the object.
         * @return <code class="prettyprint">true</code> if the object is a singleton. 
         */
        function isSingleton(id:String):Boolean ;
        
        /**
         * Removes and destroy a singleton in the container. 
         * Invoke the <b>'destroy'</b> method of this object is it's define in the <code class="prettyprint">IObjectDefinition</code> of this singleton.
         * @param id The id of the singleton to remove.
         */
        function removeSingleton( id:String ):void ;
        
    }
}
