/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):

    - Marc Alcaraz <ekameleon@gmail.com>

*/
package system.text.prettifier 
	{

        /**
         * Token style names. Corresponds to css classes.
         * @author eKameleon
         */
        public class PrettifyToken 
        	{
                
            /** 
             * Token style for a string literal.
             */
            public static const STRING:String = 'str' ;
                
            /** 
             * Token style for a keyword.
             */
            public static const KEYWORD:String = 'kwd' ;
               
            /**
             * Token style for a comment.
             */
            public static const COMMENT:String = 'com' ;
                
            /**
             * Token style for a type.
             */
            public static const TYPE:String = 'typ' ;
                
            /**
             * Token style for a literal value (e.g. 1, null, true).
             */
            public static const LITERAL:String = 'lit' ;
                
            /**
             * Token style for a punctuation string.
             */
            public static const PUNCTUATION:String = 'pun';
                
            /**  
             * Token style for a punctuation string.
             */
            public static const PLAIN:String = 'pln';
                
            /**
             * Token style for an sgml tag.
             */
            public static const TAG:String = 'tag';
             
            /**
             * Token style for a markup declaration such as a DOCTYPE.
             */
            public static const DECLARATION:String = 'dec' ;
              
            /**
             * Token style for embedded source.
             */
            public static const SOURCE:String = 'src' ;
                
            /**
             * Token style for an sgml attribute name.
             */
            public static const ATTRIB_NAME:String = 'atn' ;
                
            /**
             * Token style for an sgml attribute value.
             */
            public static const ATTRIB_VALUE:String = 'atv' ;
              
                
        	}
        
	}
