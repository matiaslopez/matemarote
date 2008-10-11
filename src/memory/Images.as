package memory
{
	public class Images extends Object
	{
		[Embed(source="../../res/svg/grid.svg")]
		public static var grilla:Class;
		
		[Embed(source="../../res/svg/sombrillas/1.svg")]
		public static var sombrilla_1:Class;
		[Embed(source="../../res/svg/sombrillas/2.svg")]
		public static var sombrilla_2:Class;
		[Embed(source="../../res/svg/sombrillas/3.svg")]
		public static var sombrilla_3:Class;
		[Embed(source="../../res/svg/sombrillas/4.svg")]
		public static var sombrilla_4:Class;
		[Embed(source="../../res/svg/sombrillas/5.svg")]
		public static var sombrilla_5:Class;
		[Embed(source="../../res/svg/sombrillas/6.svg")]
		public static var sombrilla_6:Class;
		[Embed(source="../../res/svg/sombrillas/7.svg")]
		public static var sombrilla_7:Class;
		[Embed(source="../../res/svg/sombrillas/8.svg")]
		public static var sombrilla_8:Class;
		[Embed(source="../../res/svg/sombrillas/9.svg")]
		public static var sombrilla_9:Class;
		[Embed(source="../../res/svg/sombrillas/10.svg")]
		public static var sombrilla_10:Class;
		[Embed(source="../../res/svg/sombrillas/11.svg")]
		public static var sombrilla_11:Class;
		[Embed(source="../../res/svg/sombrillas/12.svg")]
		public static var sombrilla_12:Class;

		[Embed(source="../../res/svg/marcos/casiuncuadrado.svg")]
		public static var marco_1:Class;
		[Embed(source="../../res/svg/marcos/circulo.svg")]
		public static var marco_2:Class;
		[Embed(source="../../res/svg/marcos/circulosss.svg")]
		public static var marco_3:Class;
		[Embed(source="../../res/svg/marcos/cuadrado.svg")]
		public static var marco_4:Class;
		[Embed(source="../../res/svg/marcos/doble gota.svg")]
		public static var marco_5:Class;
		[Embed(source="../../res/svg/marcos/escudo.svg")]
		public static var marco_6:Class;
		[Embed(source="../../res/svg/marcos/escudo2.svg")]
		public static var marco_7:Class;
		[Embed(source="../../res/svg/marcos/estrella.svg")]
		public static var marco_8:Class;
		[Embed(source="../../res/svg/marcos/gota.svg")]
		public static var marco_9:Class;
		[Embed(source="../../res/svg/marcos/poligono.svg")]
		public static var marco_10:Class;
		[Embed(source="../../res/svg/marcos/raro1.svg")]
		public static var marco_11:Class;
		[Embed(source="../../res/svg/marcos/raro2.svg")]
		public static var marco_12:Class;
		
		[Embed(source="../../res/svg/fondos/playa.svg")]
		public static var fondo_1:Class;
		[Embed(source="../../res/svg/fondos/azul.svg")]
		public static var fondo_2:Class;
		[Embed(source="../../res/svg/fondos/celeste.svg")]
		public static var fondo_3:Class;
		[Embed(source="../../res/svg/fondos/gris.svg")]
		public static var fondo_4:Class;
		[Embed(source="../../res/svg/fondos/marron.svg")]
		public static var fondo_5:Class;
		[Embed(source="../../res/svg/fondos/naranja.svg")]
		public static var fondo_6:Class;
		[Embed(source="../../res/svg/fondos/rojo.svg")]
		public static var fondo_7:Class;
		[Embed(source="../../res/svg/fondos/rosa.svg")]
		public static var fondo_8:Class;
		[Embed(source="../../res/svg/fondos/verde.svg")]
		public static var fondo_9:Class;
		[Embed(source="../../res/svg/fondos/violeta.svg")]
		public static var fondo_10:Class;
		[Embed(source="../../res/svg/fondos/amarillo.svg")]
		public static var fondo_11:Class;
		[Embed(source="../../res/svg/fondos/fucsia.svg")]
		public static var fondo_12:Class;
		[Embed(source="../../res/svg/fondos/marino.svg")]
		public static var fondo_13:Class;
		
		[Embed(source="../../res/svg/estrellas/1.svg")]
		public static var estrellas_1:Class;
		[Embed(source="../../res/svg/estrellas/2.svg")]
		public static var estrellas_2:Class;
		[Embed(source="../../res/svg/estrellas/3.svg")]
		public static var estrellas_3:Class;
		[Embed(source="../../res/svg/estrellas/4.svg")]
		public static var estrellas_4:Class;
		[Embed(source="../../res/svg/estrellas/5.svg")]
		public static var estrellas_5:Class;
		[Embed(source="../../res/svg/estrellas/6.svg")]
		public static var estrellas_6:Class;
		[Embed(source="../../res/svg/estrellas/7.svg")]
		public static var estrellas_7:Class;
		[Embed(source="../../res/svg/estrellas/8.svg")]
		public static var estrellas_8:Class;
		[Embed(source="../../res/svg/estrellas/9.svg")]
		public static var estrellas_9:Class;
		[Embed(source="../../res/svg/estrellas/10.svg")]
		public static var estrellas_10:Class;
		
		[Embed(source="../../res/svg/personaje/anaparada.svg")]
		public static var personaje_1:Class;
		[Embed(source="../../res/svg/personaje/anareposera.svg")]
		public static var personaje_2:Class;
		[Embed(source="../../res/svg/personaje/onoplaya.svg")]
		public static var personaje_3:Class;
			
		
		[Embed(source="../../res/svg/lentes/lentes.svg")]
		public static var lentes_1:Class;
		
		[Embed(source="../../res/svg/baldes/2.svg")]
		public static var baldes_1:Class;
		[Embed(source="../../res/svg/baldes/4.svg")]
		public static var baldes_2:Class;
		
		
		
		public static function list(prefix:String, item_count:int):Array{
			var arr:Array = [];
			for(var i:int = 1; i<=item_count; i++){
				arr[i] = Images[prefix+'_'+i];
			}
			return arr;
		}
		
	}
}