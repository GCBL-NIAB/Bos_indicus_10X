#!/usr/bin/perl

open(FILE, "$ARGV[0]");

while (my $line=<FILE>){

chomp $line;
&SCENE($line)

}









sub SCENE{


my @csk=split(/\s+/,$_[0]);


open(FILE1, "$ARGV[1]");
#my $signal=0;
my $length=0;
while (my $line1=<FILE1>){
chomp $line1;
if ($line1=~/^#/) {next;}
my @gt=split(/\s+/,$line1);
if ($gt[0] ne $csk[0]) {next;}
if ($gt[2] eq "exon") { if ($gt[3]>= $csk[1] && $gt[4]<= $csk[2]){ $length=$length+($gt[4]-$gt[3]+1);}
			elsif ($gt[3]<$csk[1] && $csk[1]< $gt[4] ){if ($gt[4]<$csk[2] ){	$start=$csk[1], $end=$gt[4];$length=$length+($gt[4]-$csk[1])+1;	}
									elsif($gt[4]>$csk[2] ) {$start=$csk[1], $end=$csk[2];$length=$length+($csk[2]-$csk[1])+1;	}
								}
			elsif( $gt[3]>$csk[1] && $gt[3]<$csk[2] && $csk[2]< $gt[4]){$start=$gt[3],$end=$csk[2];$length=$length+($csk[2]-$gt[3])+1;	}				
									
				#else {print "$_[0]\n";}
			}

}
$region=$csk[2]-$csk[1]+1;
if ($length >0){$fraction=$length/$region;}
else {$fraction=0;}
print "$_[0]\t$region\t$length\t$fraction\n";

#if($signal==0) {print "$_[0]\n";} 
return;
}



