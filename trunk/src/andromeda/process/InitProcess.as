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

    /**
     * This Action launch the init method of ths process but notify an event before (ActionEvent.START) and after(ActionEvent.FINISH) the process.
     * This class is a pseudo abstract class. Don't instanciate this class but create a custom class with it.
     * @example
     * You must use this class with a custom class who extends this class.
     * <pre class="prettyprint">
     * import andromeda.events.ActionEvent ;
     * import test.InitTest ; // extends InitProcess.
     * 
     * var debug:Function = function( e:ActionEvent ):void
     * {
     *     trace ( e ) ;
     * }
     * 
     * var p:InitTest = new InitTest() ;
     * p.addEventListener( ActionEvent.START  , debug ) ;
     * p.addEventListener( ActionEvent.FINISH , debug ) ;
     * 
     * p.run() ;
     * 
     * // [ActionEvent type="onStarted" target=[InitTest] context=null bubbles=false cancelable=false eventPhase=2]
     * // [InitTest] custom initialize
     * // [ActionEvent type="onFinished" target=[InitTest] context=null bubbles=false cancelable=false eventPhase=2]
     * </pre>
     * <code class="prettyprint">InitTest</code> is the child class of the <code class="prettyprint">InitProcess</code> pseudo abstract class :
     * <pre class="prettyprint">
     * package test
     * {
     *     import andromeda.process.InitProcess ;
     *     
     *     public class InitTest extends InitProcess
     *     {
     *     
     *         public function InitTest( bGlobal:Boolean = false , sChannel:String = null )
     *         {
     *             super( bGlobal, sChannel);
     *         }
     *         
     *         public override function init():void
     *         {
     *             trace( this + " custom initialize") ;
     *         }
     *     }
     * }
     * </pre>
     * @author ekameleon
     */
    public class InitProcess extends ActionProxy
    {

        /**
         * Creates a new InitProcess instance.
         * @param bGlobal the flag to use a global event flow or a local event flow.
         * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function InitProcess( bGlobal:Boolean = false , sChannel:String = null ) 
        {
            super( this, this.init, null, bGlobal, sChannel);
        }

        /**
         * Invoked when the process is run. Overrides this method.
         */
        public function init():void
        {
            // override
        }
        
    }
}
