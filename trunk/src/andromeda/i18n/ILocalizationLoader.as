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
package andromeda.i18n
{

	/**
     * This interface provides a config loader object.
     */ 
    public interface ILocalizationLoader
    {
    
        /**
         * (Read-write) Indicates the Localization object.
         */
        function get localization():Localization ;
    	function set localization( localization:Localization ):void ;
    	
        /**
         * (Read-write) The path of the localization file.
         */
        function get path():String ;
        function set path( value:String ):void ;

        /**
          * Determinates the prefix value of the localization files.
          */
        function get prefix():String ; 
        function set prefix(s:String):void ; 

        /**
         * (Read-write) The suffix of the localization file.
         */
        function get suffix():String ;
        function set suffix( value:String ):void ;
        
        /**
         * Sends and loads data from the specified passed-in lang value (the passed-in argument must be a Lang reference or a valid string).
         * @param lang The localization Lang value.
         */
        function loadLang( lang:* ):void
    }
    
}