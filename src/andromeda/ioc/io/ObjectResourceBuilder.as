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
package andromeda.ioc.io 
{
    import andromeda.config.ConfigResource;
    import andromeda.i18n.LocaleResource;    
        
    /**
     * This tool class is a helper to create an ObjectResource object with a generic object in the IoC context.
     */
    public const ObjectResourceBuilder:ObjectResourceModel = new ObjectResourceModel() ; 
    
    // default ObjectResource class in the factory.
    
    ObjectResourceBuilder.addObjectResource( null , ContextResource ) ;

    ObjectResourceBuilder.addObjectResource( ObjectResourceType.ASSEMBLY , AssemblyResource ) ;

    ObjectResourceBuilder.addObjectResource( ObjectResourceType.CONTEXT  , ContextResource  ) ;    

    ObjectResourceBuilder.addObjectResource( ObjectResourceType.CONFIG   , ConfigResource   ) ;

    ObjectResourceBuilder.addObjectResource( ObjectResourceType.I18N     , LocaleResource   ) ;
	    
    ObjectResourceBuilder.addObjectResource( ObjectResourceType.XML      , XMLResource      ) ;

}
