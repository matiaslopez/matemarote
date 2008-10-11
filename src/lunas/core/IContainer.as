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
  
*/
package lunas.core 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.text.TextSnapshot;	

	/**
	 * This interface defines all method of the Container components.
	 * @author eKameleon
	 */
	public interface IContainer 
	{

		function get mouseChildren() : Boolean;
		function set mouseChildren(enable : Boolean) : void;

		function get numChildren() : int;

		function get tabChildren() : Boolean;
		function set tabChildren( enable:Boolean ):void ;
		
		function get textSnapshot():TextSnapshot;

		function addChild( child:DisplayObject) : DisplayObject;

		function addChildAt( child:DisplayObject, index:int ):DisplayObject;

		function areInaccessibleObjectsUnderPoint( point:Point ):Boolean;

		function contains(child : DisplayObject) : Boolean;

		function getChildAt(index : int) : DisplayObject;

		function getChildByName( name:String ):DisplayObject ;

		function getChildIndex( child:DisplayObject ):int ;

		function getObjectsUnderPoint( point:Point ):Array ;

		function removeChild( child:DisplayObject ):DisplayObject ;
		
		function removeChildAt(index : int) : DisplayObject;

		function setChildIndex(child : DisplayObject, index : int) : void;
		
		function swapChildren(child1 : DisplayObject, child2 : DisplayObject) : void;		
		
		function swapChildrenAt(index1 : int, index2 : int) : void;

	}

}
