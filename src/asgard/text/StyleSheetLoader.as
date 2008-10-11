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
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.text.StyleSheet;    

    /**
     * This loader load an external css file to fill the StyleSheet object defines over this loader.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import asgard.text.CoreTextField ;
     * import asgard.text.StyleSheetLoader ;
     * 
     * import flash.events.Event ;
     * import flash.net.URLRequest ;
     * 
     * import vegas.string.HTMLStringFormatter ;
     * 
     * var style:StyleSheet = new StyleSheet() ;
     * 
     * var complete:Function = function( e:Event )
     * {
     *     trace( e ) ;
     * }
     * 
     * var loader:StyleSheetLoader = new StyleSheetLoader( style ) ;
     * loader.addEventListener( Event.COMPLETE , complete ) ;
     * 
     * var field:CoreTextField = new CoreTextField( null , 150 , 20 ) ;
     * field.autoSize   = TextFieldAutoSize.LEFT ;
     * field.styleSheet = style ;
     * field.x          = 25 ;
     * field.y          = 25 ;
     * field.htmlText   = HTMLStringFormatter.paragraph("hello world" , "my_style" ) ;
     * 
     * addChild(field) ;
     * 
     * loader.load( new URLRequest( "style/style.css" ) ) ;
     * </pre>
     * @author eKameleon
     */
    public class StyleSheetLoader extends URLLoader
    {
        
        /**
         * Creates a new StyleSheetLoader instance.
         * @param styleSheet The StyleSheet reference to register in this loader.
         * @param request The URLRequest of this loader to load the external style sheet.
         */ 
        public function StyleSheetLoader( styleSheet:StyleSheet=null , request:URLRequest=null )
        {
            super( request ) ;
            addEventListener(Event.COMPLETE, complete) ;
            this.styleSheet = styleSheet ;
        }        
        
        /**
         * The StyleSheet reference of this loader.
         */
        public function get styleSheet():StyleSheet
        {
            return _styleSheet ;    
        }
        
        /**
         * @private
         */
        public function set styleSheet( styleSheet:StyleSheet ):void
        {
            _styleSheet = ( styleSheet != null ) ? styleSheet : new StyleSheet() ;    
        }        
        
        /**
         * Invoked when the loader process is complete to parse the datas.
         */
        protected function complete(e:Event):void
        {
            styleSheet.parseCSS( data ) ;
        }
    
        /**
         * @private
         */
        private var _styleSheet:StyleSheet ;
    
    }
    
}
