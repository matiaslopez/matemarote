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
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/
package system.formatters 
{
    import system.Reflection;
    import system.Serializable;
    import system.numeric.Range;    

    /**
     * DateFormatter formats a given date with a specified pattern.
     * <p>Use the declared constants as placeholders for specific parts of the date-time.</p>
     * <p>All characters from 'A' to 'Z' and from 'a' to 'z' are reserved, although not all of these characters are interpreted right now.</p> 
     * <p>If you want to include plain text in the pattern put it into quotes (') to avoid interpretation.</p>
     * <p>If you want a quote in the formatted date-time, put two quotes directly after one another. For example: <code class="prettyprint"> "hh 'o''clock'"}.</p>
     * <pre class="prettyprint">
     * import system.formatter.DateFormatter ;
     * 
     * var f:DateFormatter = new DateFormatter() ;
     * 
     * f.pattern = "yyyy DDDD d MMMM - hh 'h' nn 'mn' ss 's'" ;
     * var result:String = f.format() ;
     * trace("pattern : " + f.pattern) ;
     * trace("result  : " + result) ;
     * 
     * trace("----") ;
     * 
     * f.pattern = "DDDD d MMMM yyyy" ;
     * var result:String = f.format(new Date(2005, 10, 22)) ;
     * trace("pattern : " + f.pattern) ;
     * trace("result  : " + result) ;
     * 
     * trace("----") ;
     * 
     * f.pattern = "hh 'h' nn 'mn' ss 's' tt" ;
     * trace( f.format( new Date(2008,1,21,10,15,0,0) ) ) ; // 02 h 15 mn 00 s am
     * 
     * f.pattern = "hh 'h' nn 'mn' ss 's' t" ;
     * trace( formatter.format( new Date(2008,1,21,10,15,0,0) ) ) ; // 02 h 15 mn 00 s a
     * 
     * f.pattern = "hh 'h' nn 'mn' ss 's' TT" ; // capitalize the pm expression.
     * trace( formatter.format( new Date(2008,1,21,14,15,0,0) ) ) ; // 02 h 15 mn 00 s PM
     * </pre>
     */
    public class DateFormatter implements Formattable, Serializable 
        {
        
        use namespace dateparser;
        
        /**
         * Creates a new DateFormatter instance.
         * <p>If you do not pass-in a pattern or if the passed-in one is null or undefined the constant DEFAULT_DATE_FORMAT is used ("dd.mm.yyyy HH:nn:ss").</p>
         * @param pattern (optional) the pattern describing the date and time format.
         */
        public function DateFormatter( pattern:String = "dd.mm.yyyy HH:nn:ss" )
            {
            _pattern = pattern ;
            }
        
        /**
         * Placeholder for AM/PM designator who indicates if the hour is is before or after noon in date format.
         * The output is lower-case. Examples: t -> a or p  / tt -> am or pm.
         */
        public static const AM_PM:String = "t";
        
        /**
         * Placeholder for AM/PM designator who indicates if the hour is is before or after noon in date format.
         * The output is capitalized. Examples: T -> T or P / TT -> AM or PM.
         */
        public static const CAPITAL_AM_PM:String = "T" ;
        
        /**
         * The default AM/PM designator expression.
         */
        public static var DEFAULT_AM_EXPRESSION:String = "am" ;            
        
        /**
         * The default date format pattern <code class="prettyprint">"dd.mm.yyyy HH:nn:ss"</code>.
         */
        public static const DEFAULT_DATE_FORMAT:String = "dd.mm.yyyy HH:nn:ss" ;
        
        /**
         * Placeholder for day in month as number in date format.
         */
        public static const DAY_AS_NUMBER:String = "d" ;
        
        /**
         * Placeholder for day in week as text in date format.
         */
        public static const DAY_AS_TEXT:String = "D" ;
        
        /**
         * The default AM/PM designator expression.
         */
        public static  var DEFAULT_PM_EXPRESSION:String = "pm" ;        
        
        /**
         * Placeholder for hour in am/pm (1 - 12) in date format.
         */
        public static const HOUR_IN_AM_PM:String = "h" ;
        
        /**
         * Placeholder for hour in day (0 - 23) in date format.
         */
        public static const HOUR_IN_DAY:String = "H";
        
        /**
         * Placeholder for minute in hour in date format.
         */
        public static const MINUTE:String = "n";
        
        /**
         * Placeholder for millisecond in date format.
         */
        public static const MILLISECOND:String = "S";
        
        /**
         * Placeholder for month in year as number in date format.
         */
        public static const MONTH_AS_NUMBER:String = "m";
        
        /**
          * Placeholder for month in year as text in date format.
         */
        public static const MONTH_AS_TEXT:String = "M";
        
        /**
         * Quotation beginning and ending token. 
         */
        public static const QUOTE:String = "'";
        
        /**
         * The internal range use to defined the days as text in the DateFormatter.
         */
        public static const RANGE_DAY_AS_TEXT:Range = new Range(0, 6) ;
        
        /**
         * The internal range use to defined the hours in the DateFormatter.
         */
        public static const RANGE_HOUR:Range = new Range(0, 23) ;
        
        /**
         * The internal range use to defined the minutes in the DateFormatter.
         */
        public static const RANGE_MINUTE:Range = new Range(0, 59) ;
            
        /**
         * The internal range use to defined the milliseconds in the DateFormatter.
         */
        public static const RANGE_MILLISECOND:Range = new Range(0, 999) ;
        
        /**
         * The internal range use to defined the months in the DateFormatter.
         */
        public static const RANGE_MONTH:Range = new Range(0, 11) ;
        
        /**
         * The internal range use to defined the seconds in the DateFormatter.
         */
        public static const RANGE_SECOND:Range = new Range(0, 59) ;
        
        /**
         * Placeholder for second in minute in date format.
         */
        public static const SECOND:String = "s";
        
        /**
         * Placeholder for year in date format.
         */
        public static const YEAR:String = "y";
        

        /**
         * Indicates the internal pattern of this formatter.
         */
        public function get pattern():String 
            {
            return _pattern ;
            }

        /**
         * @private
         */
        public function set pattern( expression:String ):void 
        {
            this._pattern = expression ;
        }        
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */ 
        public function clone():*
            {
            return new DateFormatter( pattern )  ;
            }
         
        /**
         * Formats the specified value.
         * <pre class="prettyprint">
         * import system.formatter.DateFormatter ;
         * 
         * var f:DateFormatter = new DateFormatter() ;
         * 
         * f.pattern = "yyyy DDDD d MMMM - hh 'h' nn 'mn' ss 's'" ;
         * var result:String = f.format() ;
         * trace("pattern : " + f.pattern) ;
         * trace("result  : " + result) ;
         * 
         * trace("----") ;
         *
         * f.pattern = "DDDD d MMMM yyyy" ;
         * var result:String = f.format(new Date(2005, 10, 22)) ;
         * trace("pattern : " + f.pattern) ;
         * trace("result  : " + result) ;
         * 
         * trace("----") ;
         * 
         * f.pattern = "hh 'h' nn 'mn' ss 's' tt" ;
         * trace( f.format( new Date(2008,1,21,10,15,0,0) ) ) ; // 02 h 15 mn 00 s am
         * 
         * f.pattern = "hh 'h' nn 'mn' ss 's' t" ;
         * trace( formatter.format( new Date(2008,1,21,10,15,0,0) ) ) ; // 02 h 15 mn 00 s a
         * 
         * f.pattern = "hh 'h' nn 'mn' ss 's' TT" ; // capitalize the pm expression.
         * trace( formatter.format( new Date(2008,1,21,14,15,0,0) ) ) ; // 02 h 15 mn 00 s PM
         * </pre>
         * @return the string representation of the formatted value. 
         */
        public function format( value:* = null ):String
            {
            
            if (pattern == null) 
                {
                return "" ;
                }
            
            var cpt:Number ;
            var ch:String ; // current character
            
            var date:Date = ( value != null && value is Date) ? (value as Date) : new Date() ;
            
            var next:int ;
            var prev:int ;            
            
            var p:String  = pattern ;
            var a:Array   = p.split("") ;
            var l:Number  = a.length ;
            var i:Number  = -1 ;
            var r:String  = "" ;

            while (++i < l) 
                {
                ch = a[i] ;
                if ( ch == DateFormatter.QUOTE ) 
                    {
                    if (a[i + 1] == DateFormatter.QUOTE) 
                        {
                        r += "'" ; 
                        i++ ;
                        }
                    next = i ;
                    while ( true ) 
                        {
                        prev = next ;
                        next = p.indexOf("'", next + 1) ;
                        if (a[next + 1] != QUOTE) break ;
                        r += p.substring(prev+1, next+1) ;
                        next++;
                        }
                    r += p.substring(prev+1, next) ;
                    i = next ;
                    } 
                else if (ch == YEAR) 
                    {
                    cpt = count(ch, a.slice(i));
                    r += formatYear( date.getFullYear(), cpt );
                    i += cpt - 1 ;
                    }
                else if (ch == MONTH_AS_NUMBER) 
                    {
                    cpt = count(ch, a.slice(i));
                    r += formatMonthAsNumber(date.getMonth(), cpt);
                    i += cpt - 1 ;
                    }
                else if (ch == MONTH_AS_TEXT) 
                    {
                    cpt = count(ch, a.slice(i));
                    r += formatMonthAsText(date.getMonth(), cpt) ;
                    i += cpt - 1 ;
                    } 
                else if (ch == DAY_AS_NUMBER) 
                    {
                    cpt = count(ch, a.slice(i)) ;
                    r += formatDayAsNumber(date.getDate(), cpt) ;
                    i += cpt - 1 ;
                    }
                else if (ch == DAY_AS_TEXT) 
                    {
                    cpt = count(ch, a.slice(i)) ;
                    r += formatDayAsText(date.getDay(), cpt) ;
                    i += cpt - 1 ;
                    } 
                else if ( ch == HOUR_IN_AM_PM ) 
                    {
                    cpt = count(ch, a.slice(i));
                    r += formatHourInAmPm(date.getHours(), cpt) ;
                    i += cpt - 1 ;
                    } 
                else if (ch == HOUR_IN_DAY) 
                    {
                    cpt = count(ch, a.slice(i));
                    r += formatHourInDay(date.getHours(), cpt) ;
                    i += cpt - 1 ;
                    } 
                else if (ch == MINUTE) 
                    {
                    cpt = count(ch, a.slice(i));
                    r += formatMinute(date.getMinutes(), cpt) ;
                    i += cpt - 1 ;
                    }
                else if (ch == SECOND) 
                    {
                    cpt = count(ch, a.slice(i));
                    r += formatSecond( date.getSeconds(), cpt ) ;
                    i += cpt - 1 ;
                    }
                else if (ch == MILLISECOND) 
                    {
                    cpt = count(ch, a.slice(i));
                    r += formatMillisecond(date.getMilliseconds(), cpt);
                    i += cpt - 1 ;
                    }
                else if ( ch == AM_PM || ch == CAPITAL_AM_PM )
                    {
                    cpt = count(ch, a.slice(i));
                    r += formatDesignator(date.getHours(), cpt, ch == CAPITAL_AM_PM );
                    i += cpt - 1 ;
                    }
                else 
                    {
                    r += ch;
                    }
                } 
            return r ;
            
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
            {
            return "new " + Reflection.getClassPath(this) + '("' + ( pattern || DEFAULT_DATE_FORMAT ) + '")' ;
            }        
        
        /**
         * The private internal dateParser namespace.
         * @private
         */
        private namespace dateparser ;
        
        /**
         * Formats the specified number day value in a string representation.
         * @return the specified numberday value in a string representation.
         */
        dateparser function formatDayAsNumber(day:Number, cpt:Number=NaN):String 
            {
            if (isNaN(cpt)) 
                {
                cpt = 0 ;
                }
            var string:String = day.toString();
            return (getZeros(cpt - string.length) + string);
            }
                
        /**
         * Formats the specified day value in a string representation.
         * @return the specified day value in a string representation.
         */
        dateparser function formatDayAsText(day:Number, cpt:Number=NaN):String 
            {
            if (RANGE_DAY_AS_TEXT.isOutOfRange(day)) 
                {
                throw new Error(this + " formatDayAsText method failed, the day value is out of range.") ;
                }
            if (isNaN(cpt)) 
                {
                cpt = 0 ;
                }
            var days:Array = Day.getDays() ;
            var r:String = days[day] ;
            if (cpt < 4) return r.substr(0, 2);
            return r ;
        }
        
        /**
         * Formats the designator AM/PM in string expression.
         * @return the specified am/pm expression representation.
         */
        dateparser function formatDesignator(hour:Number, cpt:Number, capitalize:Boolean ):String 
            {
            if (RANGE_HOUR.isOutOfRange(hour))
                {
                throw new Error(this + " formatDesignator method failed, the hour value is out of range.") ;
                }
            if (isNaN(cpt)) 
                {
                cpt = 0 ;
                }
            var s:String = ( hour > 12 ) ? DEFAULT_PM_EXPRESSION : DEFAULT_AM_EXPRESSION ;
            s = s.slice(0, cpt) ; ;
            return capitalize ? s.toUpperCase() : s.toLowerCase() ;
            }        
    
        /**
         * Formats the specified hour value in a string representation with the am-pm notation.
         * @return the specified hour value in a string representation with the am-pm notation.
         */
        dateparser function formatHourInAmPm(hour:Number, cpt:Number=NaN):String 
            {
            if (RANGE_HOUR.isOutOfRange(hour)) 
                {
                throw new Error(this + " formatHourInAmPm method failed, the hour value is out of range.") ;
                }
            if (isNaN(cpt)) 
                {
                cpt = 0 ;
                }
            var s:String ;
            if (hour == 0) 
                {
                s = (12).toString() ;
                }
            else if (hour > 12) 
                {
                s = (hour - 12).toString() ;
                }
            else 
                {
                s = hour.toString();
                }
            return (getZeros(cpt - s.length) + s);
            }
        
        /**
         * Formats an hour number in string expression.
         */
        dateparser function formatHourInDay(hour:Number, cpt:Number=NaN):String 
            {
            if (RANGE_HOUR.isOutOfRange(hour))
                {
                throw new Error(this + " formatHourInDay method failed, the hour value is out of range.") ;
                }
            if (isNaN(cpt)) 
                {
                cpt = 0 ;
                }
            var s:String = hour.toString();
            return (getZeros(cpt - s.length) + s) ;
            }
        
        /**
         * Formats a millisecond value number in string expression.
         */
        dateparser function formatMillisecond(millisecond:Number, cpt:Number=NaN):String 
            {
            if (RANGE_MILLISECOND.isOutOfRange(millisecond)) 
                {
                throw new Error(this + " formatMillisecond method failed, the millisecond value is out of range.");
                }
            if (isNaN(cpt)) 
                {
                cpt = 0 ;
                }
            var s:String = millisecond.toString();
            return (getZeros(cpt - s.length) + s) ;
            }
        
        /**
         * Formats a minute value number in string expression.
         */
        dateparser function formatMinute(minute:Number, cpt:Number=NaN):String 
            {
            if (RANGE_MINUTE.isOutOfRange(minute)) 
                {
                throw new Error(this + " formatMinute method failed, the minute value is out of range.") ;
                }
            if (isNaN(cpt)) cpt = 0 ;
            var s:String = minute.toString();
            return (getZeros(cpt - s.length) + s);
            }
        
        /**
         * Formats a month value number in string expression.
         */
        dateparser function formatMonthAsNumber(month:Number, cpt:Number=NaN):String 
            {
            if (RANGE_MONTH.isOutOfRange(month)) 
                {
                throw new Error(this + " formatMonthAsNumber method failed, the month value is out of range.") ;
                }
            if (isNaN(cpt)) 
                {
                cpt = 0 ;
                }
            var string:String = (month + 1).toString();
            return (getZeros(cpt - string.length) + string) ;
            }
        
        /**
         * Formats a month text value in string expression.
         */
        dateparser function formatMonthAsText(month:Number, cpt:Number=NaN):String 
            {
            if (RANGE_MONTH.isOutOfRange(month)) 
                {
                throw new Error(this + " formatMonthAsText method failed, the month value is out of range.") ;
                }
            if (isNaN(cpt)) cpt = 0 ;
            var r:String;
            var months:Array = Month.getMonths() ;
            r = months[month] ;
            if (cpt < 4) 
               { 
               return r.substr(0, 3);
               }
            return r;
            }
        
        /**
         * Format the second value passed in argument.
         * @return the second string representation of this DateFormatter.
         */
        dateparser function formatSecond(second:Number, cpt:Number=NaN):String 
            {
            if (RANGE_SECOND.isOutOfRange(second)) 
                {
                throw new Error(this + " formatSecond method failed, the second value is out of range.") ;
                }
            if (isNaN(cpt))
                {
                cpt = 0 ;
                }
            var s:String = second.toString() ;
            return (getZeros(cpt - s.length) + s);
            }

        /**
         * Format the year value passed in argument.
         * @return the year string representation of this DateFormatter.
         */
        dateparser function formatYear( year:Number=NaN , cpt:Number=NaN ):String 
            {
            if ( isNaN(year) ) 
                {
                throw new Error(this + " formatYear method failed, the year value must be a Number.") ;
                }    
            if (isNaN(cpt)) 
                {
                cpt = 0 ;
                }
            if (cpt < 4) 
                {
                return year.toString().substr(2) ;
                }
            return (getZeros(cpt - 4) + year.toString());
            }
                
        /**
         * Returns a string representation fill by 0 values or an empty string if the cpt value is NaN or <1.
         * @return a string representation fill by 0 values or an empty string if the cpt value is NaN or <1.
         */
        dateparser function getZeros(cpt:Number):String 
            {
            if (cpt < 1 || isNaN(cpt)) 
                {
                return "" ;
                }
            if (cpt < 2) 
                {
                return "0" ;
                }    
            var r:String = "00";
            cpt -= 2;
            while (cpt) 
                {
                r += "0" ;
                cpt-- ;
                }
            return r ;
            }
                
        /**
         * The internal pattern of this formatter.
         */
        dateparser var _pattern:String ; // pattern        
                    
        /**
         * @private
         */
        dateparser function count(char:String, a:Array):Number 
            {
            if (!a) return 0 ;
            var r:Number = 0 ;
            var i:Number = -1 ;
            var l:Number = a.length ;
            while (++i < l && a[r] == char) 
                {
                r++ ;
                }
            return r ;
            }
        
        }

    }

/**
 * This static enumeration class register all string constants to defined a month.
 */
class Month
    {

    /**
     * Fully written out string for january.
     */
    public static var JANUARY:String = "January" ;
            
    /**
     * Fully written out string for february.
     */
    public static var FEBRUARY:String = "February" ;
           
    /**
     * Fully written out string for march.
     */
    public static var MARCH:String = "March" ;
            
    /**
     * Fully written out string for april.
     */
    public static var APRIL:String = "April" ;
            
    /**
     * Fully written out string for may.
     */
    public static var MAY:String = "May" ;
    
    /**
     * Fully written out string for june.
     */
    public static var JUNE:String = "June" ;
    
    /**
     * Fully written out string for july.
     */
    public static var JULY:String = "July" ;
     
    /**
     * Fully written out string for august.
     */
    public static var AUGUST:String = "August" ;
      
    /**
     * Fully written out string for september.
     */
    public static var SEPTEMBER:String = "September" ;
        
    /**
     * Fully written out string for october.
     */
    public static var OCTOBER:String = "October" ;
        
    /**
     * Fully written out string for november.
     */
    public static var NOVEMBER:String = "November" ;
            
    /**
     * Fully written out string for december.
     */
    public static var DECEMBER:String = "December" ;
        
    /**
     * Returns the array representation of all months constants.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * trace( "days   : " + Month.getMonths() ) ;
     * </pre>
     * @return the array representation of all months constants.
     */
    public static function getMonths():Array 
        {
        return [ JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER ] ;
        }        
        
    }

/**
 * This static enumeration class register all string constants to defined a day.
 */
class Day
    {
	
    /**
     * Fully written out string for monday.
     */
    public static var MONDAY:String = "Monday" ;
       
    /**
     * Fully written out string for tuesday.
     */
    public static var TUESDAY:String = "Tuesday" ;
    
    /**
     * Fully written out string for wednesday.
     */
    public static var WEDNESDAY:String = "Wednesday" ;
    
    /**
     * Fully written out string for thursday.
     */
    public static var THURSDAY:String = "Thursday" ;
    
    /**
     * Fully written out string for friday.
     */
    public static var FRIDAY:String = "Friday" ;
    
    /**
     * Fully written out string for saturday.
     */
    public static var SATURDAY:String = "Saturday" ;
        
    /**
     * Fully written out string for sunday.
     */
    public static var SUNDAY:String = "Sunday" ;        
  
    /**
     * Returns the array representation of all days constants.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * trace( "days   : " + Day.getDays() ) ;
     * </pre>
     * @return the array representation of all days constants.
     */
    public static function getDays():Array 
        {
        return [SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY] ;
        }

    }     
