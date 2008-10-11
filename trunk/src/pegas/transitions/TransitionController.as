/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package pegas.transitions 
{
    import vegas.data.Map;
    import vegas.data.map.HashMap;
    import vegas.events.CoreEventDispatcher;
    import vegas.util.TypeUtil;    

    /**
	 * The TransitionController register all the ITransition of the application.
	 * @author eKameleon
	 */
	public class TransitionController extends CoreEventDispatcher 
	{

		/**
	 	 * Creates a new TransitionController instance.
		 * <p><b>Example :</b> 
	 	 * <pre class="prettyprint">
		 * var controller:TransitionController = new TransitionController() ;
		 * </pre>
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function TransitionController(bGlobal:Boolean = false, sChannel:String = null)
		{
			super( bGlobal , sChannel ) ;	
			_map = new HashMap() ;
		}
		
		/**
		 * Returns <code class="prettyprint">true</code> if the <code class="prettyprint">id</code> passed in argument is registered in the TransitionController.
		 * @param id the <code class="prettyprint">id</code> of the ITransition object mapped in the TransitionController.
		 * @return <code class="prettyprint">true</code> if the <code class="prettyprint">id</code> passed in argument is registered in the TransitionController.
		 */
		public function contains( id:String ):Boolean 
		{
			return _map.containsKey( id ) ;	
		}
			
		/**
		 * Returns <code class="prettyprint">true</code> if the <code class="prettyprint">Transition</code> passed in argument is registered in the TransitionController.
		 * @param transition the <code class="prettyprint">Transition</code> reference to search in the TransitionController.
		 * @return <code class="prettyprint">true</code> if the <code class="prettyprint">Transition</code> passed in argument is registered in the TransitionController.
	 	 */
		public function containsTransition( transition:ITransition ):Boolean 
		{
			return _map.containsValue( transition ) ;	
		}
		
		/**
		 * Returns the singleton instance of TransitionController class.
		 * @return singleton instance of TransitionController class.
		 */
		public static function getInstance():TransitionController
		{
			if ( _instance == null )
			{
				_instance = new TransitionController() ;
			}
			return _instance ;
		}
		
		/**
		 * Returns a ITransition reference register in the TransitionController with the specified <code class="prettyprint">id</code> passed in argument.
	 	 * @param  id the <code class="prettyprint">id</code> of the ITransition object mapped in the TransitionController.
		 * @return the ITransition object mapped in the TransitionController.  
		 */
		public function getTransition( id:* ):ITransition 
		{
			return _map.get( id ) ;
		}
			
		/**
		 * Adds a new entry into the TransitionController.
		 * @param transition the ITransition to register in the TransitionController.
	 	 * @throws ArgumentError if the argument is 'null' or 'undefined'.
		 * @throws ArgumentError if the ITransition object ID is empty.
		 */
		public function insert( transition:ITransition ):void 
		{
			if (transition == null)
			{
				throw new ArgumentError( this + " insert failed, the transition argument not must be 'null' or 'undefined'") ;
			}
			if ( transition.id != null )
			{
				_map.put( transition.id, transition ) ;
			}
			else
			{
				throw new ArgumentError( this + " insert failed if the passed-in ITransition object don't contains an empty ID.") ;	
			}
		}
	
		/**
		 * Removes an entry into the TransitionController.
		 * @param transition the id of the ITransition object mapped in the TransitionController or a ITransition object to remove.
		 * @return The removed ITransition object or null if the ITransition don't exist in the controller. 
		 */
		public function remove( transition:* ):*
		{
			if (transition is ITransition)
			{
				return _map.remove( ITransition(transition).id ) ;
			}
			else if ( TypeUtil.typesMatch( transition, String ) )
			{
				return _map.remove( transition ) ;
			}
			else
			{
				getLogger().warn( this + " remove failed with an unknow ITransition or ID passed-in argument." ) ;
				return null ;	
			}
		}

		/**
		 * Run the specified Transition.
		 * @param id the id of the Transition to be run.
		 * @throws ArgumentError if the <code class="prettyprint">id</code> passed in argument isn't register in this TransitionCntroller
		 * @throws ArgumentError if the <code class="prettyprint">id</code> passed in argument is 'null' or 'undefined'.
		 */
		public function run( id:String ):void
		{
			if (id == null)
			{
				throw new ArgumentError(this + " run method failed, the 'id' passed in argument not must be 'null' or 'undefined'.") ;	
			}
			if (contains(id))
			{
				getTransition( id ).run() ;	
			}
			else
			{
				throw new ArgumentError(this + " run method failed, the 'id' passed in argument isn't register in this TransitionController : " + id) ;	
			}
		}
		
		/**
		 * The singleton reference of this class.
		 */
		private static var _instance:TransitionController ;
		
		/**
		 * Internal HashMap instance.
		 */
		private var _map:Map ;
		
	}
	
}
