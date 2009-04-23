#!/usr/bin/perl

my $N = 8;
my $archivo_string='gamefile =[';
my @tipos = ('forward','inverse');
my @orientaciones =('right','left');
my $trial = '{"nro_flechas":15, "nro_tries":3,"tries":[';
for (my $i=0;$i<=$N;$i++){

    $archivo_string = $archivo_string.$trial;
    
    for (my $j = 0; $j<=2;$j++){
        $archivo_string = $archivo_string.'[';
        for(my $k = 0; $k<=14;$k++){
            my $tiempo = int(2000 - $i/$N*1400);
            my $kind = $tipos[int(rand()>(1-$i/$N*0.7))];
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

open(OUT,">control_gamefile.txt") or die("nop pude");
print OUT $archivo_string;
close OUT;


