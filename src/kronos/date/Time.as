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
    import system.numeric.Mathematics;    

    /**
     * The <code class="prettyprint">Time</code> object is a holder for a time difference.
     * <p><code class="prettyprint">Time</code> splits a time difference (distance between two dates) into 
     * days, hours, minutes, seconds and milliseconds to offers methods to access the time difference value.</p>
     * @example
     * <pre class="prettyprint">
     * import asgard.date.Time ;
     * 
     * var time:Time ;
     * 
     * time = new Time( 12000 ) ;
     * trace( time + " : " + time.getSeconds() + " seconds" ) ;
     * trace( time + " : " + time.getMinutes(3) + " minutes" ) ;
     * 
     * trace("---") ;
     * 
     * var time1:Time = new Time( 2 , Time.DAY_FORMAT ) ;
     * 
     * trace( "days         : " + time1.inDays() ) ;
     * trace( "hours        : " + time1.inHours() ) ;
     * trace( "minutes      : " + time1.inMinutes() ) ;
     * trace( "seconds      : " + time1.inSeconds() ) ;
     * trace( "milliseconds : " + time1.inMilliSeconds() ) ;
     * 
     * trace("---") ;
     * 
     * var time2:Time = new Time( 24 , Time.HOUR_FORMAT ) ;
     * 
     * var time3:Time = time1.plus( time2 ) ; // + 24H
     * trace( "days         : " + time3.inDays() ) ;
     * trace( "hours        : " + time3.inHours() ) ;
     * trace( "minutes      : " + time3.inMinutes() ) ;
     * trace( "seconds      : " + time3.inSeconds() ) ;
     * trace( "milliseconds : " + time3.inMilliSeconds() ) ;
     * </pre>
     */
    public class Time
    {

        /**
         * Creates a new <code class="prettyprint">Time</code> instance.
         * @param timeDifference The time size of the time difference for the passed-in <code class="prettyprint">format</code>.
         * @param format (optional) "d"/"h"/"m"/"s"/"ms" for the unit of the amout, default case is "ms".
         */
        public function Time( timeDifference:Number, format:String=null )
        {
            setValue( timeDifference, format ) ;
        }
        
        /**
         * The 'day' string representation to format the unit amount time value.
         */
        public static const DAY_FORMAT:String = "d" ;

        /**
         * The 'hour' string representation to format the unit amount time value.
         */
        public static const HOUR_FORMAT:String = "h" ;
        
        /**
         * The 'minute' string representation to format the unit amount time value.
         */
        public static const MINUTE_FORMAT:String = "m" ;
        
        /**
         * The 'millisecond' string representation to format the unit amount time value.
         */
        public static const MILLISECOND_FORMAT:String = "ms" ;
        
        /**
         * The 'second' string representation to format the unit amount time value.
         */
        public static const SECOND_FORMAT:String = "ms" ;
        
        /** 
         * Factor from ms to second. 
         */
        public static const SECOND:Number = 1000;
        
        /** 
         * Factor from ms to minute.
         */
        public static const MINUTE:Number = SECOND * 60 ;
            
        /** 
         * Factor from ms to hour.
         */
        public static const HOUR:Number = MINUTE * 60 ;
            
        /** 
         * Factor from ms to day.
         */
        public static const DAY:Number = HOUR * 24 ;
        
        /** 
         * Amount of days.
         */
        public var days:Number;
        
        /**
         * Time difference in ms.
         */
        public var ms:Number;
            
        /**  
         * Amount of hours.
         */
        public var hours:Number;
        
        /**
         *  Amount of minutes.
         */
        public var minutes:Number;
        
        /**
         *  Amount of seconds.
         */
        public var seconds:Number;
        
        /** 
         * Amount of milliseconds.
         */
        public var milliSeconds:Number;
        
        /** 
         * Flag if the instance need to be evaluated by evaluate.
         */
        public var doEval:Boolean = true;    
        
        /**
         * Splits the time distance from ms (source value) into the different units.
         */
        public function evaluate():void 
        {
            var negative:int = Mathematics.sign(ms) ;
            var rest:Number = ms ;
                    
            days = rest / DAY ;
            rest -= negative * Math.floor(days) * DAY ;
                    
            hours = rest / HOUR;
            rest -= negative * Math.floor(hours) * HOUR ;
                    
            minutes = rest / MINUTE;
            rest -= negative * Math.floor(minutes) * MINUTE ;
                    
            seconds = rest / SECOND ;
            rest -= negative * Math.floor(seconds)*SECOND ;
                    
            milliSeconds = rest;
                    
            doEval = false ;
        }
    
        /**
         * Returns the amount of days are contained within the time.
         * <p>It will not round the result if you pass-in nothing.</p>
         * @param round (optional) the number of decimal spaces
         * @return The time difference in days.
         */
        public function getDays( round:Number = NaN ):Number 
        {
            if (doEval) 
            {
                evaluate() ;
            }
            return isNaN(round) ? days : Mathematics.floor(days, round) ;
        }
    
        /**
         * Returns the amount of hours are contained within the time.
         * <p>It will not round the result if you pass-in nothing.</p>
         * @param round (optional) the number of decimal spaces
         * @return The time difference in hours.
         */
        public function getHours( round:Number = NaN ):Number 
        {
            if (doEval) 
            {
                evaluate() ;
            }
            return isNaN(round) ? hours : Mathematics.floor(hours, round);
        }
    
        /**
         * Returns the amount of milliseconds are contained within the time.
         * <p>It will not round the result if you pass-in nothing.</p>
         * @param round (optional) the number of decimal spaces.
         * @return The time difference in milliseconds.
         */
        public function getMilliseconds( round:Number = NaN ):Number 
        {
            if (doEval) 
            {
                evaluate();
            }
            return isNaN(round) ? milliSeconds : Mathematics.floor(milliSeconds, round) ;
        }
        
        /**
         * Returns the amount of minutes are contained within the time.
         * <p>It will not round the result if you pass-in nothing.</p>
         * @param round (optional) the number of decimal spaces
         * @return The time difference in minutes.
         */
        public function getMinutes( round:Number = NaN ):Number 
        {
            if( doEval ) 
            {
                evaluate() ;
            }
            return isNaN(round) ? minutes :Mathematics.floor(minutes, round) ;
        }
        
        /**
         * Returns the amount of seconds are contained within the time.
         * <p>It will not round the result if you pass-in nothing.</p>
         * @param round (optional) the number of decimal spaces
         * @return The time difference in seconds
         */
        public function getSeconds( round:Number = NaN ):Number 
        {
            if (doEval) 
            {
                evaluate();
            }
            return isNaN(round) ? seconds : Mathematics.floor(seconds, round) ;
        }
    
        /**
         * Returns the time distance in days.
         * @return The time difference in days.
         */
        public function inDays():Number 
        {
            return ms / DAY ;
        }

        /**
         * Returns the time distance in hours.
         * @return The time difference in hours.
         */
        public function inHours():Number 
        {
            return ms / HOUR ;
        }
        
        /**
         * Returns the time difference in milliseconds.
         * @return the time difference in milliseconds.
         */
        public function inMilliSeconds():Number 
        {
            return ms;
        }
        
        /**
         * Returns the time distance in minutes.
         * @return The time difference in minutes.
         */
        public function inMinutes():Number 
        {
            return ms / MINUTE;
        }
            
        /**
         * Returns The time difference in seconds.
         * @return The time difference in seconds.
         */
        public function inSeconds():Number 
        {
            return ms / SECOND ;
        }
    
        /**
         * Removes the passed-in <code class="prettyprint">timeDifference</code> from the current time.
         * @param timeDifference time difference to be removed from the current time
         * @return A new instance with the resulting amount of time
         */
        public function minus( timeDifference:Time ):Time 
        {
            return new Time( ms - timeDifference.valueOf() );
        }
    
        /**
         * Adds the passed-in <code class="prettyprint">timedistance</code> to the current time.
         * @param timeDifference time difference to be added to the current time.
         * @return A new instance with the resulting amount of time.
         */
        public function plus( timeDifference:Time ):Time 
        {
            return new Time( ms + timeDifference.valueOf() );
        }    
        
        /** 
         * Sets the time of the instance.
         * 
         * <p>Uses "ms" if no format or a wrong format was passed-in.</p>
         * <p>Uses <code class="prettyprint">Number.MAX_VALUE</code> if <code class="prettyprint">Infinity</code> was passed-in.</p>
         * @param time size of the time difference for the passed-in <code class="prettyprint">format</code>
         * @param format (optional) "d"/"h"/"m"/"s"/"ms" for the unit of the amout. Default value is ms.
         */
        public function setValue( timeDifference:Number=Infinity , format:String=null ):Time 
        {
            
            if (timeDifference == Infinity) 
            {
                timeDifference = Number.MAX_VALUE ;
            }
            
            switch (format) 
            {
                case DAY_FORMAT :
                    {
                    ms = timeDifference * DAY ;
                    break;
                }
                case HOUR_FORMAT :
                    {
                    ms = timeDifference * HOUR ;
                    break;
                }
                case MINUTE_FORMAT :
                    {
                    ms = timeDifference * MINUTE ;
                    break;
                }
                case SECOND_FORMAT :
                {
                    ms = timeDifference * SECOND ;
                    break;
                }
                default : // MILLISECOND_FORMAT
                {
                    ms = timeDifference ;
                }
            }
            
            doEval = true ;
        
            return this ;
        
        }

        /**
         * Returns the value of the time distance (in ms).
         * @return The value of this object in ms.
         */
        public function valueOf():Number 
        {
            return ms;
        }
        
    }
}
