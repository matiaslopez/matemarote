/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is ASGard Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package asgard.display
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    
    import asgard.net.FlashVars;    

    /**
	 * The ApplicationDisplay class is a MovieClip class to creates the main class of your applications in AS3.
	 * This source code is inspired of the original TopLevel class of Senocular : http://www.senocular.com/flash/actionscript.php?file=ActionScript_3.0/TopLevel.as
	 * @author eKameleon
	 */
	public class ApplicationDisplay extends CoreMovieClip 
	{

		/**
		 * Creates a new ApplicationDisplay instance.
		 * @param id Indicates the id of the object.
		 * @param isConfigurable This flag indicates if the IConfigurable object is register in the ConfigCollector.
		 * @param name Indicates the instance name of the object.
		 */
		public function ApplicationDisplay( id:*=null, isConfigurable:Boolean=false, name:String=null )
		{
			
			super( id , isConfigurable , name ) ;
			
			if ( ApplicationDisplay.flashVars == null )
			{
				ApplicationDisplay.flashVars = new FlashVars( this ) ;
			}
			
			if ( ApplicationDisplay.stage == null )
			{
				ApplicationDisplay.stage = this.stage ;
			}
			
			if ( ApplicationDisplay.root == null )
			{
				ApplicationDisplay.root = this       ;
			}
			
			if ( ApplicationDisplay.global == null )
			{			
				ApplicationDisplay.global = _global    ;
			}
			
		}
		
		/**
		 * The global reference of all FlashVars of this application.
		 */
		public static var flashVars:FlashVars ;
		
		/**
		 * The global reference of the application.
		 */
		public static var global:* ;
		
		/**
		 * The root reference of the application.
		 */
		public static var root:DisplayObjectContainer ;

		/**
		 * The stage reference of the application.
		 */
		public static var stage:Stage ;
		
	}
	
}

var _global:* = this  ;


