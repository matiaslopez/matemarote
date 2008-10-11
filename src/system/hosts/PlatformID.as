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
     * This enumeration defines the sort of plateforms used in your application. 
     */
    public class PlatformID extends Enum
        {
        
        /**
         * Creates a new PlatformID instance.
         * @param value The value of the enumeration.
         * @param name The name key of the enumeration.
         */
        public function PlatformID( value:int, name:String )
            {
            super( value, name );
            }
        
        /**
         * The 'Unknown' plateform id.
         */
        public static const Unknown:PlatformID   = new PlatformID( 0, "Unknown" );
        
        /**
         * The 'Web' plateform id.
         */
        public static const Web:PlatformID       = new PlatformID( 1, "Web" );
        
        /**
         * The 'Windows' plateform id.
         */
        public static const Windows:PlatformID   = new PlatformID( 2, "Windows" );
        
        /**
         * The 'Macintosh' plateform id.
         */
        public static const Macintosh:PlatformID = new PlatformID( 3, "Macintosh" );
        
        /**
         * The 'Unix' plateform id.
         */
        public static const Unix:PlatformID      = new PlatformID( 4, "Unix" );
        
        /**
         * The 'Arm' plateform id.
         */
        public static const Arm:PlatformID       = new PlatformID( 5, "Arm" );
        
        }
    
    }

