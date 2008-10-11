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
package andromeda.i18n
{
    import vegas.core.CoreObject;
    import vegas.data.map.HashMap;
    import vegas.util.Serializer;        

    /**
     * This static enumeration class defines the language code of the system on which the player is running. 
     * The language is specified as a lowercase two-letter language code from ISO 639-1. 
     * For Chinese, an additional uppercase two-letter country code from ISO 3166 distinguishes between Simplified and Traditional Chinese. 
     * The languages codes are based on the English names of the language: for example, 'hu' specifies Hungarian.
     * @example
     * <pre class="prettyprint">
     * import andromeda.i18n.Lang ;
     * 
     * trace( "Lang.ES.toString()        : " + Lang.ES.toString() ) ; // es
     * trace( "Lang.ES.valueOf()         : " + Lang.ES.valueOf() ) ; // es
     * trace( "Lang.ES.toSource()        : " + Lang.ES.toSource() ) ; // new andromeda.i18n.Lang("es","Spanish")
     * trace( "Lang.ES.label             : " + Lang.ES.label ) ; // Spanish
     * 
     * trace( "Lang.get('fr') == Lang.FR : " + ( Lang.get("fr") == Lang.FR ) ) ; // true
     * trace( "Lang.validate('fr')       : " + Lang.validate('fr') ) ; // true
     * trace( "Lang.validate( Lang.FR )  : " + Lang.validate( Lang.FR ) ) ; // true
     * 
     * trace( "Lang.LANGS                : " + Lang.LANGS ) ;
     * // {pl:pl,nl:nl,es:es,tr:tr,it:it,da:da,pt:pt,fi:fi,zh-CN:zh-CN,no:no,ja:ja,de:de,ru:ru,fr:fr,zh-TW:zh-TW,xu:xu,ko:ko,en:en,sv:sv,cs:cs,hu:hu}
     * 
     * trace( "Lang.LANGS.size()         : " + Lang.LANGS.size() ) ; // 21
     * </pre>
     * @author eKameleon
     * @see Capabilities.language
     */
    public final class Lang extends CoreObject
    {
        
        /**
         * Creates a new Lang instance.
         * @param id The lang language specified as a lowercase two-letter language code from ISO 639-1. For Chinese, an additional uppercase two-letter country code from ISO 3166 distinguishes between Simplified and Traditional Chinese.
         * @param label The English names of the language.
         */
        public function Lang( id:String , label:String )
        {
            this.label = label ;
            this.value = id ;
            put( this ) ;
        }

        /**
         * The map of all existing Lang reference in the application.
         */
        public static var LANGS:HashMap = new HashMap () ;

        /**
         * The label of the current Lang instance.
         */        
        public var label:String = null ;

        /**
         * The value of the current Lang instance.
         */        
        public var value:String = null ;
        
        /**
         * Returns a Lang instance with the specified 'id' value.
         * @return a Lang instance with the specified 'id' value.
         */
        public static function get( id:String ):Lang
        {
            return LANGS.get( id.valueOf() ) ;            
        }
        
        /**
         * Insert a new key/value entry with a passed-in Lang argument.
         */
        public static function put( lang:Lang ):*
        {
            return LANGS.put( lang.valueOf() , lang ) ;
        }
        
        /**
         * Removes the specified Lang reference in the static LANGS HashMap.
         */
        public static function remove( lang:Lang ):*
        {
            return LANGS.remove( lang.valueOf() ) ;
        }
        
        /**
         * Returns the number of Lang reference register in the static LANGE HashMap.
         * @return the number of Lang reference register in the static LANGE HashMap.
         */
        public static function size():uint
        {
            return LANGS.size() ;
        }

        /**
         * Returns the eden string representation of the object.
         * @return the eden string representation of the object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            return Serializer.getSourceOf(this, [value, label] ) ;
        }

        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public override function toString():String
        {
            return value ;
        }
        
        /**
         * Returns true if the passed value is a valid Lang reference.
         * @return true if the passed value is a valid Lang reference.
         */
        public static function validate( lang:* ):Boolean 
        {
            var s:String ;
            if ( lang is Lang )
            {
                s = (lang as Lang).toString() ;
            }
            else if ( lang is String )
            {
                s = lang ;
            }
            else
            {
                return false ;
            }
            return LANGS.getKeys().indexOf( s ) > -1 ;
        }
        
        /**
         * Returns the value of this instance.
         * @return the value of this instance.
         */
        public function valueOf():String
        {
            return value ;
        }
    
        /**
         * Indicates the 'Czech' language reference.
         */
        public static const CS:Lang = new Lang("cs", "Czech") ;

        /**
         * Indicates the 'Dasnish' language reference.
         */
        public static const DA:Lang = new Lang("da", "Danish") ;

        /**
         * Indicates the 'German' language reference.
         */
        public static const DE:Lang = new Lang("de", "German") ;

        /**
         * Indicates the 'English' language reference.
         */
        public static const EN:Lang = new Lang("en", "English") ;
        
        /**
         * Indicates the 'Spanish' language reference.
         */
        public static const ES:Lang = new Lang("es", "Spanish") ;
        
        /**
         * Indicates the 'Finnish' language reference.
         */
        public static const FI:Lang = new Lang("fi", "Finnish") ;

        /**
         * Indicates the 'French' language reference.
         */
        public static const FR:Lang = new Lang("fr", "French") ;

        /**
         * Indicates the 'Hungarian' language reference.
         */
        public static const HU:Lang = new Lang("hu", "Hungarian") ;

        /**
         * Indicates the 'Italian' language reference.
         */
        public static const IT:Lang = new Lang("it", "Italian") ;

        /**
         * Indicates the 'Japanese' language reference.
         */
        public static const JA:Lang = new Lang("ja", "Japanese") ;

        /**
         * Indicates the 'Korean' language reference.
         */
        public static const KO:Lang = new Lang("ko", "Korean") ;

        /**
         * Indicates the 'Dutch' language reference.
         */
        public static const NL:Lang = new Lang("nl", "Dutch") ;

        /**
         * Indicates the 'Norwegian' language reference.
         */
        public static const NO:Lang = new Lang("no", "Norwegian") ;

        /**
         * Indicates the 'Other/unknown' language reference.
         */
        public static const XU:Lang = new Lang("xu", "Other/unknown") ;

        /**
         * Indicates the 'Italian' language reference.
         */
        public static const PL:Lang = new Lang("pl", "Polish") ;
        
        /**
         * Indicates the 'Portuguese' language reference.
         */
        public static const PT:Lang = new Lang("pt", "Portuguese") ;

        /**
         * Indicates the 'Russian' language reference.
         */
        public static const RU:Lang = new Lang("ru", "Russian") ;

        /**
         * Indicates the 'Swedish' language reference.
         */
        public static const SV:Lang = new Lang("sv", "Swedish") ;

        /**
         * Indicates the 'Turkish' language reference.
         */
        public static const TR:Lang = new Lang("tr", "Turkish") ;

        /**
         * Indicates the 'Simplified Chinese' language reference.
         */
        public static const ZH_CN:Lang = new Lang("zh-CN", "Simplified Chinese") ;

        /**
         * Indicates the 'Traditional Chinese' language reference.
         */
        public static const ZH_TW:Lang = new Lang("zh-TW", "Traditional Chinese") ;
    
    }

}