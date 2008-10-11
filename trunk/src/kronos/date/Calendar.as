/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is KRON-os Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package kronos.date 
{
    import system.formatters.DateFormatter;        

    /**
     * This class contains all tools to creates a calendar.
     * @example
     * <pre class="prettyprint">
     * import asgard.date.Calendar ;
     * 
     * var c1:Calendar = new Calendar(2005, 2, 15) ;
     * trace ("c1 getTime : " + c1.getTime()) ;
     * trace ("c1 toSource : " + c1.toSource()) ;
     * var c2:Calendar = new Calendar() ;
     * 
     * trace ("-- c1 : " + c1) ;
     * trace ("-- c2 : " + c2) ;
     * 
     * trace ("> c1 after c2 : " + c1.after(c2)) ;
     * trace ("> c2 after c1 : " + c2.after(c1)) ;
     * trace ("> c1 before c2 : " + c1.before(c2)) ;
     * 
     * trace ("> c1 format : " + c1.format("dd/mm/yyyy HH' h' nn' mn' ss' s'")) ;
     * 
     * var clone:Calendar = c1.clone() ;
     * trace ("-- c1 clone : " + clone) ;
     * trace ("> c1 equals clone : " + c1.equals(clone)) ;
     * 
     * trace ("-----") ;
     * var count:Number = Calendar.getDaysInMonth(2005, 11) ;
     * trace ("> days in month 2005/12 : " + count) ;
     * var first:String = Calendar.getFirstDay(2005, 11, true) ;
     * trace ("> first day 2005/12 : " + first) ;
     * 
     * var fc:Array = Calendar.getFullMonthCalendar(2005, 11) ;
     * trace ("> full calendar 2005/12 : " + fc) ;
     * </pre>
     */
    public class Calendar
    {

        /**
         * Constant field representing Day ("D").
         */
        public static const DAY:String = "D" ;
        
        /**
         * The default (0) offset use in the getFullMonthCalendar() method.
         */
        public static const DEFAULT_FULL_MONTH_OFFSET:Number = 0 ;
        
        /**
         * Constant field representing hours ("h").
         */
        public static const HOUR:String = "h" ;
        
        /**
         * Constant field representing milliseconds ("ms").
         */
        public static const MILLISECOND:String = "ms" ;
        
        /**
         * Constant field representing minutes ("mn").
         */
        public static const MINUTE:String = "mn" ;
        
        /**
         * Constant field representing Month ("M").
         */    
        public static const MONTH:String = "M" ;
        
        /**
         * Constant field representing seconds ("s").
         */
        public static const SECOND:String = "s" ;
            
        /**
         * Constant field representing Week ("W").
         */
        public static const WEEK:String = "W" ;
        
        /**
         * Constant field representing Year ("Y").
          */
        public static const YEAR:String = "Y" ;
        
        /**
         * Constant field representing one day, in milliseconds
         */
        public static const ONE_DAY_MS:Number = 1000*60*60*24 ;

        /**
         * Adds the specified amount of time to the this instance.
         * <p>Examples :</p>
         * <pre class="prettyprint">
         * import asgard.date.Calendar ;
         *
         * var begin:Date = new Date( 2007, 5 , 14, 11, 30, 0 ) ;
         * var duration:Number = 50 ;
         * 
         * var end:Date = Calendar.add( begin, Calendar.MINUTE , 50 ) ;
         *
         * var sBegin:String   = Calendar.format(begin , "MM dd yyyy hh:nn:ss") ;
         * var sFinish:String  = Calendar.format(end   , "MM dd yyyy hh:nn:ss") ;
         * 
         * trace( "start  : " + sBegin ) ;
         * trace( "finish : " + sFinish ) ;
         * </pre>
         * @param date The Date object to perform addition on.
         * @param field The this field constant to be used for performing addition.
         * @param amount The number of units (measured in the field constant) to add to the date.
         * @return the new <code class="prettyprint">Date</code> object.
         */
        public static function add( date:Date = null , field:String=null , amount:Number=0 ):Date 
        {
            var d:Date = ( date == null ) ? new Date() : new Date( date.valueOf() ) ;  
            switch ( field ) 
            {
                case Calendar.MILLISECOND :
                {
                    d.setTime( date.getTime() + amount ) ; 
                    break ;
                }
                case Calendar.SECOND :
                {
                    d.setTime( date.getTime() + (amount * Time.SECOND) ) ;
                    break ;    
                }
                case Calendar.MINUTE :
                {
                    d.setTime( date.valueOf() + (amount * Time.MINUTE) ) ;
                    break ;
                }
                case Calendar.HOUR :
                {
                    d.setTime( date.getTime() + (amount * Time.HOUR) ) ;
                    break ;
                }
                case Calendar.DAY :
                {
                    d.setDate( date.getDate() + amount ) ;
                    break;
                }
                case Calendar.WEEK :
                {
                    d.setDate( date.getDate() + 7 ) ;
                    break;
                }
                case Calendar.MONTH :
                {
                    var newMonth:Number = d.getMonth() + amount ;
                    var years:Number = 0;
                    if (newMonth < 0) 
                    {
                        while (newMonth < 0) 
                        {
                            newMonth += 12;
                            years -= 1 ;
                        }
                    }
                    else if (newMonth > 11) 
                    {
                        while (newMonth > 11) 
                        {
                            newMonth -= 12;
                            years += 1 ;
                        }
                    }
                    d.setMonth(newMonth) ;
                    d.setFullYear(date.getFullYear() + years) ;
                    break ;
                }
                case Calendar.YEAR :
                {
                    d.setFullYear(d.getFullYear() + amount) ;
                    break;
                }
            }
            return d ;
        }

        /**
         * Indicates if the current Date object is after the time of specified Date object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import asgard.date.Calendar ;
         * 
         * var d1:Date = new Date(2005, 2, 15) ;
         * var d2:Date = new Date() ;
         * 
         * trace ("d1 : " + d1) ;
         * trace ("d2 : " + d2) ;
         * 
         * trace ("# d1 after d2  : " + Calendar.after  ( d1 , d2 ) ) ; // false
         * trace ("# d2 after d1  : " + Calendar.after  ( d2 , d1 ) ) ; // true
         * trace ("# d1 before d2 : " + Calendar.before ( d1 , d2 ) ) ; // true
         * </pre>
         * @return <code class="prettyprint">true</code> if the current Date object is after the time of specified Date object.
         */
        public static function after( currentDate:Date = null , date:Date = null ):Boolean 
        {
            currentDate = currentDate || new Date() ;
            date        = date        || new Date() ; 
            return date.valueOf() < currentDate.valueOf() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the current time of this Calendar is before the time of Calendar when; false otherwise.
         * @return <code class="prettyprint">true</code> if the current time of this Calendar is before the time of Calendar when; false otherwise. 
         */
        public static function before( currentDate:Date = null , date:Date = null ):Boolean 
        {
            currentDate = currentDate || new Date() ;
            date        = date        || new Date() ; 
            return date.valueOf() > currentDate.valueOf() ;
        }

        /**
         * Format the current Calendar date.
         * @param pattern The <code class="prettyprint">String</code> representation of the format pattern.
         * @return the format string representation of the current Calendar date.
         */
        public static function format( date:Date = null  , pattern:String="" ):String 
        {            
            return (new DateFormatter(pattern)).format( date || new Date() ) ;
        }

        /**
         * Returns the array representation of all days in the current month.
         * @param offset the day offset value between 0 and 6 to fill the calendar. The default value is 0 (Sunday). 
         * @return the array representation of all days in the current month.
         */
        public static function getCurrentFullMonthCalendar( offset:Number ):Array 
        {
            return getFullMonthCalendar( null, offset ) ;
        }
        
        /**
         * Returns the numbers of days in a specified month.
         * @param date The specified <code class="prettyprint">Date</code> object.
         * @return the numbers of days in a specified month.
         */
        public static function getDaysInMonth( date:Date = null ):Number 
        {
            date = date || new Date() ;
            var y:Number = date.getFullYear() ;
            var m:Number = date.getMonth() ;
            var monthDays:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31] ;
            if (((y%4 == 0) && !(y%100 == 0) ) || (y%400 == 0)) 
            {
                monthDays[1] = 29 ;
            }
            return monthDays[m] ;
        }
    
        /**
         * Calculates the number of days the specified date is from January 1 of the specified calendar year.
         * Passing January 1 to this function would return an offset value of zero.
         * @param date The Date for which to find the offset
         * @param calendarYear The calendar year to use for determining the offset
         * @return The number of days since January 1 of the given year
         */
        public static function getDayOffset( date:Date = null , calendarYear:Number=NaN ):Number 
        {
            date = date || new Date() ;
            var beginYear:Date = Calendar.getJan1( calendarYear ); // Find the start of the year. This will be in week 1.
            return Math.ceil( (date.getTime() - beginYear.getTime()) / Calendar.ONE_DAY_MS );
        }
        
        /**
         * Returns the first day in the specified month.
         * @param date The specified <code class="prettyprint">Date</code> object of this method. 
         * @param nameFlag The first day return value is a Number if the argument is <code class="prettyprint">false</code> or the name of the day with a string representation if the flag is <code class="prettyprint">true</code>.
         * @return the first day in the specified month.
         */
        public static function getFirstDay( date:Date = null , nameFlag:Boolean=false ):* 
        {
            date = date || new Date() ;
            var firstDay:Date = new Date( date.getFullYear(), date.getMonth()) ;
            return nameFlag ? Day.getDays()[firstDay.getDay() ] : firstDay.getDay()  ;
        }
        
        /**
         * Returns an array representation of all days in a full month. The array can begin with null values if the first day in the first week are previous days of the previous month.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import asgard.date.Calendar ;
         * var ar:Array = Calendar.getFullMonthCalendar( new Date(2007,03) , 1 ) ;
         * trace(ar) ;
         * </pre>
         * @param date (optional) The specified <code class="prettyprint">Date</code> to return the full month calendar. The default value is the current <code class="prettyprint">Date</code> object.
         * @param offset the day offset value between 0 and 6 to fill the calendar. The default value is 0 (Sunday). 
         * @return an array representation of a full month.
         */
        public static function getFullMonthCalendar( date:Date=null , offset:Number=NaN ):Array 
        {
            
            date = date || new Date() ;
            
            if (isNaN(offset))
            {
                offset = DEFAULT_FULL_MONTH_OFFSET ;
            }
            
            offset = Math.max(Math.min(offset, 6), 0) ;

            var y:Number   = date.getFullYear() ;
            var m:Number   = date.getMonth() ;
            var min:Number = ( getFirstDay ( date ) as Number) - offset ;
        
            if (min < 0)
            {
                min += 7 ;
            }
                    
            var max:Number = min + getDaysInMonth ( date ) ;
            var ar:Array = new Array () ;
            for (var i:Number = 0 ; i < max ; i++) 
            {
                var d:Number = (i - min + 1)  ;
                ar[i] = (i < min) ? null : new Date(y, m, d) ;
            }
            return ar ;
        }

        /**
         * Retrieves a Date object representing January 1 of any given year.
         * @param calendarYear    The calendar year for which to retrieve January 1
         * @return January 1 of the calendar year specified.
         */
        public static function getJan1( calendarYear:Number = NaN ):Date 
        {
            return new Date( calendarYear, 0, 1) ; 
        }
        
        /**
         * Returns the <code class="prettyprint">Date</code> of the next month of the specified <code class="prettyprint">Date</code> object.
         * @return the <code class="prettyprint">Data</code> of the next month of the specified <code class="prettyprint">Date</code> object.
         */
        public static function getNextMonth( date:Date = null ):Date
        {
            var today:Date = ( date == null ) ? new Date() : new Date( date.valueOf() ) ;  
            var thisMonth:Number = today.getMonth() ;
            if( thisMonth < 11 )
            {
                today.setMonth( thisMonth + 1 ) ;
            }
            else
            {
                today.setMonth(0);
                today.setFullYear(today.getFullYear() + 1);
            }
            return today ;
        }
        
        /**
         * Returns the <code class="prettyprint">Date</code> of the previous month of the specified <code class="prettyprint">Date</code> object.
         * @return the <code class="prettyprint">Date</code> of the previous month of the specified <code class="prettyprint">Date</code> object.
         */
        public static function getPreviousMonth( date:Date = null  ):Date
        {
            var today:Date = ( date == null ) ? new Date() : new Date( date.valueOf() ) ;  
            var thisMonth:Number = today.getMonth();
            if(thisMonth > 0)
            {
                today.setMonth(thisMonth - 1);
            }
            else
            {
                today.setMonth(11);
                today.setFullYear(today.getFullYear() - 1);
            }
            return today ;
        }

            
        /**
         * Calculates the week number for the given date. This function assumes that week 1 is the 
         * week in which January 1 appears, regardless of whether the week consists of a full 7 days.
         * The calendar year can be specified to help find what a the week number would be for a given date if the date overlaps years. 
         * For instance, a week may be considered week 1 of 2005, or week 53 of 2004. 
         * Specifying the optional calendarYear allows one to make this distinction easily.
         * @param date The date for which to find the week number
         * @param calendarYear (optional) The calendar year to use for determining the week number. Default is the calendar year of parameter "date".
         * @param weekStartsOn (optional) The integer (0-6) representing which day a week begins on. Default is 0 (for Sunday).
         * @return The week number of the given date.
         */
        public static function getWeekNumber( date:Date = null , calendarYear:Number=NaN , weekStartsOn:Number=NaN ):Number 
        {
            
            date = date || new Date() ; 
            
            if (isNaN(weekStartsOn)) 
            {
                weekStartsOn = 0 ;
            }
            if (isNaN(calendarYear)) 
            {
                calendarYear = date.getFullYear();
            }
            
            var weekNum:Number = -1 ;
            
            var jan1:Date = Calendar.getJan1(calendarYear) ;
            var jan1DayOfWeek:Number = jan1.getDay() ;
            
            var dayOffset:Number = Calendar.getDayOffset(date, calendarYear); // Days since Jan 1, Calendar Year
            
            weekNum = 1 ;
            
            if (dayOffset < 0 && dayOffset >= (-1 * jan1DayOfWeek)) 
            {
                //            
            }
            else
            {
                var testDate:Date = Calendar.getJan1(calendarYear);
                while (testDate.getTime() < date.getTime() && testDate.getFullYear() == calendarYear) 
                {
                    weekNum += 1;
                    testDate = Calendar.add(testDate, Calendar.WEEK, 1);
                }
            }
            
            return weekNum;
        };


        /**
         * Returns <code class="prettyprint">true</code> if the current or specified <code class="prettyprint">Date</code> if the last day in the current or specified month.
         * @return <code class="prettyprint">true</code> if the current or specified <code class="prettyprint">Date</code> if the last day in the current or specified month.
         */
        public static function isEndOfMonth( date:Date = null ):Boolean
        {
            var today:Date = date || new Date() ;
            var lastDate:Number = getDaysInMonth( today ) ; 
            return today.getDate().valueOf() == lastDate.valueOf() ;
        }

        /**
         * Subtracts the specified amount of time from the this instance.
         * @param date The Date object to perform subtraction on
         * @param field    The this field constant to be used for performing subtraction.
         * @param amount The number of units (measured in the field constant) to subtract from the date.
         * @return the new <code class="prettyprint">Calendar</code> object.
         */
        public static function subtract(date:Date, field:String, amount:Number):Date 
        {
            return Calendar.add(date, field, (amount*-1));
        }

        /**
         * Returns the Date reference of the "tomorrow" <code class="prettyprint">Date</code> object of the specified <code class="prettyprint">Date</code> in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace ( "toDay     : " + (new Calendar()).format("DDDD yyyy-mm-dd") ) ;
         * trace ( "tomorrow  : " + (Calendar.tomorrow()).format("DDDD yyyy-mm-dd") ) ;
         * </pre>
         * @return the Date reference of the "tomorrow" <code class="prettyprint">Date</code> object of the specified <code class="prettyprint">Date</code> in argument.
         */
        public static function tomorrow( date:Date = null ):Date
        {
            date = date || new Date() ;
            return new Date( date.valueOf() + ONE_DAY_MS ) ;
        }

        /**
         * Returns the Calendar reference of the "yesterday" <code class="prettyprint">Calendar</code> object of the specified <code class="prettyprint">Date</code> in argument.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * trace ( "yesterday : " + (Calendar.yesterday()).format("DDDD yyyy-mm-dd") ) ;
         * trace ( "toDay     : " + (new Calendar()).format("DDDD yyyy-mm-dd") ) ;
         * </pre>
         * @return the Calendar reference of the "yesterday" <code class="prettyprint">Calendar</code> object of the specified <code class="prettyprint">Date</code> in argument.
         */
        public static function yesterday ( date:Date=null ):Date
        {
            date = date || new Date() ;
            return new Date( date.valueOf() - ONE_DAY_MS ) ;
        }

    }
}

