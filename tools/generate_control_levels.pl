#!/usr/bin/perl
for ($iter_arch = 0; $iter_arch <= 6; $iter_arch++){
my $N = 8;
my $archivo_string='gamefile =[';
my @tipos = ('forward','inverse');
my @orientaciones =('right','left');
my $trial = '{"nro_flechas":30, "nro_tries":3,"tries":[';
for (my $i=0;$i<=$N;$i++){
	
	my $x;
    $archivo_string = $archivo_string.$trial;
    if ($i == 0){
         $x = 1;
	}else{
		$x = 0.6;
	}
        	
    for (my $j = 0; $j<=2;$j++){
        $archivo_string = $archivo_string.'[';
        for(my $k = 0; $k<=29;$k++){
        	my $tiempo = int(2000 - $i/$N*1400);
            my $kind = $tipos[int(rand()>$x)];
            my $posicion = int(rand()*90+1);
            my $orientacion = $orientaciones[int(rand()>0.5)];
            $archivo_string = $archivo_string."{\"kind\":\"$kind\",\"time\":$tiempo, \"posicion\": $posicion,\"orientacion\": \"$orientacion\"},";           
        }
        $archivo_string =~ s/,$//;
        $archivo_string = $archivo_string.'],';
    } 
    $archivo_string =~ s/,$//;
    $archivo_string = $archivo_string.']},';

}
$archivo_string =~ s/,$//;
$archivo_string = $archivo_string."]";

open(OUT,">control_gamefile$iter_arch.txt") or die("nop pude");
print OUT $archivo_string;
close OUT;
}

