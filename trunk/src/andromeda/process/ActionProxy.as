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
package andromeda.process
{
    import vegas.events.Delegate;    

    /**
     * This <code class="prettyprint">IAction</code> object run a proxy method.
     * @example
     * <pre class="prettyprint">
     * import andromeda.events.ActionEvent ;
     * import andromeda.process.ActionProxy ;
     * 
     * var debug:Function = function( e:ActionEvent ):void
     * {
     *     trace ( e ) ;
     * }
     * 
     * var test:Function = function( ...args:Array ):void
     * {
     *     trace( this + " test : " + args ) ;
     * }
     * 
     * var o:Object = {} ;
     * o.toString = function():String
     * {
     *     return "myObject" ;
     * }
     * 
     * var ap:ActionProxy = new ActionProxy( o, test, ["hello world", true] ) ;
     * trace ( "action proxy    : " + ap ) ;
     * trace ( "action toSource : " + ap.toSource() ) ;
     * ap.addEventListener( ActionEvent.START  , debug ) ;
     * ap.addEventListener( ActionEvent.FINISH , debug ) ;
     * 
     * ap.run() ; // run the process
     * 
     * // action proxy : [ActionProxy]
     * // action toSource : new andromeda.process.ActionProxy()
     * // [ActionEvent type="onStarted" target=[ActionProxy] context=null bubbles=false cancelable=false eventPhase=2]
     * // myObject test : hello world,true
     * // [ActionEvent type="onFinished" target=[ActionProxy] context=null bubbles=false cancelable=false eventPhase=2]
     * </pre>
     * @author eKameleon
     * @see vegas.events.Delegate
     */
    public class ActionProxy extends SimpleAction
    {
    
        /**
         * Creates a new ActionProxy instance.
         * @param scope The scope of the proxy method invoked in this process.
         * @param method The method invoked in this process.
         * @param args The Arguments injected in the method.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        function ActionProxy( scope:*, method:Function , args:Array=null , bGlobal:Boolean = false , sChannel:String = null )
        {
            super( bGlobal, sChannel );
            this.args   = args ;
            this.method = method ;
            this.scope  = scope ;
        }
        
        /**
         * The array representation of the proxy method invoked in this process.
         */
        public var args:Array ;
        
        /**
         * The proxy method invoked in this process.
         */
        public var method:Function ;
        
        /**
         * The scope reference of the proxy method of this process.
         */
        public var scope:Object ;

        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new ActionProxy( scope, method, args ) ;
        }

        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            notifyStarted() ;
            setRunning(true) ;
            var params:Array = [scope, method] ;
            if ( args != null && args.length > 0 )
            {
                params = params.concat(args) ;
            }
            Delegate.create.apply(this, params)();
            setRunning(false) ;
            notifyFinished() ;
        }

    }

}