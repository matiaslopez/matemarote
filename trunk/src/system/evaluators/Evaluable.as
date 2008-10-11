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
    - Zwetan Kjukov <zwetan@gmail.com>
*/

package system.evaluators 
{

    /**
     * An Evaluator is a class that can interpret an object to another object.
     * <p>It's not necessary a parser, but the most common cases would be a string being evaluated to an object structure.</p>
     * <p><b>Note:</b> eval always take one and only one argument, if you need to configure the evaluator pass different arguments in the constructor.</p>
     */
	public interface Evaluable 
	{
	
		/**
		 * Evaluates the specified object.
		 */
		function eval( o:* ):* ;

	}

}
