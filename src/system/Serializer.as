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
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
    - Marc Alcaraz <ekameleon@gmail.com>
*/

package system
    {
    
    /**
     * Defines what a Serializer have to implements to be integrated in the framework.
     * <p><b>Note :</b> Every serializers (eden, json, wddx, etc.) should implement it.</p>
     */       
    public interface Serializer
        {
        
        /**
         * The prettyIndent value of the serializer.
         */
        function get prettyIndent():int;
        
        /**
         * @private
         */
        function set prettyIndent( value:int ):void;
        
        /**
         * The prettyPrinting value of the serializer.
         */        
        function get prettyPrinting():Boolean;

        /**
         * @private
         */
        function set prettyPrinting( value:Boolean ):void;
        
        /**
         * The identor String value of the serializer.
         */      
        function get indentor():String;

        /**
         * @private
         */
        function set indentor( value:String ):void;
        
        /**
         * Serialize the specified object.
         */
        function serialize( value:* ):String;

        /**
         * Deserialiaze the specified String source representation.
         */
        function deserialize( source:String ):*;
        
        
        }
    }

