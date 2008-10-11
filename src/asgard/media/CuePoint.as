/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.media 
{
    import andromeda.vo.SimpleValueObject;
    
    /**
     * The CuePoint information object.
     * @author eKameleon
     */
    public class CuePoint extends SimpleValueObject 
    {

        /**
         * Creates a new CuePoint instance.
         * @param init An Object with the properties 'name', 'parameters', 'time' and 'type' used to define this CuePoint object.
         */    
        public function CuePoint(init:Object = null)
        {
            super( init );
        }
        
        /**
         * The name of the CuePoint.
         */
        public var name:String ;
            
        /**
         * A associative array of name/value pair strings specified for this cue point. 
         * Any valid string can be used for the parameter name or value.
         */
        public var parameters:Array ;
        
        /**
         * The time of the CuePoint.
         */
        public var time:String ;
            
        /**
         * The type of the CuePoint.
         */
        public var type:String ;
        
        /**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
        public override function toString():String
        {
            var txt:String = "[CuePoint" ;
            if (name != null)
            {
                txt += ",name:" + name ;
            }
            if (time != null)
            {
                txt += ",time:" + time ;
            }
            if (type != null)
            {
                txt += ",type:" + type ;
            } 
            if (parameters != null)
            {
                txt += ",parameters:" + parameters ;
            } 
            txt += "]" ;
            return txt ;     
        }
        
    }

}
