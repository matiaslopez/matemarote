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
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  - Marc Alcaraz <ekameleon@gmail.com>
*/

package system.serializers.eden
    {
    import system.serializers.eden.EdenConfigurator;
    
    /**
     * The EdenConfigurator reference used to configure the eden parser.
     */
    public var config:EdenConfigurator = new EdenConfigurator( {
                                                                   compress: true,
                                                                   copyObjectByValue: false,
                                                                   strictMode: true,
                                                                   undefineable: undefined,
                                                                   verbose: false,
                                                                   security: true,
                                                                   authorized: [ "Array.*",
                                                                                 "Boolean",
                                                                                 "Date",
                                                                                 "Error",
                                                                                 "Math.*",
                                                                                 "Number.*",
                                                                                 "Object",
                                                                                 "String",
                                                                                 "Infinity" ],
                                                                   allowFunctionCall: true,
                                                                   autoAddScopePath: false,
                                                                   arrayIndexAsBracket: false
                                                                   } );
    
    }

