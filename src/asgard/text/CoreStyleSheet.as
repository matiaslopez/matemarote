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
package asgard.text 
{
    import flash.text.StyleSheet;
    
    import system.Reflection;
    
    import vegas.core.Identifiable;    

    /**
     * The CoreStyleSheet class extends the flash.text.StyleSheet.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import asgard.text.CoreTextField ;
     * import asgard.text.CoreStyleSheet ;
     * 
     * var css:String = "p{font-family:arial;font-size:14px;color:#FFFFFF}" ;
     * 
     * var field:CoreTextField = new CoreTextField( "my_field" , 150 , 22 ) ;
     * 
     * field.x = 25 ;
     * field.y = 25 ;
     * 
     * field.styleSheet  = new CoreStyleSheet( css ) ;
     * </pre>
     * @author eKameleon
     */
    public class CoreStyleSheet extends StyleSheet implements Identifiable
    {
		
		/**
         * Creates a new CoreStyleSheet instance.
         * @param source The CSS String representation to parse.
		 * @param id Indicates the id of the object.
		 */
		public function CoreStyleSheet( source:String=null , id:* = null )
        {
            if ( id != null )
            {
                this.id = id ;
            }
        	if ( source != null )
        	{
        		parseCSS(source) ;		
        	}
        }
        
        /**
         * Returns the id of this object.
         * @return the id of this object.
         */
        public function get id():*
        {
            return _id ;
        }
    
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public function set id( id:* ):void
        {
            this._id = id ;
        }
        
        /**
         * Returns the <code class="prettyprint">String</code> representation of this object.
         * @return the <code class="prettyprint">String</code> representation of this object.
         */
        public override function toString():String
        {
            var str:String = "[" + Reflection.getClassName(this) ;
            if ( this.id != null )
            {
                str += " " + this.id ;    
            } 
            str += "]" ;
            return str ;
        }        
        
        /**
         * The internal id of this object.
         * @private
         */
        private var _id:* = null ;    
        
    }
}
