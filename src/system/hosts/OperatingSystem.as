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
    import system.Version;    

    /**
	 * Represents information about an operating system, such as the version and platform identifier. 
	 * This class cannot be inherited.
	 */
    public class OperatingSystem
        {
		
		/**
		 * @private
		 */
		private var _platform:PlatformID ;
		
		/**
		 * @private
		 */
		private var _version:Version ;

		/**
		 * Creates a new OperatingSystem instance.
		 * @param platform The PlatformID of the application operating system.
		 * @param version The Version of the application operating system.
		 */
        public function OperatingSystem( platform:PlatformID, version:Version )
            {
            _platform = platform;
            _version  = version;
            }

		/**
		 * Returns the platform id of this operating system.
		 * @return the platform id of this operating system.
		 */
        public function get platform():PlatformID
            {
            return _platform;
            }

		/**
		 * Returns the version of this operating system.
		 * @return the version of this operating system.
		 */
        public function get version():Version
            {
            return _version;
            }

		/**
		 * Returns the String representation of the object.
		 * @return the String representation of the object.
		 */
        public function toString():String
            {
            //return platform.toString() + " " + version.toString();
            return platform.toString();
            }
        
        }
    
    }

