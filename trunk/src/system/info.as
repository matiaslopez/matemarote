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
    import system.Version;
    import system.config;
    
    /**
	 * The basic system info.
	 * @param verbose The flag to indicates if the log information use verbose mode or not.
	 * @param showConfig Indicates if the log information show config values.
     */
    public function info( verbose:Boolean = false, showConfig:Boolean = false ):String
        {
        
        var separator:String = "----------------------------------------------------------------";
        
        var CRLF:String      = "\n";
        var name:String      = "ES4a";
        var fullname:String  = "ECMAScript 4 MaasHaack framework";
        var version:Version  = new Version( 0, 1 );
            version.revision = parseInt( "$Rev: 276 $".split( " " )[1] );
         
        var str:String = "";
            if( !verbose && config.verbose )
                {
                verbose = true;
                }
            
            if( verbose ) 
            	{
            	str += "{sep}{crlf}";
            	str += "{name}: {fullname} v{version}{crlf}";
            	str += "Host: {host}{isdebug}{crlf}";
            	str += "Operating System: {os}{crlf}";
            	str += "{sep}";
            	} 
            else 
            	{
            	str += "{name} v{version}"; 
            	}
            
            if( showConfig ) 
            	{
            	str += "{crlf}config:";
            	str += "{config}{crlf}";
            	str += "{sep}";
            	}
            
        return Strings.format( str,
                               {
                               sep:separator,
                               crlf:CRLF,
                               name:name,
                               fullname:fullname,
                               version:version,
                               host: Environment.host,
                               isdebug: Environment.host.isDebug() ? " (debug)": "",
                               os: Environment.os,
                               config: config.toSource()
                               }
                             );
        }
    
    }

