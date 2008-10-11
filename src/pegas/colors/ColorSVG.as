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

package pegas.colors 
{
    import vegas.data.map.HashMap;		

    /**
	 * All SVG W3C standard colors. 
	 * Basic W3C SVG colors : <a href='http://www.w3.org/TR/css3-color/'>4.3. SVG color keywords</a>. 
	 * Scalable Vector Graphics Color Names : <a href='http://www.december.com/html/spec/colorsvg.html'>http://www.december.com/html/spec/colorsvg.html</a>
	 * <p><b>Example :</b></p>
	 * <pre class="prettyprint">
	 * import pegas.colors.ColorSVG ;
	 * 
	 * var c:ColorSVG ;
	 * 
	 * c = ColorSVG.ALICE_BLUE ;
	 * trace(c.toString() + " : " + c.valueOf()) ;
	 * 
	 * trace( "---------" ) ;
	 * 
	 * c  = ColorSVG.YELLOW ;
	 * trace(c.toString() + " : " + c.toString(true)) ;
	 * 
	 * trace( "---------" ) ;
	 * 
	 * var c1:ColorSVG = ColorSVG.PURPLE ;
	 * var c2:ColorSVG = ColorSVG.get("purple") ;
	 * 
	 * trace( c1 == c2 ) ; // true
	 * 
	 * trace( "---------" ) ;
	 * 
	 * trace( "contains 'YELLOW' : " + ColorSVG.contains( ColorSVG.YELLOW ) ) ;
	 * trace( "contains 'yellow' : " + ColorSVG.contains( "yellow" ) ) ;
	 * 
	 * trace("---------") ;
	 * 
	 * trace( "ColorSVG.ELEMENTS size : " + ColorSVG.ELEMENTS.size() ) ;
	 * trace( "ColorSVG.ELEMENTS      : "      + ColorSVG.ELEMENTS ) ;
	 * </pre>
	 * @author eKameleon
 	 */
	public class ColorSVG extends ColorHTML 
	{

		/**
		 * Creates a new ColorSVG instance.
		 * @param n the value hex of the color.
		 * @param the name of the color.
		 */
		public function ColorSVG( value:Number , name:String )
		{
			super( value, name ) ;
			ELEMENTS.put( name.toLowerCase(), this ) ;
		}
		
		/**
		 * The Map of all SVG colors.
		 */
		public static var ELEMENTS:HashMap = new HashMap() ;
		
		/**
		 * The 'AliceBlue' SVG color object.
		 */
		public static const ALICE_BLUE:ColorSVG    = new ColorSVG(0xF0F8FF , "AliceBlue") ;

		/**
		 * The 'AntiqueWhite' SVG color object.
		 */
		public static const ANTIQUE_WHITE:ColorSVG = new ColorSVG(0xFAEBD7 , "AntiqueWhite") ;

		/**
		 * The 'Aqua' SVG color object.
		 */
		public static const AQUA:ColorSVG = new ColorSVG(0x00FFFF , "Aqua") ;

		/**
		 * The 'AquaMarine' SVG color object.
		 */
		public static const AQUA_MARINE:ColorSVG = new ColorSVG(0x00FFFF , "AquaMarine") ;

		/**
		 * The 'Azure' SVG color object.
		 */
		public static const AZURE:ColorSVG = new ColorSVG(0xF0FFFF, "Azure") ;

		/**
		 * The 'Beige' SVG color object.
		 */
		public static const BEIGE:ColorSVG = new ColorSVG(0xF5F5DC, "Beige") ;

		/**
		 * The 'Bisque' SVG color object.
		 */
		public static const BISQUE:ColorSVG = new ColorSVG(0xFFE4C4, "Bisque") ;

		/**
		 * The 'Black' SVG color object.
		 */
		public static const BLACK:ColorSVG = new ColorSVG(0x000000 , "Black") ;

		/**
		 * The 'BlancheDalmond' SVG color object.
		 */
		public static const BLANCHE_DALMOND:ColorSVG = new ColorSVG(0xFFEBCD, "BlancheDalmond") ;

		/**
		 * The 'Blue' SVG color object.
		 */
		public static const BLUE:ColorSVG = new ColorSVG(0x0000FF , "Blue") ;

		/**
		 * The 'BlueViolet' SVG color object.
		 */
		public static const BLUE_VIOLET:ColorSVG = new ColorSVG(0x8A2BE2 , "BlueViolet") ;

		/**
		 * The 'Brown' SVG color object.
		 */
		public static const BROWN:ColorSVG = new ColorSVG(0xA52A2A, "Brown") ;

		/**
		 * The 'BurlyWood' SVG color object.
		 */
		public static const BURLY_WOOD:ColorSVG = new ColorSVG(0xDEB887, "BurlyWood") ;

		/**
		 * The 'CadetBlue' SVG color object.
		 */
		public static const CADET_BLUE:ColorSVG = new ColorSVG(0x5F9EA0, "CadetBlue") ;
	
		/**
		 * The 'Chartreuse' SVG color object.
		 */
		public static const CHARTREUSE:ColorSVG = new ColorSVG(0x7FFF00, "Chartreuse") ;

		/**
		 * The 'Chocolate' SVG color object.
		 */
		public static const CHOCOLATE:ColorSVG = new ColorSVG(0xD2691E, "Chocolate") ;
	
		/**
		 * The 'Coral' SVG color object.
		 */	
		public static const CORAL:ColorSVG = new ColorSVG(0xFF7F50, "Coral") ;

		/**
		 * The 'CornFlowerBlue' SVG color object.
		 */	
		public static const CORN_FLOWER_BLUE:ColorSVG = new ColorSVG(0x6495ED , "CornFlowerBlue") ;

		/**
		 * The 'CornSilk' SVG color object.
		 */	
		public static const CORN_SILK:ColorSVG = new ColorSVG(0xFFF8DC, "CornSilk") ;

		/**
		 * The 'CrimSon' SVG color object.
		 */
		public static const CRIMSON:ColorSVG = new ColorSVG(0xDC143C, "CrimSon") ;

		/**
		 * The 'Cyan' SVG color object.
		 */
		public static const CYAN:ColorSVG = new ColorSVG(0x00FFFF, "Cyan") ;

		/**
		 * The 'Darkblue' SVG color object.
		 */
		public static const DARK_BLUE:ColorSVG = new ColorSVG(0x00008B, "Darkblue") ;

		/**
		 * The 'DarkCyan' SVG color object.
		 */
		public static const DARK_CYAN:ColorSVG = new ColorSVG(0x0008B8B , "DarkCyan") ;

		/**
		 * The 'DarkGoldenRod' SVG color object.
		 */
		public static const DARK_GOLDEN_ROD:ColorSVG = new ColorSVG(0xB8860B, "DarkGoldenRod") ;

		/**
		 * The 'DarkGray' SVG color object.
		 */
		public static const DARK_GRAY:ColorSVG = new ColorSVG(0xA9A9A9, "DarkGray") ;
	
		/**
		 * The 'DarkGreen' SVG color object.
		 */
		public static const DARK_GREEN:ColorSVG = new ColorSVG(0x006400, "DarkGreen") ;

		/**
		 * The 'DarkGrey' SVG color object.
		 */
		public static const DARK_GREY:ColorSVG = new ColorSVG(0xA9A9A9, "DarkGrey") ;

		/**
		 * The 'DarkKhaki' SVG color object.
		 */
		public static const DARK_KHAKI:ColorSVG = new ColorSVG(0xBDB76B, "DarkKhaki") ;

		/**
		 * The 'DarkMagenta' SVG color object.
		 */
		public static const DARK_MAGENTA:ColorSVG = new ColorSVG(0x8B008B, "DarkMagenta") ;

		/**
		 * The 'DarkOliveGreen' SVG color object.
		 */
		public static const DARK_OLIVE_GREEN:ColorSVG = new ColorSVG(0x556B2F, "DarkOliveGreen") ;

		/**
		 * The 'DarkOrange' SVG color object.
		 */
		public static const DARK_ORANGE:ColorSVG = new ColorSVG(0xFF8C00, "DarkOrange") ;

		/**
		 * The 'DarkOrchid' SVG color object.
		 */
		public static const DARK_ORCHID:ColorSVG = new ColorSVG(0x9932CC, "DarkOrchid") ;

		/**
		 * The 'DarkRed' SVG color object.
		 */
		public static const DARK_RED:ColorSVG = new ColorSVG(0x8b0000, "DarkRed") ;

		/**
		 * The 'DarkSalmon' SVG color object.
		 */
		public static const DARK_SALMON:ColorSVG = new ColorSVG(0xE9967A, "DarkSalmon") ;

		/**
		 * The 'DarkSeaGreen' SVG color object.
		 */
		public static const DARK_SEA_GREEN:ColorSVG = new ColorSVG(0x8FBC8F, "DarkSeaGreen") ;
	
		/**
		 * The 'DarkSlateBlue' SVG color object.
		 */
		public static const DARK_SLATE_BLUE:ColorSVG = new ColorSVG(0x483F8B, "DarkSlateBlue") ;

		/**
		 * The 'DarkSlateGray' SVG color object.
		 */		
		public static const DARK_SLATE_GRAY:ColorSVG = new ColorSVG(0x2F4F4F, "DarkSlateGray") ;

		/**
		 * The 'DarkSlateGrey' SVG color object.
		 */		
		public static const DARK_SLATE_GREY:ColorSVG = new ColorSVG(0x2F4F4F, "DarkSlateGrey") ;

		/**
		 * The 'DarkTurquoise' SVG color object.
		 */		
		public static const DARK_TURQUOISE:ColorSVG = new ColorSVG(0x00CED1, "DarkTurquoise") ;
		
		/**
		 * The 'DarkViolet' SVG color object.
		 */
		public static const DARK_VIOLET:ColorSVG = new ColorSVG(0x9400D3, "DarkViolet") ;
		
		/**
		 * The 'DeepPink' SVG color object.
		 */		
		public static const DEEP_PINK:ColorSVG = new ColorSVG(0xff1493, "DeepPink") ;

		/**
		 * The 'DeepSkyBlue' SVG color object.
		 */		
		public static const DEEP_SKY_BLUE:ColorSVG = new ColorSVG(0x00bfff, "DeepSkyBlue") ;

		/**
		 * The 'DimGray' SVG color object.
		 */		
		public static const DIM_GRAY:ColorSVG = new ColorSVG(0x696969, "DimGray") ;

		/**
		 * The 'DimGrey' SVG color object.
		 */		
		public static const DIM_GREY:ColorSVG = new ColorSVG(0x696969, "DimGrey") ;

		/**
		 * The 'DodgerBlue' SVG color object.
		 */		
		public static const DODGER_BLUE:ColorSVG = new ColorSVG(0x1e90ff, "DodgerBlue") ;
		
		/**
		 * The 'FireBrick' SVG color object.
		 */
		public static const FIRE_BRICK:ColorSVG = new ColorSVG(0xb22222, "FireBrick") ;

		/**
		 * The 'FloralWhite' SVG color object.
		 */
		public static const FLORAL_WHITE:ColorSVG = new ColorSVG(0xfffaf0, "FloralWhite") ;

		/**
		 * The 'ForestGreen' SVG color object.
		 */		
		public static const FOREST_GREEN:ColorSVG = new ColorSVG(0x228b22, "ForestGreen") ;

		/**
		 * The 'Fuchsia' SVG color object.
		 */
		public static const FUCHSIA:ColorSVG = new ColorSVG(0xff00ff , "Fuchsia") ;
		
		/**
		 * The 'Gainsboro' SVG color object.
		 */
		public static const GAINSBORO:ColorSVG = new ColorSVG(0xdcdcdc, "Gainsboro") ;

		/**
		 * The 'GhostWhite' SVG color object.
		 */
		public static const GHOST_WHITE:ColorSVG = new ColorSVG(0xf8f8ff, "GhostWhite") ;

		/**
		 * The 'Gold' SVG color object.
		 */
		public static const GOLD:ColorSVG = new ColorSVG(0xffd700, "Gold") ;

		/**
		 * The 'GoldEnRod' SVG color object.
		 */		
		public static const GOLD_EN_ROD:ColorSVG = new ColorSVG(0xdaa520, "GoldEnRod") ;

		/**
		 * The 'Gray' SVG color object.
		 */		
		public static const GRAY:ColorSVG = new ColorSVG(0x808080 , "Gray") ;

		/**
		 * The 'Grey' SVG color object.
		 */		
		public static const GREY:ColorSVG = new ColorSVG(0x808080, "Grey") ;

		/**
		 * The 'Green' SVG color object.
		 */		
		public static const GREEN:ColorSVG = new ColorSVG(0x008000 , "Green") ;

		/**
		 * The 'GreenYellow' SVG color object.
		 */	
		public static const GREEN_YELLOW:ColorSVG = new ColorSVG(0xadff2f, "GreenYellow") ;

		/**
		 * The 'HoneyDew' SVG color object.
		 */		
		public static const HONEY_DEW:ColorSVG = new ColorSVG(0xf0fff0, "HoneyDew") ;

		/**
		 * The 'HotPink' SVG color object.
		 */		
		public static const HOT_PINK:ColorSVG = new ColorSVG(0xff69b4, "HotPink") ;

		/**
		 * The 'IndianRed' SVG color object.
		 */		
		public static const INDIAN_RED:ColorSVG = new ColorSVG(0xcd5c5c, "IndianRed") ;

		/**
		 * The 'Indigo' SVG color object.
		 */		
		public static const INDIGO:ColorSVG = new ColorSVG(0x4b0082, "Indigo") ;

		/**
		 * The 'Ivory' SVG color object.
		 */		
		public static const IVORY:ColorSVG = new ColorSVG(0xfffff0, "Ivory") ;

		/**
		 * The 'Khaki' SVG color object.
		 */		
		public static const KHAKI:ColorSVG = new ColorSVG(0xf0e68c, "Khaki") ;

		/**
		 * The 'Lavender' SVG color object.
		 */		
		public static const LAVENDER:ColorSVG = new ColorSVG(0xe6e6fa, "Lavender") ;

		/**
		 * The 'LavenderBlush' SVG color object.
		 */		
		public static const LAVENDER_BLUSH:ColorSVG = new ColorSVG(0xfff0f5, "LavenderBlush") ;

		/**
		 * The 'LawnGreen' SVG color object.
		 */		
		public static const LAWN_GREEN:ColorSVG = new ColorSVG(0x7cfc00, "LawnGreen") ;

		/**
		 * The 'LemonChiffon' SVG color object.
		 */		
		public static const LEMON_CHIFFON:ColorSVG = new ColorSVG(0xfffacd, "LemonChiffon") ;

		/**
		 * The 'LightBlue' SVG color object.
		 */		
		public static const LIGHT_BLUE:ColorSVG = new ColorSVG(0xadd8e6, "LightBlue") ;

		/**
		 * The 'LightCoral' SVG color object.
		 */		
		public static const LIGHT_CORAL:ColorSVG = new ColorSVG(0xf08080, "LightCoral") ;

		/**
		 * The 'LightCyan' SVG color object.
		 */		
		public static const LIGHT_CYAN:ColorSVG = new ColorSVG(0xe0ffff, "LightCyan") ;

		/**
		 * The 'LightGoldenRodYellow' SVG color object.
		 */		
		public static const LIGHT_GOLDEN_ROD_YELLOW:ColorSVG = new ColorSVG(0xfafad2, "LightGoldenRodYellow") ;

		/**
		 * The 'LightGray' SVG color object.
		 */			
		public static const LIGHT_GRAY:ColorSVG = new ColorSVG(0xd3d3d3, "LightGray") ;

		/**
		 * The 'LightGreen' SVG color object.
		 */		
		public static const LIGHT_GREEN:ColorSVG = new ColorSVG(0x90ee90, "LightGreen") ;

		/**
		 * The 'LightGrey' SVG color object.
		 */		
		public static const LIGHT_GREY:ColorSVG = new ColorSVG(0xd3d3d3, "LightGrey") ;

		/**
		 * The 'LightPink' SVG color object.
		 */		
		public static const LIGHT_PINK:ColorSVG = new ColorSVG(0xffb6c1, "LightPink") ;

		/**
		 * The 'LightSalmon' SVG color object.
		 */		
		public static const LIGHT_SALMON:ColorSVG = new ColorSVG(0xffa07a, "LightSalmon") ;

		/**
		 * The 'LightSeaGreen' SVG color object.
		 */		
		public static const LIGHT_SEA_GREEN:ColorSVG = new ColorSVG(0x20b2aa, "LightSeaGreen") ;

		/**
		 * The 'LightSkyBlue' SVG color object.
		 */		
		public static const LIGHT_SKY_BLUE:ColorSVG = new ColorSVG(0x87cefa, "LightSkyBlue") ;

		/**
		 * The 'LightSlateGray' SVG color object.
		 */		
		public static const LIGHT_SLATE_GRAY:ColorSVG = new ColorSVG(0x778899, "LightSlateGray") ;

		/**
		 * The 'LightSlateGrey' SVG color object.
		 */			
		public static const LIGHT_SLATE_GREY:ColorSVG = new ColorSVG(0x778899, "LightSlateGrey") ;

		/**
		 * The 'LightSteelBlue' SVG color object.
		 */			
		public static const LIGHT_STEEL_BLUE:ColorSVG = new ColorSVG(0xb0c4de, "LightSteelBlue") ;

		/**
		 * The 'LightYellow' SVG color object.
		 */	
		public static const LIGHT_YELLOW:ColorSVG = new ColorSVG(0xffffe0, "LightYellow") ;

		/**
		 * The 'Lime' SVG color object.
		 */	
		public static const LIME:ColorSVG = new ColorSVG(0x00FF00 , "Lime") ;

		/**
		 * The 'LimeGreen' SVG color object.
		 */	
		public static const LIME_GREEN:ColorSVG = new ColorSVG(0x32cd32, "LimeGreen") ;

		/**
		 * The 'Linen' SVG color object.
		 */		
		public static const LINEN:ColorSVG = new ColorSVG(0xfaf0e6, "Linen") ;

		/**
		 * The 'Magenta' SVG color object.
		 */		
		public static const MAGENTA:ColorSVG = new ColorSVG(0xff00ff, "Magenta") ;

		/**
		 * The 'Maroon' SVG color object.
		 */		
		public static const MAROON:ColorSVG = new ColorSVG(0x800000 , "Maroon") ;

		/**
		 * The 'MediumAquaMarine' SVG color object.
		 */		
		public static const MEDIUM_AQUA_MARINE:ColorSVG = new ColorSVG(0x66cdaa, "MediumAquaMarine") ;

		/**
		 * The 'MediumBlue' SVG color object.
		 */	
		public static const MEDIUM_BLUE:ColorSVG = new ColorSVG(0x0000cd, "MediumBlue") ;

		/**
		 * The 'MediumOrchid' SVG color object.
		 */	
		public static const MEDIUM_ORCHID:ColorSVG = new ColorSVG(0xba55d3, "MediumOrchid") ;

		/**
		 * The 'MediumPurple' SVG color object.
		 */	
		public static const MEDIUM_PURPLE:ColorSVG = new ColorSVG(0x9370db, "MediumPurple") ;

		/**
		 * The 'MediumSeaGreen' SVG color object.
		 */	
		public static const MEDIUM_SEA_GREEN:ColorSVG = new ColorSVG(0x3cb371, "MediumSeaGreen") ;

		/**
		 * The 'MediumSlateBlue' SVG color object.
		 */
		public static const MEDIUM_SLATE_BLUE:ColorSVG = new ColorSVG(0x7b68ee, "MediumSlateBlue") ;

		/**
		 * The 'MediumSpringGreen' SVG color object.
		 */
		public static const MEDIUM_SPRING_GREEN:ColorSVG = new ColorSVG(0x00fa9a, "MediumSpringGreen") ;

		/**
		 * The 'MediumTurquoise' SVG color object.
		 */
		public static const MEDIUM_TURQUOISE:ColorSVG = new ColorSVG(0x48d1cc, "MediumTurquoise") ;

		/**
		 * The 'MediumVioletRed' SVG color object.
		 */
		public static const MEDIUM_VIOLET_RED:ColorSVG = new ColorSVG(0xc71585, "MediumVioletRed") ;

		/**
		 * The 'MidnightBlue' SVG color object.
		 */
		public static const MIDNIGHT_BLUE:ColorSVG = new ColorSVG(0x191970, "MidnightBlue") ;

		/**
		 * The 'MintCream' SVG color object.
		 */
		public static const MINT_CREAM:ColorSVG = new ColorSVG(0xf5fffa, "MintCream") ;

		/**
		 * The 'MistyRose' SVG color object.
		 */
		public static const MISTY_ROSE:ColorSVG = new ColorSVG(0xffe4e1, "MistyRose") ;

		/**
		 * The 'Moccasin' SVG color object.
		 */
		public static const MOCCASIN:ColorSVG = new ColorSVG(0xffe4b5, "Moccasin") ;

		/**
		 * The 'NavajoWhite' SVG color object.
		 */
		public static const NAVAJO_WHITE:ColorSVG = new ColorSVG(0xffdead, "NavajoWhite") ;

		/**
		 * The 'Navy' SVG color object.
		 */		
		public static const NAVY:ColorSVG = new ColorSVG( 0x000080 , "Navy") ;

		/**
		 * The 'None' SVG color object.
		 */	
		public static const NONE:ColorSVG = new ColorSVG( 0x000000 , "None") ;

		/**
		 * The 'LodLace' SVG color object.
		 */	
		public static const OLD_LACE:ColorSVG = new ColorSVG(0xfdf5e6, "LodLace") ;

		/**
		 * The 'Olive' SVG color object.
		 */	
		public static const OLIVE:ColorSVG = new ColorSVG(0x808000 , "Olive") ;

		/**
		 * The 'OliveDrab' SVG color object.
		 */	
		public static const OLIVE_DRAB:ColorSVG = new ColorSVG(0x6b8e23, "OliveDrab") ;

		/**
		 * The 'Orange' SVG color object.
		 */	
		public static const ORANGE:ColorSVG = new ColorSVG(0xffa500, "Orange") ;

		/**
		 * The 'OrangeRed' SVG color object.
		 */	
		public static const ORANGE_RED:ColorSVG = new ColorSVG(0xff4500, "OrangeRed") ;

		/**
		 * The 'Orchid' SVG color object.
		 */	
		public static const ORCHID:ColorSVG = new ColorSVG(0xda70d6, "Orchid") ;

		/**
		 * The 'PaleGoldenRod' SVG color object.
		 */	
		public static const PALE_GOLDEN_ROD:ColorSVG = new ColorSVG(0xeee8aa, "PaleGoldenRod") ;

		/**
		 * The 'PaleGreen' SVG color object.
		 */	
		public static const PALE_GREEN:ColorSVG = new ColorSVG(0x98fb98, "PaleGreen") ;

		/**
		 * The 'PaleTurquoise' SVG color object.
		 */	
		public static const PALE_TURQUOISE:ColorSVG = new ColorSVG(0xafeeee, "PaleTurquoise") ;

		/**
		 * The 'PaleVioletRed' SVG color object.
		 */	
		public static const PALE_VIOLET_RED:ColorSVG = new ColorSVG(0xdb7093, "PaleVioletRed") ;

		/**
		 * The 'PapayaWhip' SVG color object.
		 */	
		public static const PAPAYA_WHIP:ColorSVG = new ColorSVG(0xffefd5, "PapayaWhip") ;

		/**
		 * The 'PeachPuff' SVG color object.
		 */	
		public static const PEACHPUFF:ColorSVG = new ColorSVG(0xffdab9, "PeachPuff") ;

		/**
		 * The 'Peru' SVG color object.
		 */	
		public static const PERU:ColorSVG = new ColorSVG(0xcd853f, "Peru") ;

		/**
		 * The 'Pink' SVG color object.
		 */	
		public static const PINK:ColorSVG = new ColorSVG(0xffc0cb, "Pink") ;

		/**
		 * The 'Plum' SVG color object.
		 */	
		public static const PLUM:ColorSVG = new ColorSVG(0xdda0dd, "Plum") ;

		/**
		 * The 'PowderBlue' SVG color object.
		 */	
		public static const POWDER_BLUE:ColorSVG = new ColorSVG(0xb0e0e6, "PowderBlue") ;

		/**
		 * The 'Purple' SVG color object.
		 */	
		public static const PURPLE:ColorSVG = new ColorSVG(0x800080 , "Purple") ;

		/**
		 * The 'Red' SVG color object.
		 */	
		public static const RED:ColorSVG = new ColorSVG(0xFF0000 , "Red") ;

		/**
		 * The 'RosyBrown' SVG color object.
		 */	
		public static const ROSY_BROWN:ColorSVG = new ColorSVG(0xbc8f8f, "RosyBrown") ;

		/**
		 * The 'RoyalBlue' SVG color object.
		 */	
		public static const ROYAL_BLUE:ColorSVG = new ColorSVG(0x4169e1, "RoyalBlue") ;

		/**
		 * The 'SaddleBrown' SVG color object.
		 */
		public static const SADDLE_BROWN:ColorSVG = new ColorSVG(0x8b4513, "SaddleBrown") ;
	
		/**
		 * The 'Salmon' SVG color object.
		 */
		public static const SALMON:ColorSVG = new ColorSVG(0xfa8072, "Salmon") ;

		/**
		 * The 'SandyBrown' SVG color object.
		 */	
		public static const SANDY_BROWN:ColorSVG = new ColorSVG(0xf4a460, "SandyBrown") ;

		/**
		 * The 'SeaGreen' SVG color object.
		 */	
		public static const SEA_GREEN:ColorSVG = new ColorSVG(0x2e8b57, "SeaGreen") ;

		/**
		 * The 'SeaShell' SVG color object.
		 */	
		public static const SEA_SHELL:ColorSVG = new ColorSVG(0xfff5ee, "SeaShell") ;

		/**
		 * The 'Sienna' SVG color object.
		 */	
		public static const SIENNA:ColorSVG = new ColorSVG(0xa0522d, "Sienna") ;

		/**
		 * The 'Silver' SVG color object.
		 */	
		public static const SILVER:ColorSVG = new ColorSVG(0xC0C0C0 , "Silver") ;

		/**
		 * The 'SkyBlue' SVG color object.
		 */	
		public static const SKY_BLUE:ColorSVG = new ColorSVG(0x87ceeb, "SkyBlue") ;
	
		/**
		 * The 'SlateBlue' SVG color object.
		 */	
		public static const SLATE_BLUE:ColorSVG = new ColorSVG(0x6a5acd, "SlateBlue") ;

		/**
		 * The 'SlateGray' SVG color object.
		 */	
		public static const SLATE_GRAY:ColorSVG = new ColorSVG(0x708090, "SlateGray") ;

		/**
		 * The 'SlateGrey' SVG color object.
		 */	
		public static const SLATE_GREY:ColorSVG = new ColorSVG(0x708090, "SlateGrey") ;

		/**
		 * The 'Snow' SVG color object.
		 */	
		public static const SNOW:ColorSVG = new ColorSVG(0xFFFAFA, "Snow") ;

		/**
		 * The 'SpringGreen' SVG color object.
		 */
		public static const SPRING_GREEN:ColorSVG = new ColorSVG(0x00FF7F, "SpringGreen") ;

		/**
		 * The 'SteelBlue' SVG color object.
		 */
		public static const STEEL_BLUE:ColorSVG = new ColorSVG(0x4682b4, "SteelBlue") ;

		/**
		 * The 'Tan' SVG color object.
		 */
		public static const TAN:ColorSVG = new ColorSVG(0xD2B48C, "Tan") ;

		/**
		 * The 'Teal' SVG color object.
		 */
		public static const TEAL:ColorSVG = new ColorSVG(0x008080 , "Teal") ;

		/**
		 * The 'Thistle' SVG color object.
		 */
		public static const THISTLE:ColorSVG = new ColorSVG(0xD8BFD8, "Thistle") ;

		/**
		 * The 'Tomato' SVG color object.
		 */
		public static const TOMATO:ColorSVG = new ColorSVG(0xFF6347 , "Tomato") ;

		/**
		 * The 'Turquoise' SVG color object.
		 */
		public static const TURQUOISE:ColorSVG = new ColorSVG(0x40E0D0 , "Turquoise") ;

		/**
		 * The 'Violet' SVG color object.
		 */
		public static const VIOLET:ColorSVG = new ColorSVG(0xEE82EE, "Violet") ;

		/**
		 * The 'Wheat' SVG color object.
		 */
		public static const WHEAT:ColorSVG = new ColorSVG(0xF5DEB3, "Wheat") ;

		/**
		 * The 'White' SVG color object.
		 */
		public static const WHITE:ColorSVG = new ColorSVG(0xFFFFFF , "White") ;

		/**
		 * The 'WhiteSmoke' SVG color object.
		 */	
		public static const WHITE_SMOKE:ColorSVG = new ColorSVG(0xF5F5F5, "WhiteSmoke") ;

		/**
		 * The 'Yellow' SVG color object.
		 */	
		public static const YELLOW:ColorSVG = new ColorSVG(0xFFFF00 , "Yellow") ;

		/**
		 * The 'YellowGreen' SVG color object.
		 */	
		public static const YELLOW_GREEN:ColorSVG = new ColorSVG(0x9ACD32 , "YellowGreen") ;

		/**
	 	 * Returns true if the object passed in argument is in the map of ColorSVG elements.
		 * @return true if the object passed in argument is in the map of ColorSVG elements.
		 */
		public static function contains( o:* ):Boolean
		{
			if ( o is ColorSVG )
			{
				return ColorSVG.ELEMENTS.containsKey( ( o.name ).toLowerCase() ) ;
			}
			else if ( o is String )
			{
				return ColorSVG.ELEMENTS.containsKey( ( o as String ).toLowerCase() ) ;
			}
			else
			{
				return false ;	
			}
		}
	
		/**
		 * Returns the current ColorSVG reference specified with the name passed in parameter.
		 * @return the current ColorSVG reference specified with the name passed in parameter.
		 */
		public static function get( name:String ):ColorSVG 
		{
			return ColorSVG.ELEMENTS.get(name.toLowerCase()) ;
		}
		
	}

}
