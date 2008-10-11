/*

The contents of this file are subject to the Mozilla Public License Version
1.1 (the "License"); you may not use this file except in compliance with
the License. You may obtain a copy of the License at 
  
http://www.mozilla.org/MPL/ 
  
Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
for the specific language governing rights and limitations under the License. 
  
The Original Code is Vegas Framework.
  
The Initial Developer of the Original Code is
ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
Portions created by the Initial Developer are Copyright (C) 2004-2008
the Initial Developer. All Rights Reserved.
  
Contributor(s) :
  
*/
package vegas.util
{
    import flash.utils.Dictionary;
    
    import system.Reflection;    

    /**
     * The <code class="prettyprint">ClassUtil</code> utility class is an all-static class with methods for working with function the Class in AS3.
     * @author eKameleon
     */
    public class ClassUtil
    {
                
        /**
         * Returns the unique name of the specified instance in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import flash.display.Sprite ;
         * 
         * trace( ClassUtil.getUniqueName( new Sprite()  ) ) ; // Sprite0
         * trace( ClassUtil.getUniqueName( new Sprite()  ) ) ; // Sprite1
         * 
         * trace( ClassUtil.getUniqueName( new Sprite() , true ) ) ; // flash.display.Sprite0
         * trace( ClassUtil.getUniqueName( new Sprite() , true ) ) ; // flash.display.Sprite1
         * </pre>
         * @return the unique name of the specified instance in argument.
         */
        public static function getUniqueName( o:* , isFull:Boolean=false ):String
        {
            var name:String = isFull ? Reflection.getClassPath( o ) : Reflection.getClassName( o ) ;
            var charCode:int = name.charCodeAt( name.length - 1 );
            if (charCode >= 48 && charCode <= 57) // if the class name finish with a number 0..9
            {
                name += "_" ;
            }
            if ( _clazzBuffer[name] == null )
            {
                _clazzBuffer[name] = 0 ;    
            }
            else
            {
                _clazzBuffer[name] ++ ;
            }
            return name + _clazzBuffer[name] ;
        }
        
        /**
         * @private
         */
        private static var _clazzBuffer:Dictionary = new Dictionary(true) ;
         
    }    
}

