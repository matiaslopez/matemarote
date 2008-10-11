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

package system.diagnostics
{
    import flash.trace.Trace;
    
    import system.Strings;
    import system.console;
    import system.io.Writeable;    

    /**
     * The internal VirtualMachine class.
     */
    public class _VirtualMachine
        {
        
        /**
         * @private
         */
        private var _tracing:Boolean     = false;
        
        /**
         * @private
         */
        private var _writer:Writeable    = console;
        
        /**
         * Indicates if the machine filter the methods.
         */
        public var filterMethods:Boolean = true;
        
        /**
         * Indicates the list of the filtered methods.
         */
        public var filteredMethods:Array = [ "flash.trace::Trace$/setLevel",
                                             "system.diagnostics::_VirtualMachine/beginTrace",
                                             "system.diagnostics::_VirtualMachine/endTrace" ];        
        /**
         * Indicates the formatter pattern.
         */
        public var formatter:String      = "  * {method}({args})";
        
        /**
         * Indicates if show the packages.
         */
        public var showPackages:Boolean  = true;
        
        /**
         * @private
         */
        private function _filterBuiltin( str:String, beginWith:String, replaceWith:String ):String
            {
            if( Strings.startsWith( str, beginWith ) )
                {
                str = str.split( beginWith ).join( replaceWith );
                }
            
            return str;
            }        
        
        /**
         * Creates a new VirtualMachine instance.
         * @param listener The callback listener function use to dispatch the messages.
         */
        public function _VirtualMachine( listener:Function = null )
            {
            if( listener == null )
                {
                Trace.setListener( traceListener );
                }
            else
                {
                Trace.setListener( listener );
                }
            }
        
        /**
         * Indicates if the machine is tracing.
         */
        public function isTracing():Boolean
            {
            return _tracing;
            }
        
        /**
         * Trace the messages in the console.
         */
        public function traceListener( line:String, index:int, method:String, args:String ):void
            {
            if( filterMethods )
                {
                var i:int;
                var len:int = filteredMethods.length;
                for( i=0; i<len; i++ )
                    {
                    if( filteredMethods[i] == method )
                        {
                        return;
                        }
                    }
                }
            
            method = _filterBuiltin( method, "String/http://adobe.com/AS3/2006/builtin::", "String/" );
            method = _filterBuiltin( method, "Array/http://adobe.com/AS3/2006/builtin::", "Array/" );
            
            if( !showPackages && (method.indexOf("::")>-1) )
                {
                method = method.split( "::" )[1];
                }
            
            /* TODO:
               Strings.format is too slow to parse the flow of data from Trace
               and make the flash player crash
               define a special really fast Strings.format using a namespace ?
            */
            //public::trace( Strings.format( formatter, {line:line,index:index,method:method,args:args} ) );
            //_writer.writeLine( formatter, {line:line,index:index,method:method,args:args} );
            _writer.writeLine( method+"("+args+")" );
            }
        
        /**
         * Insert in the console the header (begin trace).
         */
        public function beginTrace():void
            {
            _tracing = true;
            _writer.writeLine( "------------------------------------------------------" );
            Trace.setLevel( Trace.METHODS_WITH_ARGS, Trace.LISTENER );
            }
        
        /**
         * Insert in the console the footer (begin trace).
         */
        public function endTrace():void
            {
            Trace.setLevel( Trace.OFF, Trace.LISTENER );
            _writer.writeLine( "------------------------------------------------------" );
            _tracing = false;
            }
        
        }
    }
