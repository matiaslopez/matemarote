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
     * This interface creates the dependencies with the definitions.
     * @author eKameleon
     */
    public interface IObjectDefinitionContainer 
    {
        
        /**
         * Registers a new object definition in the container.
         * @param definition The Identifiable ObjectDefinition reference to register in the container.
         */
        function addObjectDefinition( definition:IObjectDefinition ):void ;
        
        /**
         * Removes all the object definitions register in the container.
         */
        function clearObjectDefinition():void ;
        
        /**
         * Returns <code class="prettyprint">true</code> if the object defines with the specified id is register in the container.
         * @param id The id of the ObjectDefinition to search. 
         * @return <code class="prettyprint">true</code> if the object defines with the specified id is register in the container.
         */
        function containsObjectDefinition( id:String ):Boolean ;
        
        /**
         * Returns the IObjectDefinition object register in the container with the specified id.
         * @param id The id of the ObjectDefinition to return. 
         * @return the IObjectDefinition object register in the container with the specified id.
         */
        function getObjectDefinition( id:String ):IObjectDefinition ;
        
        /**
         * Unregisters an object definition in the container.
         * @param id The id of the object definition to remove.
         */
        function removeObjectDefinition( name:String ):void 
        
        /**
         * Returns the numbers of object definitions registered in the container.
         * @return the numbers of object definitions registered in the container.
         */
        function sizeObjectDefinition():uint ;
        
    }
}
