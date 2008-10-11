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
  Marc Alcaraz <ekameleon@gmail.com>.

*/

package system.terminals
    {
    
    /**
     * An InteractiveConsole can interact with the user and the system using standard streams : 
     * standard input (stdin), standard output (stdout) and standard error (stderr).
     * <p><b>See :</b> <http://en.wikipedia.org/wiki/Standard_streams>.</p>
     */
    public interface InteractiveConsole extends Console
        {
			
        /**
         * Standard error is another output stream typically used by programs to output error messages or diagnostics. 
         * It is a stream independent of standard output and can be redirected separately.
         */
        function get stderr():String ;
        
        /**
         * @private
         */
        function set stderr( value:String ):void ;
        
        /**
         * Standard input is data (often text) going into a program. 
         * The program requests data transfers by use of the read operation.
         * Not all programs require input.
         */
        function get stdin():String ;
        
        /**
         * @private
         */
        function set stdin( value:String ):void;
        
        /**
         * Standard output is the stream where a program writes its output data. 
         * The program requests data transfer with the write operation.
         * Not all programs generate output.
         */
        function get stdout():String ;
        
        /**
         * @private
         */
        function set stdout( value:String ):void ;        
        
        /**
         * Clear all standard streams.
         */
        function clear():void ;
        
        }
    
    }

