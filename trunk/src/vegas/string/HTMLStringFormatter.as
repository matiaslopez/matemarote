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
package vegas.string
{
    
    /**
     * This static tool class defined each of the following methods returns a copy of the string wrapped inside an HTML tag.
     * For example, <code class="prettyprint">HTMLStringFormatter.bold("test")</code> returns <code class="prettyprint"><b>test</b></code>.
     * Compatibility with Javascript String HTML wrappers, this methods are native in the Javascript String class. 
     * @author eKameleon
     */
    public class HTMLStringFormatter
    {
        
        /**
         * Creates an HTML anchor that is used as a hypertext target.
         * @param str the string to be formatted.
         * @param name the name of the anchor.
         * @return the string formatted with the method.
         */
        public static function anchor( str:String , name:String ):String
        {
            return '<a name="' + name + "'>" + str + "</a>" ; 
        }        

        /**
         * Use the big method to format and display a string in a document.
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function big( str:String ):String
        {
             return "<big>" + str + "</big>" ;
        }

        /**
         * Use the blink method to format and display a string in a document.
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function blink( str:String ):String
        {
            return "<blink>" + str + "</blink>" ;
        }

        /**
         * Use the bold method to format and display a string in a document.
         * <pre class="prettyprint">
         * var s:String = HTMLStringFormatter.bold("hello world") ;
         * trace("bold : " + s) ; // bold : &lt;b&gt;hello world&lt;/b&gt;
         * </pre>
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function bold( str:String ):String
        {
            return "<b>" + str + "</b>" ;
        }

        /**
         * Use the fixed method to format and display a string in a document.
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function fixed( str:String ):String
        {
            return "<tt>" + str + "</tt>" ;
        }

        /**
         * Use the fontColor method to format and display a string in a document.
         * @param str the string to be formatted.
         * @param color the string hexadecimal RGB triplet with the format rrggbb.
         * @return the string formatted with the method.
         */
        public static function fontColor( str:String , color:String ):String
        {
            return "<font color='" + color + "'>" + str + "</font>" ;
        }
        
        /**
         * Use the fontColor method to format and display a string in a document.
         * @param str the string to be formatted.
         * @param size an Integer representing the size of the font.
         * @return the string formatted with the method.
         */
        public static function fontSize( str:String , size:Number ):String
        {
            return "<font size='" + size + "'>" + str + "</font>" ;
        }

        /**
         * Use the italics method to format and display a string in a document.
         * <pre class="prettyprint">
         * import vegas.string.HTMLStringFormatter ;
         * var s:String = HTMLStringFormatter.italics("hello world") ;
         * trace("italics : " + s) ; // italics : &lt;i&gt;hello world&lt;/i&gt;
         * </pre>
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function italics( str:String ):String
        {
            return  "<i>" + str + "</i>" ;
        }

        /**
         * Creates an HTML hypertext link that requests another URL.
         * <pre class="prettyprint">
         * import vegas.string.HTMLStringFormatter ;
         * var s:String = HTMLStringFormatter.link("hello world", "http://ekameleon.net/blog", "_blank") ;
         * trace("link : " + s) ; // link : &lt;a href=&quot;http://google.fr&quot; target=&quot;_blank&quot;&gt;hello world&lt;/a&gt;
         * </pre>
         * @param str the string to be formatted.
         * @param url any string that specifies the HREF of the A tag; it should be a valid URL (relative or absolute).
         * @param target (optional) this value defined to the anchor tag forces the load of that link into the targeted window.
         * @return the string formatted with the method.
         */
        public static function link( str:String , url:String="" , target:String=null ):String
        {
            var s:String = '<a href=\"' + url + '\"' ;
            if (target != null)
            {
                s += ' target=\"' + target + '\"' ;
            }
            s += ">" + str + "</a>" ;
            return s ; 
        }        

        /**
         * Creates an HTML paragraph HTML string in a document.
         * <pre class="prettyprint">
         * import vegas.string.HTMLStringFormatter ;
         * 
         * var s:String = HTMLStringFormatter.paragraph("hello world") ;
         * trace("paragraph : " + s) ; // paragraph : &lt;p&gt;hello world&lt;/p&gt;
         * 
         * var s:String = HTMLStringFormatter.paragraph("hello world", "myStyle") ;
         * trace("paragraph : " + s) ; // paragraph : &lt;p class=&quot;myStyle&quot;&gt;hello world&lt;/p&gt;
         * </pre>
         * @param str the string to be formatted.
         * @param style (optional) the style class name of the tag.
         * @return the string formatted with the method.
         */
        public static function paragraph( str:String, style:String=null ):String
        {
            var s:String = '<p' ;
            if ( style != null )
            {
                s += ' class=\"' + style + '\"' ;
            } ;
            s += '>' ;
            s += str + '</p>' ;
            return s ;
        }

        /**
         * Use the small method to format and display a string in a document.
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function small( str:String ):String
        {
            return "<small>" + str + "</small>" ;
        }

        /**
         * Creates an HTML span string in a document.
         * <pre class="prettyprint">
         * import vegas.string.HTMLStringFormatter ;
         * 
         * var sP:String = HTMLStringFormatter.span("hello world") ;
         * trace("span : " + sP) ; // span : &lt;span&gt;hello world&lt;/span&gt;
         * 
         * var sP:String = HTMLStringFormatter.span("hello world", "myStyle") ;
         * trace("span : " + sP) ; // span : &lt;span class=&quot;myStyle&quot;&gt;hello world&lt;/span&gt;
         * </pre>
         * @param str the string to be formatted.
         * @param style (optional) the style class name of the tag.
         * @return the string formatted with the method.
         */
        public static function span( str:String, style:String=null ):String
        {
            var s:String = '<span' ;
            if ( style != null )
            {
                s += ' class=\"' + style + '\"' ;
            } ;
            s += '>' ;
            s += str + '</span>' ;
            return s ;
        }

        /**
         * Use the strike method to format and display a string in a document.
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function strike( str:String ):String
        {
            return "<strike>" + str + "</strike>" ;
        }
        
        /**
         * Use the sub method to format and display a string in a document.
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function sub( str:String ):String
        {
             return "<sub>" + str + "</sub>" ;
        }
        
        /**
         * Use the sup method to format and display a string in a document.
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function sup( str:String ):String
        {
            return "<sup>" + str + "</sup>" ;
        }

        /**
         * Use the underline method to format and display a string in a document.
         * <pre class="prettyprint">
         * import vegas.string.HTMLStringFormatter ;
         * var s:String = HTMLStringFormatter.underline("hello world") ;
         * trace("underline : " + s) ; // underline : &lt;u&gt;hello world&lt;/u&gt;
         * </pre>
         * @param str the string to be formatted.
         * @return the string formatted with the method.
         */
        public static function underline( str:String ):String
        {
            return "<u>" + str + "</u>" ;
        }
        
        
    }
}