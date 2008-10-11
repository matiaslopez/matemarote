/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is LunAS Library.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
  Laurent Marlin <contact@mediaboost.fr> 

*/
package lunas.display.button 
{
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    
    import lunas.core.EdgeMetrics;    

    /**
     * The IStyle class of the IconButton component.
     */
	public class IconButtonBuilder extends LabelButtonBuilder 
	{
		/**
		 * Creates a new IconButtonBuilder instance.
		 * @param target the target of the component reference to build.
		 * @param bGlobal the flag to use a global event flow or a local event flow.
		 * @param sChannel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
		 */
		public function IconButtonBuilder(target:*, bGlobal:Boolean = false, sChannel:String = null)
		{
			super( target, bGlobal, sChannel );
		}
		
		/**
	     * The picture container reference of the component.
		 */
		public var container:DisplayObject ;	
		
		/**
		 * Attach a linked DisplayObject to create the icon of the component.
		 */
		public function attach( state:DisplayObject ):void
		{
			_releaseContainer() ;
			container = state ;
			( target as IconButton ).addChild( container ) ;
			( target as IconButton ).update() ;
		}
		
 		/**
	     * Clear the view of the component.
	     */
    	public override function clear():void 
    	{
			super.clear() ; 
    		var b:IconButton = target as IconButton ;	
    		if ( container != null && b.contains( container) )
    		{
	        	b.removeChild( container ) ;
    		}
        	container = null ;
	    }
				
		/**
		 * Loads an external picture or swf in the component to create the icon.
		 */
		public function load( request:URLRequest ):void
		{
			_releaseContainer() ;
			container = new Loader() ;
         	(container as Loader).contentLoaderInfo.addEventListener( Event.INIT            , _initialize ) ;
         	(container as Loader).contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR , _ioError    ) ;  			
			(container as Loader).load( request ) ;
		} 		
		
	    /**
	     * Update the view of the component.
	     */
    	public override function update():void 
	    {
       		refreshField()  ;
        	refreshFieldLayout() ;
       		refreshContainer() ;
    	}			
				
		/**
	 	 * The method invoked when the loading is finished and initialize.
		 */
		private function _initialize( e:Event ):void
		{
			( target as IconButton ).addChild(container) ;
            update() ;
		}
		
	    /**
	     * Refresh the container.
	     */
		protected function refreshContainer():void
		{
		
			if ( container != null )
			{
    			var t:IconButton      = target as IconButton ;	
        		var s:IconButtonStyle = t.style as IconButtonStyle ;
	
				var ml:Number = EdgeMetrics.filterNaNValue( s.margin.left ) ;
				var mr:Number = EdgeMetrics.filterNaNValue( s.margin.right ) ;
						
				var pb:Number = EdgeMetrics.filterNaNValue( s.padding.bottom ) ;
				var pl:Number = EdgeMetrics.filterNaNValue( s.padding.left ) ;
				var pt:Number = EdgeMetrics.filterNaNValue( s.padding.top ) ;
			
				container.x   = ml ;

				field.x      = container.x + container.width + pl ;
				field.width  = isNaN( s.width ) ? ( t.w - ( field.x + mr ) ) : s.width ; 
				field.height = isNaN( s.height) ? ( t.h - pb - pt ) : s.height ;			
		
				container.y = (t.height - container.height) / 2-2 ;			
			}
			
		}   		
		
		/**
		 * Release the container.
		 */
		private function _releaseContainer():void
		{
			if ( container != null )
			{
				if ( container is Loader )
				{
		         	(container as Loader).contentLoaderInfo.removeEventListener( Event.INIT            , _initialize ) ;
         			(container as Loader).contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR , _ioError    ) ;  			
					if( (container as Loader).content != null )
					{
						(container as Loader).unload() ;
					}
				}
				if ( ( target as IconButton ).contains( container ) )
				{
					( target as IconButton ).removeChild( container ) ;	
				}
				container = null ;
			}
		}
		
		/**
	 	 * The method invoked when the loading is finished and initialize.
		 */
		private function _ioError( e:Event ):void
		{
			getLogger().error( this + " ioError : " + e ) ;
		}
	}
}
