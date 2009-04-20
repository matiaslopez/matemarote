#!/usr/bin/perl

my $N = 150;
my $archivo_string="gamefile ={\"max_incorrectas\":1, \"trials\":[";
my @tipos = ('forward','inverse');
for (my $i=0;$i<=$N;$i++){
    my $tiempo = int(2000 - $i/$N*1400);
    my $kind = $tipos[int(rand()>(1-$i/$N*0.7))];
    if ($i%30 == 0){
        $archivo_string = $archivo_string."{\"kind\":\"$kind\",\"time\":$tiempo,\"checkpoint\":true},";
    }else{
        $archivo_string = $archivo_string."{\"kind\":\"$kind\",\"time\":$tiempo},";
    }
}
$archivo_string = $archivo_string."]}";

open(OUT,">control_gamefile.txt") or die("nop pude");
print OUT $archivo_string;
close OUT;


