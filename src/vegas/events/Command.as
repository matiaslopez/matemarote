/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is PEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package vegas.events 
{    import vegas.core.CoreObject;
    import vegas.core.IRunnable;
    import vegas.events.BasicEvent;
    import vegas.events.EventDispatcher;
    import vegas.events.FrontController;
    import vegas.util.Serializer;    

    /**
	 * A command is a easy entry with name and value property to launch a global command in the Commands static tool class.
	 * @author eKameleon
	 */
    public class Command extends CoreObject implements IRunnable 
    {        
		/**
		 * Creates a new Command instance.
	 	 * <p><b>Example :</b></p>
		 * <pre class="prettyprint">
		 * var c1:Command = new Command() ;
		 * var c2:Command = new Command([name:String [, value:*[, channel:String]]]) ;
		 * var c3:Command = new Command([initObject:Object]) ; 
		 * </pre>
		 * @throws ArgumentError if the optional passed-in arguments failed the initialization of the new <code class="prettyprint">Command</code> instance. 
		 */ 
        public function Command( ...arguments:Array )
        { 			if (arguments.length == 1)
			{
				var arg:* = arguments[0] ;
				if ( arg is String) 
				{
					this.name = arg as String ;
				}
				else if ( arg is Object )
				{
					if ( arg.hasOwnProperty("name") && arg["name"] is String )
					{
						this.name = arg.name ;	
					}
					else
					{
						throw new ArgumentError( toString() + CONSTRUCTOR_ERROR ) ;	
					}
								
					this.value   = arg.value   || null ;
					this.channel = arg.channel || null ;
				}
				else
				{
					throw ArgumentError(this + CONSTRUCTOR_ERROR) ;	
				}
			}
			else if (arguments.length > 2)
			{
				if ( arguments[0] is  String )
				{
					this.name = arguments[0] as String ;	
				}
				else
				{
					throw ArgumentError(this + CONSTRUCTOR_ERROR) ;	
				}
				this.value   = arguments[1] || null ;
				this.channel = arguments[2] || null ;
			}
			else
			{
				// 	
			}
        }		
		/**
		 * The internal string message used in the constructor if the constructor notify an ArgumentError.
	 	 */
		public static var CONSTRUCTOR_ERROR:String = ", you can't create this instance without 'name' definition." ;
			
		/**
	 	 * The channel of this command.
	 	 */
		public var channel:String ;
		
		/**
	 	 * The command's type name.
	 	 */
		public var name:String ;
			
		/**
	 	 * The value of this command.
	 	 */
		public var value:* ;
	
		/**
		 * Run the process of this command.
		 */
        public function run( ...arguments:Array ) : void
        {
        	if ( FrontController.getInstance( channel ).contains( name ) )
			{
				getLogger().info(this + " run : " + name + " : " + value ) ;
				EventDispatcher.getInstance( channel ).dispatchEvent( new BasicEvent( name , this, value ) ) ;
			}
			else
			{
				getLogger().warn(this + " run failed with an unknow command '" + name + "' in the Front Controller of this application.") ;
			}        }
        
        /**
		 * Returns a simple Object representation of the Commands's instance. 
		 * @return a simple Object representation of the Commands's instance.
		 */
		public function toObject():Object
		{
			return { name:name , value:value , channel:channel } ;	
		}
		
		/**
	 	 * Returns the string EDEN representation of this object.
		 * @return the string EDEN representation of this object.
		 */
		public override function toSource( indent:int = 0 ):String 
		{
			var params:Array = [ Serializer.toSource(name) , Serializer.toSource(value) , Serializer.toSource(channel) ] ;
			return Serializer.getSourceOf( this , params ) ;
		}
			
		/**
		 * Returns the string representation of this object.
		 * @return the string representation of this object.
		 */
		public override function toString():String
		{
			var txt:String = "[Command" ;
			if (name != null) 
			{
				txt += " name:" + name ;
			}
			if (channel != null) 
			{
				txt += " channel:" + channel ;
			}
			txt += "]";
			return txt ; 
		}
            }
    }
