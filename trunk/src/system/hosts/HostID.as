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
package system.hosts
{
    import system.Enum;    

    /**
	 * This static enumeration class defines all host identifiers.
	 */
    public class HostID extends Enum
        {

     	/**
     	 * Creates a new HostID instance.
     	 */   
        public function HostID( value:int, name:String )
            {
            super( value, name );
            }
        
        /**
         * The 'Unknow' host id constant.
         */
        public static const Unknown:HostID = new HostID( 0, "Unknown" );
        
        /**
         * The 'Flash' host id constant.
         */
        public static const Flash:HostID = new HostID( 1, "Flash" );
        
        /**
         * The 'Air' host id constant.
         */
        public static const Air:HostID = new HostID( 2, "Air" );
        
        /* note:
           We will take into account only hosts upon which you can build
           "real" application, no moving target.
        */
        /*
        public static const Tamarin:HostID    = new HostID( 3, "Tamarin" );
        public static const RedTamarin:HostID = new HostID( 4, "RedTamarin" );
        */
        }
    
    }

